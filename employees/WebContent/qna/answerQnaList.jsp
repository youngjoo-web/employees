<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<!-- 1. 리스트에서 받아온 qnaNo값을 디버깅한다
	 2. 올바르게 받아온 값을 정수형으로 바꾼다
	 3. qnaNo의 값에 연결된 데이터값을 가져온다
	 4. 데이터의 타이틀을 출력하고 내용 이름 날짜 를 출력한다
	 5. 출력된 내용 밑에 댓글을 달수있도록 input타입을 만든다
	 6. 텍스트입력창 밑에는 입력했던 댓글의 이름 내용 날짜 가 출력된 리스트를 만든다 -->
<html>
<head>
<meta charset="UTF-8">
<title>QnAcontent</title>
</head>
<body>
	<%
		int no = Integer.parseInt(request.getParameter("no"));
		System.out.println(no);
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/employees", "root",
				"java1234");
		PreparedStatement stmt1 = conn.prepareStatement("select qna_content from qna where qna_no=?");
		stmt1.setInt(1,no);
		ResultSet rs1 = stmt1.executeQuery();
		
		System.out.println(rs1);
	%>
</body>
</html>