<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="gd.emp.QnA"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateForm</title>
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

<%
	request.setCharacterEncoding("utf-8");
	String no = request.getParameter("no");	
	System.out.println("updateFormdeptNo = " + no);
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/employees", "root",
			"java1234");
	PreparedStatement stmt1 = conn.prepareStatement("select * from departments where dept_no=?");
	stmt1.setString(1, no);
	ResultSet rs1 = stmt1.executeQuery();
	if (rs1.next()) {
		System.out.println("수정폼 쿼리결과물 번호 ..."+rs1.getString("dept_no"));
		System.out.println("수정폼 쿼리결과물 이름 ..."+rs1.getString("dept_name"));
%>

<body>
	<div class="container-fluid">
		<h1>수정페이지</h1>
		<form method="post"
			action="<%=request.getContextPath()%>/departments/updateDepartmentAction.jsp">
			<div class="form-group">
				<label for="qnaNo">번호:</label> 
				<input type="text"
					class="form-control" id="no" name="no"
					value=<%=rs1.getString("dept_no")%> readonly="readonly">
			</div>
			<div class="form-group">
				<label for="qnaTile">제목:</label> <input type="text"
					class="form-control" id="name" name="name"
					value=<%=rs1.getString("dept_name")%>>
			</div>
			

			<button type="submit" class="btn btn-primary ">수정</button>
		</form>
	</div>
	
</body>
</html>
<%
	}
		
	
%>
