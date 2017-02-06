<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<header>
	<div class="row">
		<div class="col-xs-12 col-sm-8">
			<h1>
				IT Services <br> <span>Portal</span>
			</h1>
		</div>
		<%
			if (request.getParameter("pageTitle") != null) {
		%>
		<div class="col-xs-12 col-sm-4 text-right">
			<h2><%=request.getParameter("pageTitle")%></h2>
			<%
				if (request.getParameter("pageSubTitle") != null) {
			%>
			<h3><%=request.getParameter("pageSubTitle")%></h3>
			<%
				}
			%>
		</div>
		<%
			}
		%>
	</div>
</header>