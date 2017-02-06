<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.it_services_portal.models.User"%>
<%@page import="com.it_services_portal.models.Issue"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
	List<Issue> userIssues = (List<Issue>) session.getAttribute("userIssues");
	List<Issue> currentIssues = new ArrayList<Issue>();

	for (Issue userIssue : userIssues) {
		if (!userIssue.isResolved()) {
			currentIssues.add(userIssue);
		}
	}

	String pageTitle = "My Issues";
	String pageSubTitle = "Current Issues";
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

		<div class="main-content">
			<div class="issue-container">
				<div class="row">
					<div class="col-xs-12 col-sm-4 col-lg-3 pull-left text-center">
						<a href="${pageContext.request.contextPath}/myIssues"
							class="custom-button back-button btn-block"><i
							class="fa fa-backward"></i> My issues</a>
					</div>
				</div>

				<div class="row">
					<div class="col-lg-12 col-lg-offset-0">
						<%
							if (!currentIssues.isEmpty()) {
						%>
						<div class="table-responsive ">
							<table class="table tablesorter">
								<thead>
									<tr>
										<th>#</th>
										<th>Title</th>
										<th>Description</th>
										<%
											if (request.isUserInRole("staff")) {
										%>
										<th>Author</th>
										<%
											}
										%>
										<th>Category</th>
										<th>Date Reported</th>
										<th>State</th>
									</tr>
								</thead>

								<tbody>
									<%
										for (Issue issue : currentIssues) {
									%>
									<tr
										onclick="document.location = '${pageContext.request.contextPath}/myIssues?action=issue&id=<%=issue.getId() %>';">
										<td><%=issue.getId()%></td>
										<td><%=issue.getTitle()%></td>
										<td><%=issue.getDescription()%></td>
										<%
											if (request.isUserInRole("staff")) {
										%>
										<td><%=issue.getAuthor().getUsername()%></td>
										<%
											}
										%>
										<td><%=issue.getCategory()%></td>
										<td><%=issue.getDateReported()%></td>
										<td><%=issue.getState()%></td>
									</tr>
									<%
										}
									%>
								</tbody>
							</table>
						</div>
						<%
							} else {
						%>
						<p class="empty-content">You have no current issues.</p>
						<%
							}
						%>
					</div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="/public/jsp/includes/footer.jsp"></jsp:include>
</body>
</html>