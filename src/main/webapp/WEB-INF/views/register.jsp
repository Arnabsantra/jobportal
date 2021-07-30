<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url var="css" value="/resources/css" />
<spring:url var="js" value="/resources/js" />
<spring:url var="images" value="/resources/images" />
<spring:url var="plugins" value="/resources/plugins"/>

<c:set var = "contextRoot" value = "${pageContext.request.contextPath}" />

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
	<link rel="icon" href="images/favicon.ico" type="image/x-icon" />
	<link rel="shortcut icon" type="image/x-icon" href="images/favicon.png" />
	
	<!-- PAGE TITLE HERE -->
	<title>Job Portal - ${title}</title>
	
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
	<link rel="stylesheet" href="${plugins}/datepicker/css/bootstrap-datetimepicker.min.css"/>
	<!-- Revolution Slider Css -->
	<link rel="stylesheet" type="text/css" href="${plugins}/revolution/revolution/css/layers.css">
	<link rel="stylesheet" type="text/css" href="${plugins}/revolution/revolution/css/settings.css">
	<link rel="stylesheet" type="text/css" href="${plugins}/revolution/revolution/css/navigation.css">
	<!-- Revolution Navigation Style -->
</head>

<!-- jquery ui core library -->
<%-- <script src="${js}/jquery-ui.js"></script> --%>
<%-- <script src="${js}/jquery.min.js"></script> --%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>

<script type="text/javascript">

(function ($) {
    $.fn.serializeFormJSON = function () {

        var o = {};
        var a = this.serializeArray();
        $.each(a, function () {
            if (o[this.name]) {
                if (!o[this.name].push) {
                    o[this.name] = [o[this.name]];
                }
                o[this.name].push(this.value || '');
            } else {
                o[this.name] = this.value || '';
            }
        });
        return o;
    };
})(jQuery);

$(document).ready(function() {
    $('#userForm').submit(
        function(event) {
        	var email = $('#emailId').val();
            var data = 'email='
                + encodeURIComponent(email);
            var otpData = JSON.stringify($(this).serializeFormJSON());
             $.ajax({
                url : $("#userForm").attr("action"),
                data : data,
                type : "GET",
 
                success : function(data, textStatus, jqXHR) {
                    $.ajax({
                        url : '${contextRoot}/user/saveTempUserData',
                        data : otpData,
                        type : "POST",
                        contentType: 'application/json; charset=utf-8',
         
                        success : function(data, textStatus, jqXHR) {
                        	document.getElementById('successId').innerHTML = data;
                        	$("#userModal").modal('show');
                        },
                        error : function(xhr, status, error) {
                        	alert("Failure");
                            alert(xhr.responseText);
                            document.getElementById('email_error').innerHTML = xhr.responseText;
                        }
                    });
                    return false;
                },
                error : function(xhr, status, error) {
                    document.getElementById('email_error').innerHTML = xhr.responseText;
                }
            });
            return false;
        });
    });
</script>

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
						<a href="index-2.html"><img src="${images}/logo.png" class="logo" alt=""></a>
					</div>
                    <!-- nav toggle button -->
                    <!-- nav toggle button -->
                    <button class="navbar-toggler collapsed navicon justify-content-end" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
						<span></span>
						<span></span>
						<span></span>
					</button>
                    <!-- Quik search -->
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
								<a href="${contextRoot}">Home </i></a>
								
							</li>
							<li class="active">
								<a href="${contextRoot}/login"class="site-button"><i class="fa fa-lock"></i> login </a>
							</li>
							<!--li>
								<a href="postjob.html">Post Job <i class="fa fa-plus"></i></a>
							</li>-->
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
                    <h1 class="text-white">Register</h1>
					<!-- Breadcrumb row -->
					<div class="breadcrumb-row">
						<ul class="list-inline">
							<li><a href="${contextRoot}">Home</a></li>
							<li>Register</li>
						</ul>
					</div>
					<!-- Breadcrumb row END -->
                </div>
            </div>
        </div>
        <!-- inner page banner END -->
        <!-- contact area -->
        <div class="section-full content-inner shop-account">
            <!-- Product -->
            <div class="container">
                <div class="row">
					<div class="col-md-12 text-center">
						<h3 class="font-weight-700 m-t0 m-b20">Create An Account</h3>
					</div>
				</div>
                <div class="row">
					<div class="col-md-12 m-b30">
						<div class="p-a30 border-1  max-w500 m-auto">
							<div class="tab-content">
								<form class="tab-pane active" action="${contextRoot}/user/chekEmailAvailability" id="userForm" name="userForm" onsubmit="return false">
									<h4 class="font-weight-700">Sign Up</h4>
									<p class="font-weight-600">If already have an account with us, please <a href="${contextRoot}/login">Sign in.</a></p>
									
									<%-- <form:form class="form-group" method="POST" action="${contextRoot}/user/chekEmailAvailability" id="userForm" name="userForm" modelAttribute="user"> --%>
										<div class="form-group">
											<label class="font-weight-700">Organization Name *</label>
											<input type="text" maxlength="80" name="organizationName" required="required" class="form-control" placeholder=" Organization Name"/>
										</div>
										<div class="form-group">
											<label class="font-weight-700">Contact Person's Name *</label>
											<input type="text" maxlength="80" name="contactPerson" required="required" class="form-control" placeholder=" Input Name"/>
										</div>
										<div class="form-group">
											<label class="font-weight-700"> Official Email *</label>
											<input type="email" maxlength="80" name="emailId" id="emailId" required="required" class="form-control" placeholder=" Input Email"/>
											<span class="error"><p id="email_error"></p></span>
										</div>
										<div class="form-group">
											<label class="font-weight-700"> Mobile Number*</label>
											<input type="number" min="1000000000" maxlength="15" name="mobileNo" required="required" class="form-control" placeholder=" Input Number"/>
										</div>
										<div class="form-group">
											<label class="font-weight-700">PASSWORD *</label>
											<input type="password" name="password" maxlength="15" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,15}" title="Must contain at least one number and one uppercase and lowercase letter, and 8-15 characters"
											 required="required" class="form-control" placeholder=" Input Password"/>
										</div>
										<div class="text-left">
											<button class="site-button button-lg outline outline-2" type="submit" name="submit">Sign Up</button>
										</div>
									 <%-- </form:form> --%>
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
    <!-- Content END-->
    <button class="scroltop fa fa-chevron-up" ></button>
</div>
<!-- Modal -->
<div class="modal fade" id="userModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
      </div>
      <div class="modal-body" id="successId">
      </div>
      <div class="modal-footer">
        <button type="submit" class="btn btn-secondary">
        <a href="${contextRoot}/index">Home</a>
        </button>
      </div>
    </div>
  </div>
</div>

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
<script src="${plugins}/paroller/skrollr.min.js"></script><!-- PAROLLER -->
<script src="${js}/custom.js"></script><!-- CUSTOM FUCTIONS  -->
<script src="${js}/dz.carousel.js"></script><!-- SORTCODE FUCTIONS  -->
<script src='${js}/recaptcha/api.js'></script> <!-- Google API For Recaptcha  -->
<script src="${js}/dz.ajax.js"></script><!-- CONTACT JS  -->


</body>


</html>
