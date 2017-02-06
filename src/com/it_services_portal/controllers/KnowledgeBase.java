package com.it_services_portal.controllers;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import com.it_services_portal.models.Issue;
import com.it_services_portal.models.User;

public class KnowledgeBase extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getSession().setAttribute("baseIncidents", getBaseIncidents());

		User currentUser = (User) request.getSession().getAttribute("currentUser");

		if(currentUser != null) {
			RequestDispatcher requestDispatcher;
			String redirect = "/WEB-INF/jsp/";
			String pageRedirect = "";

			if(request.getParameter("action") != null) {
				String selection = request.getParameter("action");

				if(selection.equals("incident")) {
					int issueId = Integer.parseInt(request.getParameter("id"));

					Issue incident = new Issue();
					incident.retrieveIssueInfo(issueId);

					request.setAttribute("incident", incident);

					pageRedirect = "incident.jsp";
				}

			} else {
				pageRedirect = "knowledge-base.jsp";
			}

			requestDispatcher = request.getRequestDispatcher(redirect + pageRedirect);
			requestDispatcher.forward(request, response);
		} else {
			response.sendRedirect(request.getContextPath() + "/logout");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

	protected List<Issue> getBaseIncidents() {
		List<Issue> baseIncidents = new ArrayList<Issue>();

		try {
			DataSource dataSource = (DataSource) new InitialContext().lookup("java:/comp/env/it-portal");

			Connection connection = dataSource.getConnection();

			String query = "SELECT * FROM issue WHERE in_base=1";
			Statement statement = connection.createStatement();
			ResultSet resultSet = statement.executeQuery(query);

			while(resultSet.next()) {
				Issue issue = new Issue();				

				issue.setId(resultSet.getInt("id"));
				issue.setTitle(resultSet.getString("title"));
				issue.setDescription(resultSet.getString("description"));
				issue.setCategory(resultSet.getString("category"));
				issue.setDateResolved(resultSet.getTimestamp("date_resolved"));
				issue.setResolutionDetails(resultSet.getString("resolution_details"));

				baseIncidents.add(issue);
			}

			statement.close();
			resultSet.close();
			connection.close();

		} catch (NamingException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return baseIncidents;
	}

}
