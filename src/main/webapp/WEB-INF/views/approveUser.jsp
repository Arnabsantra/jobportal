<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<spring:url var="css" value="/resources/css" />
<spring:url var="js" value="/resources/js" />
<spring:url var="images" value="/resources/images" />
<spring:url var="plugins" value="/resources/plugins" />

<c:set var="contextRoot" value="${pageContext.request.contextPath}" />


<!DOCTYPE html>
<html lang="en">
<script src="${js}/jquery.min.js"></script><!-- JQUERY.MIN JS -->

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="keywords" content="" />
	<meta name="author" content="" />
	<meta name="robots" content="" />
	<meta name="format-detection" content="telephone=no">
	
	<!-- FAVICONS ICON -->
	<link rel="icon" href="${images}/t.png" type="image/x-icon" />
	<link rel="shortcut icon" type="image/x-icon" href="${images}/t.png" />
	
	<!-- PAGE TITLE HERE -->
	<title>UserApproval</title>
	
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
	<link class="skin" rel="stylesheet" type="text/css" href="${css}/skin/skin-1.css">
	<link rel="stylesheet" href="${plugins}/datepicker/css/bootstrap-datetimepicker.min.css"/>
	<!-- Revolution Slider Css -->
	<link rel="stylesheet" type="text/css" href="${plugins}/revolution/revolution/css/layers.css">
	<link rel="stylesheet" type="text/css" href="${plugins}/revolution/revolution/css/settings.css">
	<link rel="stylesheet" type="text/css" href="${plugins}/revolution/revolution/css/navigation.css">
	<!-- Revolution Navigation Style -->
</head>
<body id="bg">
<div class="page-wraper">
<div id="loading-area"></div>
	<!-- header -->
    <header class="site-header mo-left header fullwidth">
		<!-- main header -->
        <div class="sticky-header main-bar-wraper navbar-expand-lg">
            <div class="main-bar clearfix">
                <div class="container clearfix">
                    <!-- website logo -->
                    <div class="logo-header mostion">
						<a href="#"><img src="${images}/t.png" class="logo" alt=""></a>
					</div>
                    <!-- nav toggle button -->
                    <!-- nav toggle button -->
                    <button class="navbar-toggler collapsed navicon justify-content-end" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
						<span></span>
						<span></span>
						<span></span>
					</button>
                    <!-- extra nav -->
					<div class="dez-quik-search bg-primary">
                        <form action="#">
                            <input name="search" value="" type="text" class="form-control" placeholder="Type to search">
                            <span id="quik-search-remove"><i class="flaticon-close"></i></span>
                        </form>
                    </div>
                    <!-- main nav -->
                    <div class="header-nav navbar-collapse collapse justify-content-start" id="navbarNavDropdown">
                        <ul class="nav navbar-nav">
							<li class="active">
								<a href="${contextRoot}/index">Home </i></a>
								
							</li>
							
                            <li>
								<a href="#">Approvals <i class="fa fa-chevron-down"></i></a>
								<ul class="sub-menu">
									<li><a href="${contextRoot}/job/viewCreatedJob" class="dez-page">Approve Job</a></li>
								</ul>
							</li>
							<c:if test="${pageContext.request.userPrincipal.name != null}">
									<li class="active"><a href="${contextRoot}/logout" class="site-button"><i
										class="fa fa-lock"></i> logout </a></li>
								</c:if>
							<li><a href="${contextRoot}/job/jobDetails" class="dez-page">Browse Job</a></li>
                </div>
            </div>
        </div>
            </div>
        </div>
        <!-- main header END -->
    </header>
    <!-- header END -->
    <!-- Content -->
    <div class="page-content bg-white">
        <!-- inner page banner -->
        <div class="dez-bnr-inr overlay-black-middle" style="background-image:url(${images}/banner/bnr1.jpg);">
            <div class="container">
                <div class="dez-bnr-inr-entry">
                    <h1 class="text-white">Approve User</h1>
					<!-- Breadcrumb row -->
					<div class="breadcrumb-row">
						<ul class="list-inline">
							<li><a href="#">Home</a></li>
							<li>Approve User</li>
						</ul>
					</div>
					<!-- Breadcrumb row END -->
                </div>
            </div>
        </div>
        <!-- inner page banner END -->
        <!-- contact area -->
        <style>
            table {
              font-family: arial, sans-serif;
              border-collapse: collapse;
              width: 100%;
            }
            
            td, th {
              border: 1px solid #dddddd;
              text-align: left;
              padding: 8px;
            }
            
            tr:nth-child(even) {
              background-color: #dddddd;
            }
            </style>
            </head>
            <body>
            
            <table>
            <thead>
              <tr>
              	<th>SL No.</th>
              	<th>Organization Name</th>
                <th>Contact Person's Name</th>
                <th>Email</th>
                <th>Mobile</th>
                <th>Action</th>
              </tr>
              </thead>
              <tbody>
              <c:set var="count" value="0" scope="page" />
					<c:forEach items="${userList}" var="user">
						<c:set var="count" value="${count + 1}" scope="page"/>
              <tr>
              	<td>${count}</td>
                <td>${user.organizationName}</td>
                <td>${user.contactPerson}</td>
                <td>${user.emailId}</td>
                <td>${user.mobileNo}</td>
                <td>
                <a href="${contextRoot}/user/approveUser?userId=${user.userId}" class="button"><i
										class="fa fa-user"></i> Approve</a>
                </td>
              </tr>
              </c:forEach>
              </tbody>
            </table>
		</div>
    </div>
    <!-- Content END-->
	<!-- Footer -->
    
    <!-- Footer END -->
    <button class="scroltop fa fa-chevron-up"></button>
</div>
<!-- JAVASCRIPT FILES ========================================= -->
<script src="${plugins}/wow/wow.js"></script><!-- WOW JS -->
<script src="${plugins}/bootstrap/js/popper.min.js"></script><!-- BOOTSTRAP.MIN JS -->
<script src="${plugins}/bootstrap/js/bootstrap.min.js"></script><!-- BOOTSTRAP.MIN JS -->
<script src="${plugins}/bootstrap-select/bootstrap-select.min.js"></script><!-- FORM JS -->
<script src="${plugins}/bootstrap-touchspin/jquery.bootstrap-touchspin.js"></script><!-- FORM JS -->
<script src="${plugins}/magnific-popup/magnific-popup.js"></script><!-- MAGNIFIC POPUP JS -->
<script src="${plugins}/counter/waypoints-min.js"></script><!-- WAYPOINTS JS -->
<script src="${plugins}/counter/counterup.min.js"></script><!-- COUNTERUP JS -->
<script src="${plugins}/imagesloaded/imagesloaded.js"></script><!-- IMAGESLOADED -->
<script src="${plugins}/masonry/masonry-3.1.4.js"></script><!-- MASONRY -->
<script src="${plugins}/masonry/masonry.filter.js"></script><!-- MASONRY -->
<script src="${plugins}/owl-carousel/owl.carousel.js"></script><!-- OWL SLIDER -->
<script src="${plugins}/rangeslider/rangeslider.js" ></script><!-- Rangeslider -->
<script src="${js}/custom.js"></script><!-- CUSTOM FUCTIONS  -->
<script src="${js}/dz.carousel.js"></script><!-- SORTCODE FUCTIONS  -->
<script src='${js}/recaptcha/api.js'></script> <!-- Google API For Recaptcha  -->
<script src="${js}/dz.ajax.js"></script><!-- CONTACT JS  -->
</body>


</html>
