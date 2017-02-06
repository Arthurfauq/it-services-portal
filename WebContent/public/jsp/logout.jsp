<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
	String pageTitle = "Logout";
%>

<jsp:include page="/public/jsp/includes/head.jsp">
	<jsp:param name="pageTitle" value="<%=pageTitle%>" />
</jsp:include>

<body>
	<!--[if lt IE 8]>
            <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
            <![endif]-->
	<div class="container">

		<jsp:include page="/public/jsp/includes/header.jsp"></jsp:include>

		<div class="main-content">
			<div class="row text-center">
				<div class="col-xs-12 col-sm-8 col-sm-push-2 col-md-6 col-md-push-3">
					<p class="login-error">You have been successfully logged out.</p>
					<a href="${pageContext.request.contextPath}/login"
						class="button button-small hvr-ripple-out">Login page</a>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/public/jsp/includes/footer.jsp"></jsp:include>
</body>
</html>