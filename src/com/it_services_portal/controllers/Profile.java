package com.it_services_portal.controllers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.it_services_portal.models.User;


public class Profile extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User currentUser = (User) request.getSession().getAttribute("currentUser");

		if(currentUser != null) {
			currentUser.retrieveUserInfo();

			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/myprofile.jsp");
			requestDispatcher.forward(request, response);
		} else {
			// An error occured with the logged in user
			response.sendRedirect(request.getContextPath() + "/logout");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
