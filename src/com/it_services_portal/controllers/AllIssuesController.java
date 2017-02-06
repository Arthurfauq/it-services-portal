package com.it_services_portal.controllers;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map.Entry;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import com.it_services_portal.models.Comment;
import com.it_services_portal.models.Issue;
import com.it_services_portal.models.User;

public class AllIssuesController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User currentUser = (User) request.getSession().getAttribute("currentUser");

		if(currentUser != null) {
			currentUser.retrieveUserInfo();
			RequestDispatcher requestDispatcher;
			String redirect = "/WEB-INF/jsp/staff/";
			String pageRedirect = "";

			if(request.getParameter("action") != null) {
				String selection = request.getParameter("action");

				switch (selection) {
				case "newIssues":
					redirect += "newissues.jsp";
					break;
					
				case "unresolvedIssues":
					redirect += "unresolvedissues.jsp";
					break;

				case "resolvedIssues":
					redirect += "resolvedissues.jsp";
					break;

				case "issue":
					int issueId = Integer.parseInt(request.getParameter("id"));

					Issue issue = new Issue();
					issue.retrieveIssueInfo(issueId);

					request.setAttribute("issue", issue);
					redirect = "/WEB-INF/jsp/issue.jsp";
					break;

				default:
					redirect += "allissues.jsp";
					break;
				}
			}  else {
				pageRedirect = "allissues.jsp";
			}

			request.getSession().setAttribute("allIssues", getAllIssues());
			request.setAttribute("pageTitle", "All Issues");
			request.setAttribute("url", "staff/allIssues");

			requestDispatcher = request.getRequestDispatcher(redirect + pageRedirect);
			requestDispatcher.forward(request, response);

		} else {
			response.sendRedirect(request.getContextPath() + "/logout");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User currentUser = (User) request.getSession().getAttribute("currentUser");

		if(currentUser != null) {
			if(request.getParameter("issue-action") != null) {
				int issueId = 0;
				String commentContent = null;

				for(Entry<String, String[]> entry : request.getParameterMap().entrySet()) {
					String paramName = entry.getKey();
					String[] paramValues = entry.getValue();

					switch (paramName) {
					case "issue-id":
						issueId = Integer.parseInt(paramValues[0]);
						break;

					case "comment-content":
						commentContent = paramValues[0];
						break;
					}
				}

				Issue issue = new Issue();
				issue.retrieveIssueInfo(issueId);

				switch(request.getParameter("issue-action")) {
				case "workIssue":
					issue.setWorkingStaff(currentUser);
					issue.setState("In Progress");
					issue.update();
					request.getSession().setAttribute("alert","You are now working on this issue.");
					break;

				case "addKnowledgeBase":
					issue.setInBase(true);
					issue.update();
					request.getSession().setAttribute("alert","The issue was successfully added to the knowledge-base.");
					break;

				case "addComment":
					Comment newComment = new Comment();
					newComment.setAuthor(currentUser);
					newComment.setContent(commentContent);

					issue.addComment(newComment);
					issue.retrieveIssueComments();
					request.getSession().setAttribute("alert","Comment added successfully.");
					break;
				}
				
				request.setAttribute("issue", issue);
				response.sendRedirect(request.getContextPath() + "/staff/allIssues?action=issue&id=" + issueId);
			}
		} else {
			response.sendRedirect(request.getContextPath() + "/logout");
		}

	}

	private List<Issue> getAllIssues() {
		List<Issue> systemIssues = new ArrayList<Issue>();

		try {
			DataSource dataSource = (DataSource) new InitialContext().lookup("java:/comp/env/it-portal");

			Connection connection = dataSource.getConnection();

			String query = "SELECT * FROM issue";
			Statement statement = connection.createStatement();
			ResultSet resultSet = statement.executeQuery(query);

			while(resultSet.next()) {
				Issue issue = new Issue();
				issue.retrieveIssueInfo(resultSet.getInt("id"));

				systemIssues.add(issue);
			}

			statement.close();
			resultSet.close();
			connection.close();
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return systemIssues;
	}
}
