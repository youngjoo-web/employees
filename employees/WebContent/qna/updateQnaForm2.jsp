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
<!-- update
	1. 전페이지에서 받아온 비밀번호 출력
	2. 게시글의 번호도 출력
	3. 조건문으로 받아온 비밀번호가 정해진 비밀번호와 일치하는지 구분
	4. 일치하면 수정가능하게 창 띄우고
	5. 일치하지않으면 다시 비밀번호 입력창으로 돌려보내기 -->
<%
	request.setCharacterEncoding("utf-8");
	int no = Integer.parseInt(request.getParameter("no"));
	String pw = request.getParameter("pwd");
	System.out.println("updateActionqnaNo = " + no);
	System.out.println("updateActionpw = " + pw);
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/employees", "root",
			"java1234");
	PreparedStatement stmt1 = conn.prepareStatement("select * from qna where qna_no=? and qna_pw=?");
	stmt1.setInt(1, no);
	stmt1.setString(2, pw);
	ResultSet rs = stmt1.executeQuery();
	if (rs.next()) {

		System.out.println("pw : " + pw + "비밀번호 맞음...수정페이지로 넘어감");
%>

<body>
	<div class="container-fluid">
		<h1>수정페이지</h1>
		<form method="post"
			action="<%=request.getContextPath()%>/qna/updateQnaAction.jsp">
			<div class="form-group">
				<label for="qnaNo">번호:</label> 
				<input type="text"
					class="form-control" id="qnaNo" name="qnaNo"
					value=<%=rs.getInt("qna_no")%> readonly="readonly">
			</div>
			<div class="form-group">
				<label for="qnaTile">제목:</label> <input type="text"
					class="form-control" id="qnaTitle" name="qnaTitle"
					value=<%=rs.getString("qna_title")%>>
			</div>
			<div class="form-group">
				<label for="qnaContent">내용 :</label>
				<textarea class="form-control" rows="5" id="qnaContent"
					name="qnaContent"></textarea>
			</div>

			<div class="form-group">
				<label for="qnaUser">비밀번호:</label> <input type="text"
					class="form-control" id="qnaPw" name="qnaPw"
					value=<%=rs.getString("qna_pw")%> readonly="readonly">
			</div>

			<button type="submit" class="btn btn-primary ">수정</button>
		</form>
	</div>
</body>
</html>
<%
	} else {
		System.out.println("pw : " + pw + "비밀번호 틀림 ...비밀번호 입력칸으로 돌아감");
		response.sendRedirect(request.getContextPath() + "/qna/updateQnaForm.jsp?no=" + no);
	}
%>
