<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.it_services_portal.models.User"%>
<%@page import="com.it_services_portal.models.Issue"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
	String pageTitle = "My Issues";
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
			<div class="row text-center">
				<%
					if (request.isUserInRole("staff")) {
				%>
				<div class="col-xs-8 col-xs-offset-2 col-sm-5 col-sm-offset-1">
					<a href="${pageContext.request.contextPath}/myIssues?action=currentIssues"
						class="button button-large hvr-outline-in">Current issues</a>
				</div>
				<div class="col-xs-8 col-xs-offset-2 col-sm-5 col-sm-offset-0">
					<a
						href="${pageContext.request.contextPath}/myIssues?action=resolvedIssues"
						class="button button-large hvr-outline-in">Resolved issues</a>
				</div>
				<%
					} else {
				%>
				<div class="col-xs-8 col-xs-offset-2 col-sm-4 col-sm-offset-0">
					<a
						href="${pageContext.request.contextPath}/myIssues?action=currentIssues"
						class="button button-large hvr-outline-in">Current issues</a>
				</div>
				<div class="col-xs-8 col-xs-offset-2 col-sm-4 col-sm-offset-0">
					<a
						href="${pageContext.request.contextPath}/myIssues?action=resolvedIssues"
						class="button button-large hvr-outline-in">Resolved issues</a>
				</div>
				<div class="col-xs-8 col-xs-offset-2 col-sm-4 col-sm-offset-0">
					<a
						href="${pageContext.request.contextPath}/user/myIssues?action=reportIssue"
						class="button button-large hvr-outline-in">Report issue</a>
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