<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="gd.emp.*"%>
<%@ page import="java.util.*"%>
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
<title>selectQna</title>
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
		request.setCharacterEncoding("utf-8");

		int no = Integer.parseInt(request.getParameter("no"));
		System.out.println("qnaNo = " + no);
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/employees", "root",
				"java1234");
		System.out.println("conn = " + conn);
		PreparedStatement stmt1 = conn.prepareStatement(
				"select qna_no, qna_title, qna_content, qna_user, qna_date from qna where qna_no=?");
		stmt1.setInt(1, no);
		ResultSet rs1 = stmt1.executeQuery();

		System.out.println(rs1);
		QnA q = new QnA();
		if (rs1.next()) {
			q.qnaNo = rs1.getInt("qna_no");
			q.qnaTitle = rs1.getString("qna_title");
			q.qnaContent = rs1.getString("qna_content");
			q.qnaUser = rs1.getString("qna_user");
			q.qnaDate = rs1.getString("qna_date");
		}
	%>
	<div class="container-fluid">
		<h1>상세보기</h1>
		<div>
			<a href="<%=request.getContextPath()%>/qna/qnaList.jsp"
				class="btn btn-secondary">목록</a>
		</div>
		<table class="table">
			<tr>
				<td>번호</td>
				<td><%=q.qnaNo%></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><%=q.qnaUser%></td>
			</tr>
			<tr>
				<td>제목</td>
				<td><%=q.qnaTitle%></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><%=q.qnaContent%></td>
			</tr>
			<tr>
				<td>날짜</td>
				<td><%=q.qnaDate.substring(0, 10)%></td>
			</tr>
		</table>
		<div>
			<a
				href="<%=request.getContextPath()%>/qna/updateQnaForm.jsp?no=<%=q.qnaNo%>"
				class="btn btn-warning">수정</a> <a
				href="<%=request.getContextPath()%>/qna/deleteQnaForm.jsp?no=<%=q.qnaNo%>"
				class="btn btn-danger">삭제</a>
		</div>
		<br>
		<form
			action="<%=request.getContextPath()%>/qna/insertCommentAction.jsp"
			method="post">
			<input type="hidden" name="no" value="<%=q.qnaNo%>">
			<div>
				댓글
				<textarea class="form-control" rows="2" id="comment" name="comment"></textarea>
			</div>
			<div>
				패스워드
				<textarea class="form-control" rows="1" id="pw" name="pw"></textarea>
				<button type="submit" class="btn btn-primary">댓글입력</button>
			</div>
		</form>
		<table class="table">
			<tr class="bg-secondary text-light">
				<td>내용</td>
				<td>날짜</td>
				
			</tr>
			<%
				PreparedStatement stmt2 = conn.prepareStatement("select comment, comment_date from qna_comment where qna_no=?");
				stmt2.setInt(1, no);
				ResultSet rs2 = stmt2.executeQuery();
				while (rs2.next()) {
			%>
			<tr>
				<td><%=rs2.getString("comment") %></td>
				<td><%=rs2.getString("comment_date") %></td>
				
			</tr>
			<%
				}
			%>
			<tr>
			</tr>
		</table>
	</div>

</body>
</html>