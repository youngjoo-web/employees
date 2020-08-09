<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Index</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">

<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- Popper JS -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>

<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
	integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ"
	crossorigin="anonymous">
<style>
/* Make the image fully responsive */
.carousel-inner img {
	width: 100%;
	height: 100%;
}
</style>
</head>
<body>
	<div class="container-fluid">
		<!-- Navigation MainMenu -->
		<div>
			<jsp:include page="/inc/mainmenu.jsp"></jsp:include>
		</div>
		<h1>INDEX</h1>
		<div id="demo" class="carousel slide" data-ride="carousel">

			<!-- Indicators -->
			<ul class="carousel-indicators">
				<li data-target="#demo" data-slide-to="0" class="active bg-success"></li>
				<li data-target="#demo" data-slide-to="1" class="bg-success"></li>
				<li data-target="#demo" data-slide-to="2" class="bg-success"></li>
				<li data-target="#demo" data-slide-to="3" class="bg-success"></li>
				<li data-target="#demo" data-slide-to="4" class="bg-success"></li>
				<li data-target="#demo" data-slide-to="6" class="bg-success"></li>
				<li data-target="#demo" data-slide-to="7" class="bg-success"></li>
			</ul>

			<!-- The slideshow -->
			<div class="carousel-inner">
				<div class="carousel-item active">
					<img src="/employees/img/iu.jpg" alt="아이유">
				</div>
				<div class="carousel-item ">
					<img src="/employees/img/by.jpg" alt="박보영">
				</div>			
				<div class="carousel-item">
					<img src="/employees/img/srg.jpg" alt="슬기">
				</div>
				<div class="carousel-item">
					<img src="/employees/img/k.jpeg" alt="케이">
				</div>
				<div class="carousel-item">
					<img src="/employees/img/sg.jpg" alt="이성경">
				</div>
				<div class="carousel-item">
					<img src="/employees/img/ai.jpg" alt="아이린">
				</div>
				<div class="carousel-item">
					<img src="/employees/img/dh.jpg" alt="다현">
				</div>
			</div>

			<!-- Left and right controls -->
			<a class="carousel-control-prev " href="#demo" data-slide="prev">
				<span class="carousel-control-prev-icon "></span>
			</a> <a class="carousel-control-next " href="#demo" data-slide="next">
				<span class="carousel-control-next-icon "></span>
			</a>

		</div>
	</div>
</body>
</html>