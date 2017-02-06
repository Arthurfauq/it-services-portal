<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.it_services_portal.models.User"%>
<%@page import="com.it_services_portal.models.Issue"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
	List<Issue> allIssues = (List<Issue>) session.getAttribute("allIssues");
	List<Issue> issues = new ArrayList<Issue>();

	for (Issue issue : allIssues) {
		if (issue.getState().equals("New")) {
			issues.add(issue);
		}
	}

	String pageTitle = "All Issues";
	String pageSubTitle = "New Issues";
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
						<a href="${pageContext.request.contextPath}/staff/allIssues"
							class="custom-button back-button btn-block"><i
							class="fa fa-backward"></i> All issues</a>
					</div>
				</div>

				<div class="row">
					<div class="col-lg-12 col-lg-offset-0">
						<%
							if (!issues.isEmpty()) {
						%>
						<div class="table-responsive">
							<table class="table tablesorter">
								<thead>
									<tr>
										<th>#</th>
										<th>Title</th>
										<th>Description</th>
										<th>Author</th>
										<th>Category</th>
										<th>Date Reported</th>
									</tr>
								</thead>

								<tbody>
									<%
										for (Issue issue : issues) {
									%>
									<tr
										onclick="document.location = '${pageContext.request.contextPath}/staff/allIssues?action=issue&id=<%=issue.getId() %>';">
										<td><%=issue.getId()%></td>
										<td><%=issue.getTitle()%></td>
										<td><%=issue.getDescription()%></td>
										<td><%=issue.getAuthor().getUsername()%></td>
										<td><%=issue.getCategory()%></td>
										<td><%=issue.getDateReported()%></td>
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
						<p class="empty-content">There are no new issues.</p>
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