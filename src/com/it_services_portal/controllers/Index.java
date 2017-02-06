package com.it_services_portal.controllers;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.it_services_portal.models.User;

public class Index extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String username = request.getUserPrincipal().getName();
		User currentUser = (User) request.getSession().getAttribute("currentUser"); 

		if ((currentUser == null) || (currentUser.getUsername() != username)) {
			currentUser = new User();
			currentUser.setUsername(username);
			currentUser.retrieveUserInfo();
			
			request.getSession().setAttribute("currentUser", currentUser);
		}

		RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/home.jsp");
		requestDispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
