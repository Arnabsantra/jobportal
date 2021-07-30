<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<spring:url var="css" value="/resources/css" />
<spring:url var="js" value="/resources/js" />
<spring:url var="images" value="/resources/images" />
<spring:url var="plugins" value="/resources/plugins" />

<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="keywords" content="" />
<meta name="author" content="" />
<meta name="robots" content="" />
<meta name="description" content="JobBoard - HTML Template" />
<meta property="og:title" content="JobBoard - HTML Template" />
<meta property="og:description" content="JobBoard - HTML Template" />
<meta property="og:image" content="JobBoard - HTML Template" />
<meta name="format-detection" content="telephone=no">

<!-- FAVICONS ICON -->
<link rel="icon" href="${images}/favicon.ico" type="image/x-icon" />
<link rel="shortcut icon" type="image/x-icon"
	href="${images}/favicon.png" />

<!-- PAGE TITLE HERE -->
<title>Job Portal - ${title}</title>

<!-- MOBILE SPECIFIC -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<!--[if lt IE 9]>
	<script src="${js}/html5shiv.min.js"></script>
	<script src="${js}/respond.min.js"></script>
	<![endif]-->

<!-- STYLESHEETS -->
<link rel="stylesheet" type="text/css" href="${css}/plugins.css">
<link rel="stylesheet" type="text/css" href="${css}/style.css">
<link rel="stylesheet" type="text/css" href="${css}/templete.css">
<link class="skin" rel="stylesheet" type="text/css"
	href="${css}/skin/skin-1.css">
<link rel="stylesheet"
	href="${plugins}/datepicker/css/bootstrap-datetimepicker.min.css" />
<!-- Revolution Slider Css -->
<link rel="stylesheet" type="text/css"
	href="${plugins}/revolution/revolution/css/layers.css">
<link rel="stylesheet" type="text/css"
	href="${plugins}/revolution/revolution/css/settings.css">
<link rel="stylesheet" type="text/css"
	href="${plugins}/revolution/revolution/css/navigation.css">
