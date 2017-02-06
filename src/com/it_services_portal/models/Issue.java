package com.it_services_portal.models;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.Serializable;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletContext;
import javax.servlet.http.Part;
import javax.sql.DataSource;

public class Issue implements Serializable {

	private static final long serialVersionUID = 1L;
	private int id;
	private String title;
	private String description;
	private User author;
	private User workingStaff;
	private String category;
	private String state;
	private String resolutionDetails;
	private Date dateReported;
	private Date dateResolved;
	private String solution;
	private List<Comment> comments;
	private List<RelatedFile> relatedFiles;
	private boolean isResolved;
	private boolean isInBase;

	public Issue() {
		this.setResolved(false);
		this.setInBase(false);
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public User getAuthor() {
		return author;
	}

	public void setAuthor(User author) {
		this.author = author;
	}

	public User getWorkingStaff() {
		return workingStaff;
	}

	public void setWorkingStaff(User staff) {
		this.workingStaff = staff;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;	
	}

	public String getResolutionDetails() {
		return resolutionDetails;
	}

	public void setResolutionDetails(String resolutionDetails) {
		this.resolutionDetails = resolutionDetails;
	}

	public Date getDateReported() {
		return dateReported;
	}

	public void setDateReported(Date dateReported) {
		this.dateReported = dateReported;
	}

	public Date getDateResolved() {
		return dateResolved;
	}

	public void setDateResolved(Date dateResolved) {
		this.dateResolved = dateResolved;
	}

	public String getSolution() {
		return solution;
	}

	public void setSolution(String solution) {
		this.solution = solution;
	}

	public List<Comment> getComments() {
		return comments;
	}

	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}

