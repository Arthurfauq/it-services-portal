package com.it_services_portal.controllers;

import java.io.IOException;
import java.util.List;
import java.util.Map.Entry;
import java.util.stream.Collectors;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.it_services_portal.models.Comment;
import com.it_services_portal.models.Issue;
import com.it_services_portal.models.User;

@MultipartConfig
public class MyIssuesController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User currentUser = (User) request.getSession().getAttribute("currentUser");

		if(currentUser != null) {
			currentUser.retrieveUserInfo();
			RequestDispatcher requestDispatcher;
			String redirect = "/WEB-INF/jsp/";
			String pageRedirect = "";

			if(request.getParameter("action") != null) {
				String selection = request.getParameter("action");
				switch (selection) {
				case "currentIssues":
					pageRedirect = "currentissues.jsp";
					break;

				case "resolvedIssues":
					pageRedirect = "resolvedissues.jsp";
					break;

				case "reportIssue":
					pageRedirect = "user/reportissue.jsp";
					break;

				case "issue":
					int issueId = Integer.parseInt(request.getParameter("id"));

					Issue issue = new Issue();
					issue.retrieveIssueInfo(issueId);

					request.setAttribute("issue", issue);

					// If the logged in user is the working staff of that issue
					if(request.isUserInRole("staff")) {
						if(issue.getWorkingStaff().getUsername().equals(currentUser.getUsername())) {
							redirect = "/WEB-INF/jsp/issue.jsp";
						} else {
							redirect = "/public/jsp/error403.jsp";
						}
					} else { // If the logged in user is the author of that issue
						if(issue.getAuthor().getUsername().equals(currentUser.getUsername())) {
							redirect = "/WEB-INF/jsp/issue.jsp";
						} else {
							redirect = "/public/jsp/error403.jsp";
						}
					}					
					break;

				default:
					pageRedirect = "myissues.jsp";
					break;
				}
			} else {
				pageRedirect = "myissues.jsp";
			}

			request.getSession().setAttribute("userIssues", currentUser.retrieveIssues());
			request.setAttribute("pageTitle", "My Issues");
			request.setAttribute("url", "myIssues");

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
				String solution = null;
				String commentContent = null;
				String issueTitle = null;
				String issueDescription = null;
				String issueCategory = null;

				for(Entry<String, String[]> entry : request.getParameterMap().entrySet()) {
					String paramName = entry.getKey();
					String[] paramValues = entry.getValue();

					switch (paramName) {
					case "issue-id":
						issueId = Integer.parseInt(paramValues[0]);
						break;

					case "solution":
						solution = paramValues[0];
						break;

					case "comment-content":
						commentContent = paramValues[0];
						break;

					case "issue-title":
						issueTitle = paramValues[0];
						break;

					case "issue-description":
						issueDescription = paramValues[0];
						break;

					case "issue-category":
						issueCategory = paramValues[0];
						break;
					}
				}

				Issue issue = new Issue();
				issue.retrieveIssueInfo(issueId);

				switch(request.getParameter("issue-action")) {
				case "reportIssue":
					List<Part> fileParts = request.getParts().stream().filter(part -> "issue-files".equals(part.getName())).collect(Collectors.toList());

					issue.setTitle(issueTitle);
					issue.setDescription(issueDescription);
					issue.setCategory(issueCategory);
					issue.setAuthor(currentUser);
					issue.reportIssue(fileParts, getServletContext());
					request.getSession().setAttribute("alert","A new issue was successfully reported.");
					break;

				case "addComment":
					Comment newComment = new Comment();
					newComment.setAuthor(currentUser);
					newComment.setContent(commentContent);

					issue.addComment(newComment);
					issue.retrieveIssueComments();
					request.getSession().setAttribute("alert","Comment added successfully.");
					break;


				case "sendSolution":
					issue.setSolution(solution);
					issue.setState("Completed");
					issue.update();
					request.getSession().setAttribute("alert","The solution was sent to the author.");
					break;

				case "acceptSolution":
					String decision = request.getParameterValues("decision")[0];

					if(decision.equals("accept")) {
						issue.setResolved(true);		
						request.getSession().setAttribute("alert","The issue is now resolved.");
					} else {
						issue.setSolution(null);
						issue.setState("In Progress");
						request.getSession().setAttribute("alert","Please wait for the staff to figure out a new solution.");
					}

					issue.update();
					break;
				}

				request.setAttribute("issue", issue);
				response.sendRedirect(request.getContextPath() + "/myIssues?action=issue&id=" + issue.getId());
			}
		} else {
			response.sendRedirect(request.getContextPath() + "/logout");
		}

	}



}
