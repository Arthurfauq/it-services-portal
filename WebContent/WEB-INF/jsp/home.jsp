<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
	String pageTitle = "Home Page";
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
				<div class="col-xs-8 col-xs-offset-2 col-sm-4 col-sm-offset-0">
					<a href="${pageContext.request.contextPath}/staff/allIssues"
						title="All Issues" class="button button-large hvr-outline-in">All
						Issues</a>
				</div>
				<div class="col-xs-8 col-xs-offset-2 col-sm-4 col-sm-offset-0">
					<a href="${pageContext.request.contextPath}/myIssues"
						title="My Issues" class="button button-large hvr-outline-in">My
						Issues</a>
				</div>
				<div class="col-xs-8 col-xs-offset-2 col-sm-4 col-sm-offset-0">
					<a href="${pageContext.request.contextPath}/knowledgeBase"
						title="Knowledge-Base" class="button button-large hvr-outline-in">Knowledge-Base</a>
				</div>
				<%
					} else {
				%>
				<div class="col-xs-8 col-xs-offset-2 col-sm-5 col-sm-offset-1">
					<a href="${pageContext.request.contextPath}/myIssues"
						title="My Issues" class="button button-large hvr-outline-in">My
						Issues</a>
				</div>
				<div class="col-xs-8 col-xs-offset-2 col-sm-5 col-sm-offset-0">
					<a href="${pageContext.request.contextPath}/knowledgeBase"
						title="Knowledge-Base" class="button button-large hvr-outline-in">Knowledge-Base</a>
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