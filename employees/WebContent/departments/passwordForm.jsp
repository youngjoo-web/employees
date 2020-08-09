<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="gd.emp.QnA"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>password</title>
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
<!-- 패스워드 입력폼
	1. 데이터베이스의 안전을 위해 패스워드 입력화면 만들기
	2. 부서 리스트에서 수정이나 삭제 버튼누르면 password페이지로 이동하게 한다
	3. 이동할때 선택한 리스트의 번호와 선택한 버튼의 정보를 같이 보낸다
	4. 받아온 데이터를 올바르게 받아왔는지 디버깅한다
	5. 관리자만 기억하는 비밀번호를 설정해놓고 비밀번호가 일치하는지 확인한다.
	6. 일치하면 받아온 번호와 버튼의정보를 가지고 삭제인지 수정인지 역할을 수행할 페이지로 이동한다. -->
<body>
	<%
		String no = request.getParameter("no");
		String btn = request.getParameter("btn");
		System.out.println(no + btn);
		if(btn.equals("delete")){
	%>
	<div class="container-fluid">
		<h1>비밀번호를 입력하시오</h1>
		<form method="post"
			action="<%=request.getContextPath()%>/departments/passwordAction.jsp?no=<%=no%>&btn=delete">
			<div class="form-group">
				<label for="pwd">Password:</label> <input type="password"
					class="form-control" placeholder="Enter password" id="pwd"
					name="pwd">
			</div>
			<button type="submit" class="btn btn-primary">삭제</button>
		</form>
	</div>
	<%
		}else if(btn.equals("update")){
		%>
		<div class="container-fluid">
		<h1>비밀번호를 입력하시오</h1>
		<form method="post"
			action="<%=request.getContextPath()%>/departments/passwordAction.jsp?no=<%=no%>&btn=update">
			<div class="form-group">
				<label for="pwd">Password:</label> <input type="password"
					class="form-control" placeholder="Enter password" id="pwd"
					name="pwd">
			</div>
			<button type="submit" class="btn btn-primary">수정</button>
		</form>
	</div>
		
		<%	
			
			
		}
		
	%>
</body>
</html>