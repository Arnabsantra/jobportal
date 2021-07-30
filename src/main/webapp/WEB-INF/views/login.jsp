<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<spring:url var="css" value="/resources/css" />
<spring:url var="js" value="/resources/js" />
<spring:url var="images" value="/resources/images" />
<spring:url var="plugins" value="/resources/plugins" />

<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>

<script src="${js}/jquery.min.js"></script><!-- JQUERY.MIN JS -->

<script type="text/javascript">

$(document).on("submit", "#forgot-password", function(e){
    e.preventDefault();
    var email = $('#emaiForgot').val();
    var data = 'email='
        + encodeURIComponent(email);
    $.ajax({
        url : '${contextRoot}/user/fetchByEmail',
        data : data,
        type : "GET",

        success : function(data, textStatus, jqXHR) {
        	$("#userModal").modal('show');
        },
        error : function(xhr, status, error) {
            alert(xhr.responseText);
            document.getElementById('email_error').innerHTML = xhr.responseText;
        }
    });
    
    return  false;
});
</script>

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
	<link rel="icon" href="${images}/Job.png" type="${images}/x-icon" />
	<link rel="shortcut icon" type="${images}/x-icon" href="${images}/Job.png" />
	
	<!-- PAGE TITLE HERE -->
	<title>JobPortal-Login</title>
	
	<!-- MOBILE SPECIFIC -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<!--[if lt IE 9]>
	<script src="js/html5shiv.min.js"></script>
	<script src="js/respond.min.js"></script>
	<![endif]-->
	
	<!-- STYLESHEETS -->
	<link rel="stylesheet" type="text/css" href="${css}/plugins.css">
	<link rel="stylesheet" type="text/css" href="${css}/style.css">
	<link rel="stylesheet" type="text/css" href="${css}/templete.css">
	<link class="skin" rel="stylesheet" type="text/css" href="${css}/skin/skin-1.css">
	<link rel="stylesheet" href="plugins/datepicker/css/bootstrap-datetimepicker.min.css"/>
	<!-- Revolution Slider Css -->
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
						<a href="#"><img src="${images}/Job.png" class="logo" alt=""></a>
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
            </div>
        </div>
        </div>
        <!-- main header END -->
    </header>
    <!-- header END -->
    <!-- Content -->
    <div class="page-content bg-white">
        <!-- inner page banner -->
        <div class="dez-bnr-inr overlay-black-middle bg-pt" style="background-image:url(${images}/banner/bnr2.jpg);">
            <div class="container">
                <div class="dez-bnr-inr-entry">
                    <h1 class="text-white">Login</h1>
					<!-- Breadcrumb row -->
					<div class="breadcrumb-row">
						<ul class="list-inline">
							<li><a href="#">Home</a></li>
							<li>Login</li>
						</ul>
					</div>
					<!-- Breadcrumb row END -->
                </div>
            </div>
        </div>
        <!-- inner page banner END -->
        <!-- contact area -->
        <div class="section-full content-inner-2 shop-account">
            <!-- Product -->
            <div class="container">
                <div class="row">
					<div class="col-md-12 text-center">
						<h3 class="font-weight-700 m-t0 m-b20">Login Your Account</h3>
					</div>
				</div>
                <div>
					<div class="max-w500 m-auto m-b30">
						<div class="p-a30 border-1 seth">
							<div class="tab-content nav">
								<form id="login" action='<spring:url value="/loginAction"/>' method="POST" class="tab-pane active col-12 p-a0 ">
									<h4 class="font-weight-700">LOGIN</h4>
									<p class="font-weight-600">If you have an account with us, please log in.</p>
									<div class="form-group">
										<label class="font-weight-700">E-MAIL *</label>
										<input name = "username" id = "username" required="required" class="form-control" placeholder="Your Email Id" type="email">
									</div>
									<div class="form-group">
										<label class="font-weight-700">PASSWORD *</label>
										<input name = "password" id = "password" required="required" class="form-control " placeholder="Type Password" type="password">
									</div>
									<c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION.message}">
									  <div class="error">
									    <c:out value="${SPRING_SECURITY_LAST_EXCEPTION.message}" />
									  </div>
									</c:if>
									<div class="text-left">
										<button class="site-button m-r5 button-lg" type="submit">login</button>
										<a data-toggle="tab" href="#forgot-password" class="m-l5"><i class="fa fa-unlock-alt"></i> Forgot Password</a><br>


										<br>
										<p class="font-weight-600">Don't have an account!</p> 
										<a href="${contextRoot}/user/userForm" class="button">Sign Up</a> |
										<a href="${contextRoot}/index" class="button">Home</a>
									</div>
								</form>
								<form id="forgot-password" class="tab-pane fade  col-12 p-a0">
									<h4 class="font-weight-700">FORGET PASSWORD ?</h4>
									<p class="font-weight-600">We will send you a link in your email to reset your password. Please click on that link. </p>
									<div class="form-group">
										<label class="font-weight-700">E-MAIL *</label>
										<input name="dzName" required="required" id="emaiForgot" class="form-control" placeholder="Your Email Id" type="email">
										<span class="error"><p id="email_error"></p></span>
									</div>
									<div class="text-left"> 
										<a class="site-button outline gray button-lg" data-toggle="tab" href="${contextRoot}/login">Back</a>
										<button type="submit" id="submitBtn" class="site-button pull-right button-lg">Submit</button>
									</div>
									<p class="font-weight-600">If you have an account with us, please log in.</p>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
            <!-- Product END -->
		</div>
		<!-- contact area  END -->
    </div>
    <div class="modal fade" id="userModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
      </div>
      <div class="modal-body">
        Email sent to your registered mail id. Please click on the link to reset password.
      </div>
      <div class="modal-footer">
        <button type="submit" class="btn btn-secondary">
        <a href="${contextRoot}/index">Home</a>
        </button>
      </div>
    </div>
  </div>
</div>
    <!-- Content END-->
    <!-- Footer -->
    
    <!-- Footer END -->
    <button class="scroltop fa fa-chevron-up" ></button>
</div>
<!-- JAVASCRIPT FILES ========================================= -->
<script src="${js}/jquery.min.js"></script><!-- JQUERY.MIN JS -->
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
<script src="${js}/dz.ajax.js"></script><!-- CONTACT JS  --> 

</body>


</html>
