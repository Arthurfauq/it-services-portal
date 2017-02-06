package com.it_services_portal.models;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class User implements Serializable {

	private static final long serialVersionUID = 1L;
	private int id;
	private String username;
	private String role;
	private String firstName;
	private String surname;
	private String email;
	private String contactNumber;
	private List<Issue> userIsues;

	public User() {
		this.userIsues = new ArrayList<Issue>();
		id = 0;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getSurname() {
		return surname;
	}

	public void setSurname(String surname) {
		this.surname = surname;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getContactNumber() {
		return contactNumber;
	}

	public void setContactNumber(String contactNumber) {
		this.contactNumber = contactNumber;
	}

	public List<Issue> getUserIsues() {
		return userIsues;
	}

	public void setUserIsues(List<Issue> userIsues) {
		this.userIsues = userIsues;
	}

	public void addIssue(Issue issue) {
		List<Issue> userIsues = getUserIsues();
		userIsues.add(issue);

		this.setUserIsues(userIsues);
	}

	public void retrieveUserInfo() {
		try {
			DataSource dataSource = (DataSource) new InitialContext().lookup("java:/comp/env/it-portal-db");
			Connection connection = dataSource.getConnection();

			String query;
			if(this.getUsername() != null) {
				query = "SELECT * FROM user WHERE username='" + this.getUsername() + "' LIMIT 1;";
			} else {
				query = "SELECT * FROM user WHERE id='" + this.getId() + "' LIMIT 1;";
			}

			Statement statement = connection.createStatement();
			ResultSet resultSet = statement.executeQuery(query);

			if(resultSet.next()) {
				this.setId(resultSet.getInt("id"));
				this.setUsername(resultSet.getString("username"));
				this.setRole(resultSet.getString("role"));
				this.setFirstName(resultSet.getString("first_name"));
				this.setSurname(resultSet.getString("surname"));
				this.setEmail(resultSet.getString("email"));
				this.setContactNumber(resultSet.getString("contact_number"));
			}

			statement.close();
			resultSet.close();
			connection.close();
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public List<Issue> retrieveIssues() {
		List<Issue> userIssues = new ArrayList<Issue>();

		try {
			DataSource dataSource = (DataSource) new InitialContext().lookup("java:/comp/env/it-portal-db");
			Connection connection = dataSource.getConnection();

			String query;
			if(this.getRole().equals("user")) {
				query = "SELECT * FROM issue WHERE user_id='" + this.getId() + "';";
			} else {
				query = "SELECT * FROM issue WHERE staff_id='" + this.getId() + "';";
			}

			Statement statement = connection.createStatement();
			ResultSet resultSet = statement.executeQuery(query);

			while(resultSet.next()) {				
				Issue issue = new Issue();
				issue.retrieveIssueInfo(resultSet.getInt("id"));

				userIssues.add(issue);
			}

			statement.close();
			resultSet.close();
			connection.close();
		} catch (SQLException | NamingException e) {
			e.printStackTrace();
		}

		return userIssues;
	}

}
