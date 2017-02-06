package com.it_services_portal.models;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class RelatedFile implements Serializable {

	private static final long serialVersionUID = 1L;
	private int id;
	private String type;
	private String name;

	public RelatedFile() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public void uploadFile(int issueId, String name, String type) {
		try {
			DataSource dataSource = (DataSource) new InitialContext().lookup("java:/comp/env/it-portal-db");
			Connection connection = dataSource.getConnection();

			String update = "INSERT INTO file(issue_id, name, type) VALUES (?,?,?)";

			PreparedStatement statement = connection.prepareStatement(update);
			statement.setInt(1,issueId);
			statement.setString(2,name);
			statement.setString(3,type);

			statement.executeUpdate();
			statement.close();
			connection.close();
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} 
	}
	
}
