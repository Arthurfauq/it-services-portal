<%@page import="com.it_services_portal.models.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	
<%
	User currentUser = (User) session.getAttribute("currentUser");

	String pageTitle = "Profile";
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
			<div class="row">
				<div class="col-xs-10 col-xs-offset-1 col-md-5 col-md-offset-0">
					<p class="username-info">
						<%=currentUser.getUsername()%>
						<br> <span> <%=request.isUserInRole("staff") ? "staff" : "user"%>
						</span>
					</p>
				</div>
				
				<div class="col-xs-11 col-xs-offset-1 col-md-7 col-md-offset-0"
					style="border-left: 1px solid #ffffc6; margin-top: 20px">
					<p class="user-info"><%=currentUser.getFirstName()%><br> <span>First
							name</span>
					</p>
					<p class="user-info"><%=currentUser.getSurname()%><br> <span>Surname</span>
					</p>
					<p class="user-info email-info"><%=currentUser.getEmail()%><br>
						<span>Email</span>
					</p>
					<p class="user-info"><%=currentUser.getContactNumber()%><br>
						<span>Contact Number</span>
					</p>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="/public/jsp/includes/footer.jsp"></jsp:include>
</body>
</html>