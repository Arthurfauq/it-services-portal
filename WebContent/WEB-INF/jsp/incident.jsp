<%@page import="com.it_services_portal.models.RelatedFile"%>
<%@page import="com.it_services_portal.models.Comment"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.it_services_portal.models.Issue"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
	Issue incident = (Issue) request.getAttribute("incident");

	List<RelatedFile> issueRelatedFiles = new ArrayList<RelatedFile>();
	issueRelatedFiles = incident.getRelatedFiles();

	String pageTitle = "Knowledge-Base";
	String pageSubTitle = "Incident Description";
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
						<a href="${pageContext.request.contextPath}/knowledgeBase"
							class="custom-button back-button btn-block"><i
							class="fa fa-backward"></i> Knowledge-Base</a>
					</div>
				</div>

				<div class="row">
					<div class="col-xs-10 col-xs-offset-1 col-md-6">
						<h4>
							<i class="fa fa-tag"></i>Incident Description
						</h4>

						<div class="row content-container">
							<div class="col-xs-12 col-sm-8">
								<h5>Title</h5>
								<p class="issue-content"><%=incident.getTitle()%></p>
							</div>

							<div class="col-xs-12 col-sm-4">
								<h5>Category</h5>
								<p class="issue-content"><%=incident.getCategory()%></p>
							</div>

							<div class="col-xs-12">
								<h5>Description</h5>
								<p class="issue-content"><%=incident.getDescription()%></p>
							</div>
						</div>
					</div>

					<div class="col-xs-10 col-xs-offset-1 col-md-4 col-md-offset-0">
						<h4>
							<i class="fa fa-file"></i>Related Files
						</h4>
						<div>
							<%
								if (!issueRelatedFiles.isEmpty()) {
									for (RelatedFile file : issueRelatedFiles) {
							%>
							<p>
								<small>Click on a file's icon to open it in a new tab.</small>
							</p>
							<div class="file-container">
								<div class="col-xs-4 text-center">
									<a
										href="${pageContext.request.contextPath}/files/<%=file.getName()%>"
										target="_blank"> <i
										class="fa fa-5x fa-file-<%=(file.getType().contains("pdf")) ? "pdf-o" : "image-o"%>"></i>

									</a>
								</div>
								<div class="col-xs-8">
									<h5>Name</h5>
									<p><%=file.getName().substring(file.getName().lastIndexOf("file_") + 5)%></p>
									<h5>Type</h5>
									<p><%=file.getType().substring(file.getType().lastIndexOf("\\") + 1)%></p>
								</div>
							</div>
							<%
								}

								} else {
							%><p>There are no related files for this issue.</p>
							<%
								}
							%>

						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-xs-10 col-xs-offset-1">
						<h4>
							<i class="fa fa-flag"></i>Resolution Details
						</h4>
						<h5><%=incident.getWorkingStaff().getUsername()%>
							-
							<%=incident.getDateResolved()%></h5>
						<p class="solution-content"><%=incident.getResolutionDetails()%></p>
					</div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="/public/jsp/includes/footer.jsp"></jsp:include>
</body>
</html>