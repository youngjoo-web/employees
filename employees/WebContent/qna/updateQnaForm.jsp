<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>

<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deleteForm</title>
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
</head>
<body>
	<%
	int no = Integer.parseInt(request.getParameter("no"));
	System.out.println("수정하고싶은 항목 번호 ... " + no);
	%>
	<div class="container-fluid">
		<h1>QnA수정</h1>
		<form method="post"
			action="<%=request.getContextPath()%>/qna/updateQnaForm2.jsp?no=<%=no%>">
			<div class="form-group">
				<label for="pwd">Password:</label> <input type="password"
					class="form-control" placeholder="Enter password" id="pwd" name="pwd">
			</div>
			<button type="submit" class="btn btn-primary">수정하기</button>
		</form>
	</div>

</body>
</html>