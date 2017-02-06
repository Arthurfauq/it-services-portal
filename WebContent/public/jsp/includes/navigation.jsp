<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<nav>
	<a href="${pageContext.request.contextPath}/index"
		class="<%= (request.getParameter("pageTitle").equals("Home Page")  ? "active" : "") %>"><i
		class="fa fa-home"></i>Home</a>
	<%
		if (request.isUserInRole("staff")) {
	%>
	<a href="${pageContext.request.contextPath}/staff/allIssues"
		class="<%= (request.getParameter("pageTitle").equals("All Issues") ? "active" : "") %>"><i
		class="fa fa-database"></i>All Issues</a> <a
		href="${pageContext.request.contextPath}/myIssues"
		class="<%= (request.getParameter("pageTitle").equals("My Issues") ? "active" : "") %>"><i
		class="fa fa-navicon"></i>My Issues</a>
	<%
		} else {
	%>
	<a href="${pageContext.request.contextPath}/myIssues"
		class="<%= (request.getParameter("pageTitle").equals("My Issues") ? "active" : "") %>"><i
		class="fa fa-navicon"></i>My Issues</a>
	<%
		}
	%>
	<a href="${pageContext.request.contextPath}/knowledgeBase"
		class="<%= (request.getParameter("pageTitle").equals("Knowledge-Base")? "active" : "") %>"><i
		class="fa fa-book"></i>Knowledge-Base</a>
	<div class="pull-right">
		<a href="${pageContext.request.contextPath}/profile"
			class="<%= (request.getParameter("pageTitle").equals("Profile")? "active" : "") %>"><i
			class="fa fa-user"></i>My Profile</a> <a
			href="${pageContext.request.contextPath}/logout"><i
			class="fa fa-sign-out"></i>Logout</a>
	</div>
	<a href="#" class="nav-icon"><i class="fa fa-navicon"></i></a>
</nav>