	// Insert new COMMENT in the database
	public void addComment(Comment newComment) {
		Date utilDate = new Date();
		Timestamp timestamp = new java.sql.Timestamp(utilDate.getTime());

		try {
			DataSource dataSource = (DataSource) new InitialContext().lookup("java:/comp/env/it-portal-db");
			Connection connection = dataSource.getConnection();

			String update = "INSERT INTO comment(user_id, issue_id, date_posted, content) VALUES (?,?,?,?)";

			PreparedStatement statement = connection.prepareStatement(update);
			statement.setInt(1,newComment.getAuthor().getId());
			statement.setInt(2,this.getId());
			statement.setTimestamp(3, timestamp);
			statement.setString(4, newComment.getContent());

			statement.executeUpdate();
			statement.close();
			connection.close();
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// Get all the comments related to this issue
	public void retrieveIssueComments() {
		List<Comment> issueComments = new ArrayList<Comment>();

		try {
			DataSource dataSource = (DataSource) new InitialContext().lookup("java:/comp/env/it-portal-db");

			Connection connection = dataSource.getConnection();

			String query = "SELECT * FROM comment WHERE issue_id='" + this.getId() + "';";

			Statement statement = connection.createStatement();
			ResultSet resultSet = statement.executeQuery(query);

			while(resultSet.next()) {
				Comment issueComment = new Comment();

				issueComment.setId(resultSet.getInt("id"));

				int userId = resultSet.getInt("user_id");
				User commentAuthor = new User();
				commentAuthor.setId(userId);
				commentAuthor.retrieveUserInfo();
				issueComment.setAuthor(commentAuthor);

				issueComment.setContent(resultSet.getString("content"));
				issueComment.setDatePosted(resultSet.getTimestamp("date_posted"));

				issueComments.add(issueComment);
			}

			statement.close();
			resultSet.close();
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (NamingException e) {
			e.printStackTrace();
		}

		this.setComments(issueComments);
	}

	public List<RelatedFile> getRelatedFiles() {
		return relatedFiles;
	}

	public void setRelatedFiles(List<RelatedFile> relatedFiles) {
		this.relatedFiles = relatedFiles;
	}

	// Get all the files related to this issue
	public void retrieveIssueRelatedFiles() {
		List<RelatedFile> issueRelatedFiles = new ArrayList<RelatedFile>();

		try {
			DataSource dataSource = (DataSource) new InitialContext().lookup("java:/comp/env/it-portal-db");

			Connection connection = dataSource.getConnection();

			String query = "SELECT * FROM file WHERE issue_id='" + this.getId() + "';";

			Statement statement = connection.createStatement();
			ResultSet resultSet = statement.executeQuery(query);

			while(resultSet.next()) {
				RelatedFile relatedFile = new RelatedFile();

				relatedFile.setId(resultSet.getInt("id"));
				relatedFile.setName(resultSet.getString("name"));
				relatedFile.setType(resultSet.getString("type"));

				issueRelatedFiles.add(relatedFile);
			}

			statement.close();
			resultSet.close();
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (NamingException e) {
			e.printStackTrace();
		}

		this.setRelatedFiles(issueRelatedFiles);
	}

	public boolean isResolved() {
		return isResolved;
	}

	public void setResolved(boolean isResolved) {
		this.isResolved = isResolved;

		if(isResolved) {
			Date utilDate = new Date();
			Timestamp timestamp = new java.sql.Timestamp(utilDate.getTime());

			this.setState("Resolved");
			this.setResolutionDetails(this.getSolution());
			this.setDateResolved(timestamp);
		}
	}

	public boolean isInBase() {
		return isInBase;
	}

	public void setInBase(boolean inBase) {
		this.isInBase = inBase;
	}

	// Used to retrieve the issue's characteristics from the database
	public void retrieveIssueInfo(int id) {
		try {
			DataSource dataSource = (DataSource) new InitialContext().lookup("java:/comp/env/it-portal-db");

			Connection connection = dataSource.getConnection();

			String query = "SELECT * FROM issue WHERE id='" + id + "' LIMIT 1;";

			Statement statement = connection.createStatement();
			ResultSet resultSet = statement.executeQuery(query);

			if(resultSet.next()) {
				this.setId(id);
				this.setTitle(resultSet.getString("title"));
				this.setDescription(resultSet.getString("description"));

				int userId = resultSet.getInt("user_id");
				User issueAuthor = new User();
				issueAuthor.setId(userId);
				issueAuthor.retrieveUserInfo();
				this.setAuthor(issueAuthor);

				this.setCategory(resultSet.getString("category"));

				this.setState(resultSet.getString("state"));
				if(this.getState().equals("Resolved")) {
					this.setResolved(true);
				}

				this.setSolution(resultSet.getString("solution"));

				this.setDateReported(resultSet.getTimestamp("date_reported"));
				if(resultSet.getTimestamp("date_resolved") != null) {
					this.setDateResolved(resultSet.getTimestamp("date_resolved"));
				} else {
					this.setDateResolved(null);
				}

				this.setResolutionDetails(resultSet.getString("resolution_details"));

				int staffId = resultSet.getInt("staff_id");
				User issueWorkingStaff = new User();
				issueWorkingStaff.setId(staffId);
				issueWorkingStaff.retrieveUserInfo();
				this.setWorkingStaff(issueWorkingStaff);

				this.setInBase(resultSet.getBoolean("in_base"));

				this.retrieveIssueComments();
				this.retrieveIssueRelatedFiles();
			}

			statement.close();
			resultSet.close();
			connection.close();
		} catch (SQLException | NamingException e) {
			e.printStackTrace();
		}
	}

	// Insert a new ISSUE in the database
	public void reportIssue(List<Part> fileParts, ServletContext context) {
		OutputStream out = null;
		InputStream fileContent = null;

		Date utilDate = new Date();
		Timestamp timestamp = new java.sql.Timestamp(utilDate.getTime());

		try {
			DataSource dataSource = (DataSource) new InitialContext().lookup("java:/comp/env/it-portal-db");
			Connection connection = dataSource.getConnection();

			String update = "INSERT INTO issue(title, description, user_id, category, date_reported) VALUES (?,?,?,?,?)";

			PreparedStatement statement = connection.prepareStatement(update, Statement.RETURN_GENERATED_KEYS);
			statement.setString(1,this.getTitle());
			statement.setString(2,this.getDescription());
			statement.setInt(3, this.getAuthor().getId());
			statement.setString(4, this.getCategory());
			statement.setTimestamp(5, timestamp);

			statement.executeUpdate();

			ResultSet generatedKeys = statement.getGeneratedKeys();
			if(generatedKeys.next()) {
				int issueId = generatedKeys.getInt(1);
				this.setId(issueId);

				this.retrieveIssueInfo(issueId);

				for (Part filePart : fileParts) {
					try {
						RelatedFile relatedFile = new RelatedFile();

						String fileName = "issue_" + Integer.toString(issueId) + "_file_" + Paths.get(filePart.getSubmittedFileName()).getFileName().toString();;
						String fileType = Paths.get(filePart.getContentType()).toString();
						String filePath = context.getRealPath("/WEB-INF/files/" + File.separator + fileName);

						if(!fileType.equals("application\\octet-stream")) {
							out = new FileOutputStream(new File(filePath));
							fileContent = filePart.getInputStream();

							int read = 0;
							final byte[] bytes = new byte[1024];

							while ((read = fileContent.read(bytes)) != -1) {
								out.write(bytes, 0, read);
							}

							relatedFile.uploadFile(issueId, fileName, fileType);
						}						
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}

			statement.close();
			connection.close();
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// Used to update the issue's characteristics in the database
	public void update() {
		try {
			DataSource dataSource = (DataSource) new InitialContext().lookup("java:/comp/env/it-portal-db");

			Connection connection = dataSource.getConnection();

			String update = "UPDATE issue SET state=?, solution=?, date_resolved=?, resolution_details=?, staff_id=?, in_base=?"
					+ " WHERE id=" + this.getId();

			PreparedStatement statement = connection.prepareStatement(update);
			statement.setString(1, this.getState());
			statement.setString(2, this.getSolution());

			if(this.getDateResolved() != null) {
				statement.setTimestamp(3, new Timestamp(this.getDateResolved().getTime()));
			} else {
				statement.setTimestamp(3, null);
			}

			statement.setString(4, this.getResolutionDetails());
			statement.setInt(5, this.getWorkingStaff().getId());
			statement.setBoolean(6, this.isInBase());

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
