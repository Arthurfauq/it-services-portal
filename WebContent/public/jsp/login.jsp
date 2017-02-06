<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
	String pageTitle = "Login";
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
			<form action="j_security_check" class="form-horizontal"
				id="login-form" method="post" accept-charset="utf-8">
				<div class="form-group">
					<div
						class="col-xs-8 col-xs-offset-2 col-sm-6 col-sm-offset-3 col-md-4 col-md-offset-4">
						<label for="login-username" class="control-label">Username</label>
						<div class="input-group">
							<span class="input-group-addon"><i class="fa fa-user"
								aria-hidden="true"></i></span> <input type="text" name="j_username"
								id="login-username" class="form-control"
								placeholder="Enter your username" required autocomplete="off"
								autofocus>
						</div>
					</div>
				</div>

				<div class="form-group">
					<div
						class="col-xs-8 col-xs-offset-2 col-sm-6 col-sm-offset-3 col-md-4 col-md-offset-4">
						<label for="login-password" class="control-label">Password</label>
						<div class="input-group">
							<span class="input-group-addon"><i
								class="fa fa-lock fa-lg" aria-hidden="true"></i></span> <input
								type="password" name="j_password" id="login-password" class="form-control"
								placeholder="Enter your password" required>
						</div>
					</div>
				</div>

				<div class="form-group text-center">
					<div
						class="col-xs-8 col-xs-offset-2 col-sm-6 col-sm-offset-3 col-md-4 col-md-offset-4">
						<button type="submit" class="btn-block custom-button login-button"
							data-loading-text="Signin in...">
							Sign in <i class="fa fa-sign-in"></i>
						</button>
					</div>
				</div>
			</form>
		</div>
	</div>

	<jsp:include page="/public/jsp/includes/footer.jsp"></jsp:include>
</body>
</html>