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
<script src="${js}/jquery.min.js"></script><!-- JQUERY.MIN JS -->
<script src="${plugins}/bootstrap/js/bootstrap.min.js"></script><!-- BOOTSTRAP.MIN JS -->
<script type="text/javascript">

function checkValue(jobId, countId) {
	var comment = $('#message-text'+countId).val();
    var data = 'jobId='+encodeURIComponent(jobId) 
	$.ajax({
       url : '${contextRoot}/job/fetchComment',
       data : data,
       type : "GET",

       success : function(data, textStatus, jqXHR) {
       	document.getElementById('message-text'+countId).innerHTML = data;
       },
       error : function(xhr, status, error) {
       	alert("Failure");
           alert(xhr.responseText);
           document.getElementById('message-text'+countId).innerHTML = xhr.responseText;
       }
   });
	return false;
	
}

function saveData(jobId, countId){
    	var comment = $('#message-text'+countId).val();
    	 var data = 'comment='
             + encodeURIComponent(comment)+'&jobId='+encodeURIComponent(jobId);
    	$.ajax({
            url : '${contextRoot}/job/saveComment',
            data : data,
            type : "POST",

            success : function(data, textStatus, jqXHR) {
            	alert("input Saved Successfully");
            },
            error : function(xhr, status, error) {
            	alert("Failure");
                alert(xhr.responseText);
                document.getElementById('message-text'+countId).innerHTML = xhr.responseText;
            }
        });
}

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
							
                            <sec:authorize access="hasAnyRole('ROLE_ADMIN')">
                            <li>
								<a href="#">Approvals <i class="fa fa-chevron-down"></i></a>
								<ul class="sub-menu">
									<li><a href="${contextRoot}/job/viewCreatedJob" class="dez-page">Approve Job</a></li>
									<li><a href="${contextRoot}/user/viewCreatedUser" class="dez-page">Approve User</a></li>
									
								</ul>
							</li>
							</sec:authorize>
							<c:if test="${pageContext.request.userPrincipal.name != null}">
									<li class="active"><a href="${contextRoot}/logout" class="site-button"><i
										class="fa fa-lock"></i> logout </a></li>
							</c:if>
							<sec:authorize access="hasAnyRole('ROLE_RECRUITER')">
							<li><a href="${contextRoot}/job/viewJobDetails" class="dez-page">Post Job</a></li>
							</sec:authorize>
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
                    <h1 class="text-white">Job Details</h1>
					<!-- Breadcrumb row -->
					<div class="breadcrumb-row">
						<ul class="list-inline">
							<li><a href="#">Home</a></li>
							<li>Job Details</li>
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
              	<th>Job Title</th>
                <th>Company Name</th>
                <th>Experience</th>
                <th>CTC</th>
                <th>Action</th>
              </tr>
              </thead>
              <tbody>
              <c:set var="count" value="0" scope="page" />
					<c:forEach items="${jobList}" var="job">
						<c:set var="count" value="${count + 1}" scope="page"/>
              <tr>
              	<td>${count}</td>
                <td><a href="${contextRoot}/job/viewJobDetails?jobId=${job.jobId}&pageType=view" data-toggle="tooltip"> ${job.jobTitle}</a></td>
                <td>${job.companyName}</td>
                <td>${job.experience}</td>
                <td>${job.ctc}</td>
                <td>
                <sec:authorize access="hasAnyRole('ROLE_RECRUITER')">
                <a href="${contextRoot}/job/viewJobDetails?jobId=${job.jobId}&pageType=edit" class="button"><i
										class="fa fa-user"></i> Edit</a> |
				</sec:authorize>
				<a href="${contextRoot}/job/deleteJob?jobId=${job.jobId}" class="button" ><i
										class="fa fa-user"></i> Delete</a> |
				<a href="#" class="button" data-toggle="modal" data-target="#myModal${count}" onclick="checkValue(${job.jobId},${count})"><i
										class="fa fa-user"></i> Reply</a>
				<%-- <button type="button" class="button" data-toggle="modal" data-target="#myModal${count}" onclick="checkValue(${job.jobId},${count})">
				  <i class="fa fa-reply"></i> Comment
				</button> --%>
				</td>
              </tr>
              
              <!-- Modal -->
<div class="modal fade" id="myModal${count}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">New message</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form>
          <!-- <div class="form-group">
            <label for="recipient-name" class="col-form-label">Recipient:</label>
            <input type="text" class="form-control" id="recipient-name">
          </div> -->
          <div class="form-group">
            <label for="message-text" class="col-form-label">Message:</label>
            <textarea maxlength="8000" class="form-control" name="message-text${count}" id="message-text${count}"></textarea>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="submit" id="submitBtn${count}" onclick="saveData(${job.jobId},${count})" class="btn btn-primary">Save</button>
      </div>
    </div>
  </div>
</div>
              
              </c:forEach>
              </tbody>
            </table>
            

			<!-- <textarea id="myTextArea" style="display: none;"></textarea> -->
            
            
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
