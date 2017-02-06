<%@page import="com.it_services_portal.models.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
	User currentUser = (User) session.getAttribute("currentUser");

	String pageTitle = "My Issues";
	String pageSubTitle = "Report Issue";
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
					<div class="col-xs-5 col-md-4 col-lg-3 text-center"
						style="margin-bottom: 20px">
						<a href="${pageContext.request.contextPath}/myIssues"
							class="custom-button back-button btn-block"><i
							class="fa fa-backward"></i> My issues</a>
					</div>

					<div
						class="col-xs-10 col-xs-offset-1 col-sm-8 col-sm-offset-2 col-lg-6 col-lg-offset-0">
						<h4>
							<i class="fa fa-wrench"></i> New issue
						</h4>
					</div>

					<div
						class="col-xs-10 col-xs-offset-1 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3">
						<form action="${pageContext.request.contextPath}/myIssues"
							class="form-horizontal" id="issue-form" method="post"
							enctype="multipart/form-data" accept-charset="utf-8" role="form"
							data-toggle="validator">

							<input type="hidden" name="issue-action" value="reportIssue">

							<div class="form-group">
								<div class="col-xs-12">
									<label class="control-label">Author</label>
									<p class="col-xs-12 form-control-static"><%=currentUser.getFirstName()%>
										<%=currentUser.getSurname()%></p>
								</div>
							</div>

							<div class="form-group has-feedback">
								<div class="col-xs-12">
									<label for="issue-title" class="control-label">Title</label> <input
										type="text" name="issue-title" id="issue-title"
										class="form-control" placeholder="Enter the issue title"
										required autofocus data-minlength="5"
										data-error="A title of at least 5 characters is required for this issue">
									<span class="glyphicon form-control-feedback"
										aria-hidden="true"></span>
									<div class="help-block with-errors"></div>
								</div>
							</div>

							<div class="form-group">
								<div class="col-xs-12">
									<label for="issue-description" class="control-label">Description</label>
									<textarea name="issue-description" id="issue-description"
										class="form-control" rows="4"
										placeholder="Enter a description" required data-minlength="10"
										data-error="A description of at least 10 characters is required for this issue"></textarea>
									<div class="help-block with-errors"></div>
								</div>
							</div>

							<div class="form-group">
								<div class="col-xs-12">
									<label for="issue-category" class="control-label">Category</label>
									<select name="issue-category" class="form-control"
										id="issue-category">
										<option>Network</option>
										<option>Hardware</option>
										<option>Software</option>
										<option>Email</option>
										<option>Account</option>
									</select>
								</div>
							</div>

							<div class="form-group">
								<div class="col-xs-12">
									<label for="issue-files" class="control-label">Attach
										files</label> <input type="file" id="issue-files" name="issue-files"
										multiple="multiple"
										accept=".pdf, image/x-png, image/gif, image/jpeg">
									<p class="help-block">Attach some files or images to your
										issue.</p>
								</div>
							</div>

							<div class="col-xs-6 col-xs-offset-3">
								<div class="text-center">
									<button type="submit"
										class="custom-button submit-button btn-block">Report
										Issue</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="/public/jsp/includes/footer.jsp"></jsp:include>
</body>
</html>