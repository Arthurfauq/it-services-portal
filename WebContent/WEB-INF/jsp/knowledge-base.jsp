<%@page import="java.util.ArrayList"%>
<%@page import="com.it_services_portal.models.Issue"%>
<%@page import="java.util.List"%>
<%@page import="com.it_services_portal.models.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
	List<Issue> baseIncidents = new ArrayList<Issue>();
	baseIncidents = (List<Issue>) session.getAttribute("baseIncidents");

	String pageTitle = "Knowledge-Base";
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
		</jsp:include>

		<div class="main-content">
			<div class="issue-container">
				<div class="row">
					<div class="col-xs-12 col-sm-4 col-lg-3 pull-left text-center">
						<a href="${pageContext.request.contextPath}/index"
							class="custom-button back-button btn-block"><i
							class="fa fa-backward"></i> Home page</a>
					</div>
				</div>

				<div class="row">
					<div class="col-lg-12 col-lg-offset-0">

						<%
							if (!baseIncidents.isEmpty()) {
						%>
						<div class="table-responsive">
							<table class="table tablesorter">
								<thead>
									<tr>
										<th>#</th>
										<th>Title</th>
										<th>Description</th>
										<th>Category</th>
										<th>Resolution Details</th>
										<th>Date Resolved</th>
									</tr>
								</thead>

								<tbody>
									<%
										for (Issue issue : baseIncidents) {
									%>
									<tr
										onclick="document.location = '${pageContext.request.contextPath}/knowledgeBase?action=incident&id=<%=issue.getId() %>';">
										<td><%=issue.getId()%></td>
										<td><%=issue.getTitle()%></td>
										<td><%=issue.getDescription()%></td>
										<td><%=issue.getCategory()%></td>
										<td><%=issue.getResolutionDetails()%></td>
										<td><%=issue.getDateResolved()%></td>
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
						<p class="empty-content">There are no incidents in the
							knowledge-base.</p>
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