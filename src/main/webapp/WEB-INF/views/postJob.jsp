<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<spring:url var="css" value="/resources/css" />
<spring:url var="js" value="/resources/js" />
<spring:url var="images" value="/resources/images" />
<spring:url var="plugins" value="/resources/plugins" />

<c:set var="contextRoot" value="${pageContext.request.contextPath}" />



<!DOCTYPE html>
<html lang="en">

<script src="${js}/jquery.min.js"></script><!-- JQUERY.MIN JS -->
<script type="text/javascript">
/* function test1() {
	var selections = ${employmentType}.split;
	alert(selection);
	return false;
} */


$(document).ready(function(){
	var selections = ($("#employmentTypeId").val()).split(',');
	if($("#option1").val() == selections[0] || $("#option1").val() == selections[1]) {
		$("#option1").attr('checked', true);
	}
	if($("#option2").val() == selections[0] || $("#option2").val() == selections[1]) {
		$("#option2").attr('checked', true);
	}
	if($("#option3").val() == selections[0] || $("#option3").val() == selections[1]) {
		$("#option3").attr('checked', true);
	}
	});
</script>

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
	<title>JobPortal-PostJob</title>
	
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
								<a href="${contextRoot}">Home </i></a>
								
							</li>
							<li><a href="${contextRoot}/job/jobDetails" class="dez-page">Job Details</a></li>
							<c:if test="${pageContext.request.userPrincipal.name != null}">
									<li class="active"><a href="${contextRoot}/logout" class="site-button"><i
										class="fa fa-lock"></i> logout </a></li>
								</c:if>
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
        <div class="dez-bnr-inr overlay-black-dark" style="background-image:url(${images}/banner/bnr1.jpg);">
            <div class="container">
                <div class="dez-bnr-inr-entry">
				<c:choose>               
                <c:when test="${empty pageName}">
                    <h1 class="text-white">Post Job</h1>
                    </c:when>
                    <c:otherwise>
					<h1 class="text-white">${pageName}</h1>                    
                    </c:otherwise>
                    </c:choose>
					<!-- Breadcrumb row -->
					<div class="breadcrumb-row">
						<ul class="list-inline">
							<li><a href="${contextRoot}">Home</a></li>
							<c:choose>               
                	<c:when test="${empty pageName}">
							<li>Post Job</li>
					</c:when>
					<c:otherwise>
							<li>${pageName}</li>
					</c:otherwise>
					</c:choose>
						</ul>
					</div>
					<!-- Breadcrumb row END -->
                </div>
            </div>
        </div>
        <!-- inner page banner END -->
        <!-- contact area -->
        <div class="content-block">
			<!-- Submit Resume -->
			<div class="section-full bg-white submit-resume content-inner-2">
				<div class="container">
					<form:form class="container" action="${contextRoot}/job/saveOrUpdateJob" method="POST" modelAttribute="jobDetail" enctype="multipart/form-data">
						<div class="form-group">
							<label>Job Title</label>
							<form:input type="text" maxlength="100" required="required" path="jobTitle" value="${jobTitle}" class="form-control" placeholder="Enter Your Job Title" />
						</div>
						<div class="form-group">
							<label>CTC Range</label>
							<form:input type="text" maxlength="20" required="required" path="ctc" value="${ctc}" class="form-control" placeholder="Enter Range"/>
						</div>
						<div class="form-group">
							<label>Designation</label>
							<form:input type="text" maxlength="100" required="required" path="designation" value="${designation}" class="form-control" placeholder="Enter Designation"/>
                        </div>
                             <div class="form-group">
                            <label>Number of Positions </label>
                            <form:input type="number" maxlength="4" required="required" path="noOfPosition" value="${noOfPosition}" class="form-control" placeholder="Positions"/>
                            </div>
                            <div class="form-group">
                                <label>Experience Range</label>
                                <form:input type="text" maxlength="20" required="required" path="experience" value="${experience}" class="form-control" placeholder="Experience"/>
                            </div>
                            <div class="form-group">
                                <label>Notice Period</label>
                                <form:input type="text" maxlength="20" required="required" path="noticePeriod" value="${noticePeriod}" class="form-control" placeholder="Notice Period"/>
                            </div>
                        <div class="form-group">
                         <label >Key Skills</label>
						 <form:input type="text" maxlength="100" required="required" path="keySkills" value="${keySkills}" class="form-control" placeholder="Enter Your Key Skills"/>
                            </div>
                            <div class="form-group">
                                <label >Job Location</label>
								<form:input type="text" maxlength="20" required="required" path="jobLocation" value="${jobLocation}" class="form-control" placeholder="Enter Location"/>
                                   </div>
                                 <div class="form-group">
                                <label >Company Name</label>
								<form:input type="text" maxlength="80" required="required" path="companyName" value="${companyName}" class="form-control" placeholder="Enter Company Name"/>
                                   </div> 
                                   <div class="form-group">
                                <label >Job Details</label>
								<form:textarea type="text" maxlength="2000" required="required" path="jobDetails" value="${jobDetails}" class="form-control" placeholder="Enter Job Details"/>
                                   </div>  
                                   <br>
                                   <div class="form-group">
                                    <label class="label label-default"> Employment Type </label>
                                    <br>
                                        <div class="btn-group btn-group-toggle" data-toggle="buttons">
                                        <label class="btn btn-light active">
                                          <form:checkbox path="employmentTypeArray" value="Full Time" name="options" id="option1" autocomplete="off" /> Full Time
                                        </label>
                                        <label class="btn btn-light">
                                          <form:checkbox path="employmentTypeArray" value="Part Time" name="options" id="option2" autocomplete="off"/> Part Time
                                        </label>
                                        <label class="btn btn-light">
                                          <form:checkbox path="employmentTypeArray" value="Contract" name="options" id="option3" autocomplete="off"/> Contract
                                        </label>
                                      </div>
                                  </div>   <br>
                                  <br>

                                       
						<div class="form-group">
							<label>Attach Media</label>
							<div class="custom-file">
								<input type="file" class="site-button" name="jdFile"/>
								<form:input disabled="true" path="jdFileName" value="${jdFileName}"/>
							</div>
						</div>
                        <br>


                        <br>
                        
						<c:if test="${pageType ne 'view'}">
						<button type="submit" class="site-button">Submit</button>
						</c:if>
						<form:hidden path="jobId" value="${jobId}" class="form-control" />
						<form:hidden path="comments" value="${comments}" class="form-control" />
						<form:hidden path="employmentType" id="employmentTypeId" value="${employmentType}" class="form-control" />
						<form:hidden path="jobStatus" value="${jobStatus}" class="form-control" />
						<form:hidden path="userDetail.userId" value="${userDetail.userId}" class="form-control" />
						<%-- <form:hidden path="jdFileName" value="${jdFileName}" class="form-control" /> --%>
					</form:form>
				</div>
			</div>
            <!-- Submit Resume END -->
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
<script src="${js}/recaptcha/api.js"></script> <!-- Google API For Recaptcha  -->
<script src="${js}/dz.ajax.js"></script><!-- CONTACT JS  -->
<script src="${plugins}/paroller/skrollr.min.js"></script><!-- PAROLLER -->
<script type="text/javascript">

			$("#exp-slider-range").slider({
				range: true,
				min: 0,
				max: 10,
				//values: [0, 10],
				slide: function(event, ui) {
					var min = ui.values[0],
						max = ui.values[1];
					  $('#' + this.id).prev().val( min + " year - " + max + " year");
				}
			});
			
			$("#salary-slider-range").slider({
				range: true,
				min: 10,
				max: 100,
				//values: [10, 1000],
				slide: function(event, ui) {
					var min = ui.values[0],
						max = ui.values[1];
					  $('#' + this.id).prev().val(min + "K - " + max + "K");
				}
			});
		
</script>
</body>


</html>