<!-- Revolution Navigation Style -->
</head>
<body id="bg">
	<div id="loading-area"></div>
	<div class="page-wraper">
		<!-- header -->
		<header class="site-header mo-left header fullwidth">
			<!-- main header -->
			<div class="sticky-header main-bar-wraper navbar-expand-lg">
				<div class="main-bar clearfix">
					<div class="container clearfix">
						<!-- website logo -->
						<div class="logo-header mostion">
							<a href="${contextRoot}/index"><img src="${images}/logo.png"
								class="logo" alt=""></a>
						</div>
						<!-- nav toggle button -->
						<!-- nav toggle button -->
						<button
							class="navbar-toggler collapsed navicon justify-content-end"
							type="button" data-toggle="collapse"
							data-target="#navbarNavDropdown"
							aria-controls="navbarNavDropdown" aria-expanded="false"
							aria-label="Toggle navigation">
							<span></span> <span></span> <span></span>
						</button>
						<!-- extra nav -->
						
						<!-- Quik search -->
						<div class="dez-quik-search bg-primary">
							<form action="#">
								<input name="search" value="" type="text" class="form-control"
									placeholder="Type to search"> <span
									id="quik-search-remove"><i class="flaticon-close"></i></span>
							</form>
						</div>
						<!-- main nav -->
						<div
							class="header-nav navbar-collapse collapse justify-content-start"
							id="navbarNavDropdown">
							<ul class="nav navbar-nav">
								<li><a href="#">Job Details <i
										class="fa fa-chevron-down"></i></a>
									<ul class="sub-menu">
										<li><a href="${contextRoot}/job/jobDetails" class="dez-page">Browse
												Job</a></li>
										<sec:authorize access="hasAnyRole('ROLE_RECRUITER')">
										<li><a href="${contextRoot}/job/viewJobDetails" class="dez-page">Post Job</a>
										</li>
										</sec:authorize>
									</ul>
									
									<sec:authorize access="hasAnyRole('ROLE_ADMIN')">
                            <li>
								<a href="#">Approvals <i class="fa fa-chevron-down"></i></a>
								<ul class="sub-menu">
									<li><a href="${contextRoot}/job/viewCreatedJob" class="dez-page">Approve Job</a></li>
									<li><a href="${contextRoot}/user/viewCreatedUser" class="dez-page">Approve User</a></li>
									
								</ul>
							</li>
							</sec:authorize>
									
									<c:if test="${pageContext.request.userPrincipal.name == null}">
									
								<li><a href="${contextRoot}/user/userForm" class="button"><i
										class="fa fa-user"></i> Sign Up</a></li>

								<li><a href="${contextRoot}/login" class="button"><i
										class="fa fa-user"></i> login </a></li>
										</c:if>
								<c:if test="${pageContext.request.userPrincipal.name != null}">
									<li class="active"><a href="${contextRoot}/logout" class="site-button"><i
										class="fa fa-lock"></i> logout </a></li>
								</c:if>
										</ul>
						</div>
					</div>
				</div>
				<!-- main header END -->
		</header>
		<!-- header END -->
		<!-- Content -->
		<div class="page-content">
			<!-- Section Banner -->
			<div class="dez-bnr-inr dez-bnr-inr-md"
				style="background-image:url(${images}/main-slider/slide2.jpg); height: 300px">
				
			</div>
			<!-- Section Banner END -->
			<!-- About Us -->
			<div class="section-full job-categories content-inner-2 bg-white"
				style="background-image:url(${images}/pattern/pic1.html);">
				
					</div>
					<div class="container"> <center> ${message}</center></div>
					<left>
					<div class="coupon">
						<div class="container">
							<left>
							<h3>Total Jobs</h3>
						</div>
						<div class="container" style="background-color: white">
							<h2>
								<b>${jobCount} +</b>
							</h2>
					</left>
					<br>
					<br>
				</div>
			</div>
			<br>
			<br>
			
			
			<div class="container">
				<div class="card">
					<center>
						<div class="container">
							<h2>
								<b>Post Personalised Jobs!!</b>
							</h2>
							<p><a href="${contextRoot}/user/userForm" class="button"><i
										class="fa fa-user"></i><u> By just creating a profile</u></a></p>
						</div>
						<div class="container">

						</div>
					</center>
					<br>
					<br>
				</div>
			</div>
			<br>
			<br>


			<!-- Our Job -->
			<div class="section-full bg-white content-inner-2">
				<div class="container">
					<div class="d-flex job-title-bx section-head">
						<div class="mr-auto">
							<h2 class="m-b5">Recent Jobs</h2>
						</div>
						<div class="align-self-end">
						</div>
					</div>
					<div class="row">
						<div class="col-lg-9">
							<ul class="post-job-bx">
							<c:set var="count" value="0" scope="page" />
								<c:forEach items="${jobList}" var="job">
									<c:set var="count" value="${count + 1}" scope="page"/>
								<li><a href="${contextRoot}/login">
										<div class="d-flex m-b30">
											<div class="job-post-company">
												<span><img src="${images}/logo/icon1.png" /></span>
											</div>
											<div class="job-post-info">
												<h4>${job.jobTitle}</h4>
												<h6>${job.companyName}</h6>
												<font color="black"> <i class="fa fa-file" p
													class="font-weight-700; color=black"> ${job.jobDetails}
														</p>
												</i></font>

												<ul>
													<li><i class="fa fa-briefcase"></i> ${job.experience}</li>
													<li><i class="fa fa-credit-card"></i> ${job.ctc}</li>
													<li><i class="fa fa-map-marker"></i> ${job.jobLocation}</li>
												</ul>
											</div>
										</div>
								</a></li>
								</c:forEach>
							</ul>
							<br>
						</div>
					</div>
				</div>
			</div>
			<!-- Our Job END -->
			<!-- Call To Action -->
			<!-- Call To Action END -->
			<!-- Our Latest Blog -->
			<!-- Our Latest Blog -->
		<!-- Footer -->
		<!-- Footer END -->
		<!-- scroll top button -->
		<button class="scroltop fa fa-arrow-up"></button>
	</div>
	<!-- JAVASCRIPT FILES ========================================= -->
	<script src="${js}/jquery.min.js"></script>
	<!-- JQUERY.MIN JS -->
	<script src="${plugins}/wow/wow.js"></script>
	<!-- WOW JS -->
	<script src="${plugins}/bootstrap/js/popper.min.js"></script>
	<!-- BOOTSTRAP.MIN JS -->
	<script src="${plugins}/bootstrap/js/bootstrap.min.js"></script>
	<!-- BOOTSTRAP.MIN JS -->
	<script src="${plugins}/bootstrap-select/bootstrap-select.min.js"></script>
	<!-- FORM JS -->
	<script
		src="${plugins}/bootstrap-touchspin/jquery.bootstrap-touchspin.js"></script>
	<!-- FORM JS -->
	<script src="${plugins}/magnific-popup/magnific-popup.js"></script>
	<!-- MAGNIFIC POPUP JS -->
	<script src="${plugins}/counter/waypoints-min.js"></script>
	<!-- WAYPOINTS JS -->
	<script src="${plugins}/counter/counterup.min.js"></script>
	<!-- COUNTERUP JS -->
	<script src="${plugins}/imagesloaded/imagesloaded.js"></script>
	<!-- IMAGESLOADED -->
	<script src="${plugins}/masonry/masonry-3.1.4.js"></script>
	<!-- MASONRY -->
	<script src="${plugins}/masonry/masonry.filter.js"></script>
	<!-- MASONRY -->
	<script src="${plugins}/owl-carousel/owl.carousel.js"></script>
	<!-- OWL SLIDER -->
	<script src="${plugins}/rangeslider/rangeslider.js"></script>
	<!-- Rangeslider -->
	<script src="${js}/custom.js"></script>
	<!-- CUSTOM FUCTIONS  -->
	<script src="${js}/dz.carousel.js"></script>
	<!-- SORTCODE FUCTIONS  -->
	<script src='${js}/recaptcha/api.js'></script>
	<!-- Google API For Recaptcha  -->
	<script src="${js}/dz.ajax.js"></script>
	<!-- CONTACT JS  -->
	<script src="${plugins}/paroller/skrollr.min.js"></script>
	<!-- PAROLLER -->
	<!-- Go to www.addthis.com/dashboard to customize your tools -->

</body>

</html>