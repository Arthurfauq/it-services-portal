<%@ page import="com.it_services_portal.models.RelatedFile"%>
<%@ page import="com.it_services_portal.models.Comment"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="com.it_services_portal.models.Issue"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
	Issue issue = (Issue) request.getAttribute("issue");

	List<Comment> issueComments = new ArrayList<Comment>();
	issueComments = issue.getComments();

	List<RelatedFile> issueRelatedFiles = new ArrayList<RelatedFile>();
	issueRelatedFiles = issue.getRelatedFiles();

	String pageTitle = (String) request.getAttribute("pageTitle");
	String pageSubTitle = "Issue #" + issue.getId();
%>

<jsp:include page="/public/jsp/includes/head.jsp">
	<jsp:param name="pageTitle" value="<%=pageTitle%>" />
</jsp:include>

<body>
	<!--[if lt IE 8]>
            <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
            <![endif]-->
	<div class="container">

		<jsp:include page="/public/jsp/includes/navigation.jsp">
			<jsp:param name="pageTitle" value="<%=pageTitle%>" />
		</jsp:include>

		<jsp:include page="/public/jsp/includes/header.jsp">
			<jsp:param name="pageTitle" value="<%=pageTitle%>" />
			<jsp:param name="pageSubTitle" value="<%=pageSubTitle%>" />
		</jsp:include>

		<%
			if (request.getSession().getAttribute("alert") != null) {
		%>
		<div class="alert alert-success alert-dismissible fade in"
			role="alert">
			<button type="button" class="close" data-dismiss="alert"
				aria-label="Close">
				<span aria-hidden="true">&times;</span>
			</button>
			<strong><%=request.getSession().getAttribute("alert")%></strong>
		</div>
		<%
			request.getSession().removeAttribute("alert");
			}
		%>

		<div class="main-content">
			<div class="issue-container">
				<div class="row">
					<%
						if (issue.isResolved()) {
					%>
					<div class="col-xs-12 col-sm-4 col-lg-3 pull-left text-center">
						<a
							href="${pageContext.request.contextPath}/<%=request.getAttribute("url")%>?action=resolvedIssues"
							class="custom-button back-button btn-block"><i
							class="fa fa-backward"></i> Resolved issues</a>
					</div>
					<%
						} else {
					%>
					<div class="col-xs-6 col-sm-4 col-lg-3 pull-left text-center">
						<a
							href="${pageContext.request.contextPath}/<%=request.getAttribute("url")%>?action=currentIssues"
							class="custom-button back-button btn-block"><i
							class="fa fa-backward"></i> Current issues</a>
					</div>
					<%
						}

						if (request.isUserInRole("staff")) {
							if (issue.getState().equals("New")) {
					%>
					<form action="${pageContext.request.contextPath}/staff/allIssues"
						method="post" class="form-horizontal" accept-charset="utf-8">

						<input type="hidden" name="issue-id" value="<%=issue.getId()%>">
						<input type="hidden" name="issue-action" value="workIssue">

						<div class="col-xs-6 col-sm-4 col-lg-3 pull-right text-center">
							<button type="submit"
								class="custom-button submit-button btn-block">
								<i class="fa fa-wrench"></i> Work on issue
							</button>
						</div>
					</form>
					<%
						} else if (issue.isResolved() && (!issue.isInBase())) {
					%>
					<form action="${pageContext.request.contextPath}/staff/allIssues"
						method="post" class="form-horizontal" accept-charset="utf-8">

						<input type="hidden" name="issue-id" value="<%=issue.getId()%>">
						<input type="hidden" name="issue-action" value="addKnowledgeBase">

						<div class="col-xs-6 col-sm-4 col-lg-3 pull-right text-center">
							<button type="submit"
								class="custom-button submit-button btn-block">
								<i class="fa fa-plus"></i> Knowledge-base
							</button>
						</div>
					</form>
					<%
						}
						}
					%>
				</div>

				<div class="row">
					<div class="col-xs-10 col-xs-offset-1 col-md-6">
						<h4>
							<i class="fa fa-tag"></i>Issue Description
						</h4>

						<div class="row content-container">
							<div class="col-xs-12 col-sm-8">
								<h5>Title</h5>
								<p class="issue-content"><%=issue.getTitle()%></p>
								<c:out value="${issue.title}"></c:out>
							</div>

							<div class="col-xs-12 col-sm-4">
								<h5>Category</h5>
								<p class="issue-content"><%=issue.getCategory()%></p>
							</div>

							<%
								if (request.isUserInRole("staff")) {
							%>
							<div class="col-xs-12">
								<h5>Author</h5>
								<p class="issue-content"><%=issue.getAuthor().getFirstName()%>
									<%=issue.getAuthor().getSurname()%></p>
							</div>
							<%
								}
							%>

							<div class="col-xs-12">
								<h5>Description</h5>
								<p class="issue-content"><%=issue.getDescription()%></p>
							</div>

							<div class="col-xs-12 col-sm-6">
								<h5>Date Reported</h5>
								<p class="issue-content"><%=issue.getDateReported()%></p>
							</div>

							<div class="col-xs-12 col-sm-6">
								<h5>State</h5>
								<p class="issue-content"><%=issue.getState()%></p>
							</div>
						</div>
					</div>

					<div class="col-xs-10 col-xs-offset-1 col-md-4 col-md-offset-0">
						<h4>
							<i class="fa fa-file"></i>Related Files
						</h4>
						<div>
							<%
								if (!issueRelatedFiles.isEmpty()) {
									for (RelatedFile file : issueRelatedFiles) {
							%>
							<p>
								<small>Click on a file's icon to open it in a new tab.</small>
							</p>
							<div class="file-container">
								<div class="col-xs-4 text-center">
									<a
										href="${pageContext.request.contextPath}/files/<%=file.getName().replace(" ", "%20")%>"
										target="_blank"> <i
										class="fa fa-5x fa-file-<%=(file.getType().contains("pdf")) ? "pdf-o" : "image-o"%>"></i>

									</a>
								</div>
								<div class="col-xs-8">
									<h5>Name</h5>
									<p><%=file.getName().substring(file.getName().lastIndexOf("file_") + 5)%></p>
									<h5>Type</h5>
									<p><%=file.getType().substring(file.getType().lastIndexOf("\\") + 1)%></p>
								</div>
							</div>
							<%
								}
								} else {
							%><p>There are no related files for this issue.</p>
							<%
								}
							%>

						</div>
					</div>
				</div>

				<%
					if (!issue.getState().equals("New")) {
				%>
				<div class="row">
					<div class="col-xs-10 col-xs-offset-1">
						<%
							if (issue.isResolved()) {
						%>
						<h4>
							<i class="fa fa-flag"></i>Resolution Details
						</h4>
						<h5><%=issue.getWorkingStaff().getUsername()%>
							-
							<%=issue.getDateResolved()%></h5>
						<p class="solution-content"><%=issue.getResolutionDetails()%></p>
						<%
							} else if (issue.getSolution() != null) {
						%>
						<h4>
							<i class="fa fa-flag"></i>Solution
						</h4>
						<p>This issue requires an action from its author.</p>

						<h5>
							Author :
							<%=issue.getWorkingStaff().getUsername()%></h5>
						<p class="solution-content">
							Solution :
							<%=issue.getSolution()%></p>

						<%
							if (request.isUserInRole("user")) {
						%>
						<form action="${pageContext.request.contextPath}/myIssues"
							method="post">
							<input type="hidden" name="issue-id" value="<%=issue.getId()%>">
							<input type="hidden" name="issue-action" value="acceptSolution">
							<div class="row">
								<div
									class="col-xs-6 col-sm-4 col-sm-offset-2 col-lg-3 col-lg-offset-3 text-center">
									<button type="submit" name="decision" value="accept"
										class="custom-button accept-button btn-block">
										<i class="fa fa-check"></i> Accept
									</button>
								</div>

								<div class="col-xs-6 col-sm-4 col-lg-3 text-center">
									<button type="submit" name="decision" value="reject"
										class="custom-button reject-button btn-block">
										<i class="fa fa-close"></i> Reject
									</button>
								</div>
							</div>
						</form>
						<%
							}
								} else { // There is no solution for this issue - STAFF
									if (request.isUserInRole("staff")
											&& issue.getWorkingStaff().getUsername().equals(request.getUserPrincipal().getName())) {
						%>
						<h4>
							<i class="fa fa-flag"></i>Solution
						</h4>
						<p>There is no solution for this issue or the author rejected
							the solution.</p>

						<form action="${pageContext.request.contextPath}/myIssues"
							class="form-horizontal" id="solution-form" method="post"
							accept-charset="utf-8">

							<input type="hidden" name="issue-id" value="<%=issue.getId()%>">
							<input type="hidden" name="issue-action" value="sendSolution">

							<div class="row">
								<div
									class="col-xs-12 col-sm-10 col-sm-offset-1 col-md-8 col-md-offset-2 col-lg-6 col-lg-offset-3">
									<h5>Solution</h5>
									<textarea name="solution" class="form-control" rows="3"
										placeholder="Enter your solution here..." required></textarea>
								</div>
							</div>

							<div class="row">
								<div
									class="col-xs-12 col-sm-6 col-sm-offset-3 col-lg-4 col-lg-offset-4">
									<div class="text-center">
										<button type="submit"
											class="custom-button submit-button btn-block">Send
											Solution</button>
									</div>
								</div>
							</div>
						</form>
						<%
							} else { // There is no solution for this issue - USER
						%>
						<h4>
							<i class="fa fa-flag"></i>Solution
						</h4>
						<p>Please wait for a staff to give a solution.</p>
						<%
							}
								}
						%>
					</div>
				</div>
				<%
					}
				%>

				<%
					if (!issue.getState().equals("New")) {
				%>
				<div class="row">
					<div class="col-xs-10 col-xs-offset-1">
						<h4>
							<i class="fa fa-comment-o"></i>Comments
						</h4>
						<%
							if (!issueComments.isEmpty()) {
									int i = 0;
									for (Comment issueComment : issueComments) {
						%>
						<h5>
							#<%=++i%>
							-
							<%=issueComment.getAuthor().getUsername()%>
							-
							<%=issueComment.getAuthor().getRole()%></h5>
						<div class="comment-content">
							<p><%=issueComment.getContent()%></p>
							<small><%=issueComment.getDatePosted()%></small>
						</div>
						<%
							}
						%>
						<%
							} else {
						%>
						<p>There are no comments for this issue.</p>
						<%
							}
						%>

						<%
							if (!issue.isResolved()) {
						%>
						<form
							action="${pageContext.request.contextPath}/<%=request.getAttribute("url")%>"
							class="form-horizontal" id="comment-form" method="post"
							accept-charset="utf-8">

							<input type="hidden" name="issue-action" value="addComment">
							<input type="hidden" name="issue-id" value="<%=issue.getId()%>">

							<div class="row">
								<div
									class="col-xs-12 col-sm-10 col-sm-offset-1 col-md-8 col-md-offset-2 col-lg-6 col-lg-offset-3">
									<h5>New Comment</h5>
									<textarea name="comment-content" class="form-control" rows="3"
										placeholder="Type your comment here..." required></textarea>
								</div>
							</div>

							<div class="row">
								<div
									class="col-xs-12 col-sm-6 col-sm-offset-3 col-lg-4 col-lg-offset-4">
									<div class="text-center">
										<button type="submit"
											class="custom-button submit-button btn-block">
											Submit Comment</button>
									</div>
								</div>
							</div>
						</form>
						<%
							}
						%>
					</div>
				</div>
				<%
					}
				%>

			</div>
		</div>
	</div>

	<jsp:include page="/public/jsp/includes/footer.jsp"></jsp:include>
</body>
</html>