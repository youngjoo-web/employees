<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("utf-8");
	int qnaNo = Integer.parseInt(request.getParameter("no"));
	String comment = request.getParameter("comment");
	String pw = request.getParameter("pw");

	System.out.println("번호 :" + qnaNo + " 내용 : " + comment + " pw : " + pw);
	if (comment.equals("")||pw.equals("")) {
		System.out.println("댓글내용이 없어서 작성이 취소됩니다");
		response.sendRedirect(request.getContextPath() + "/qna/selectQna.jsp?no=" + qnaNo);
		return;//코드진행을 끝낸다		
	} else {
		System.out.println("댓글내용이 업로드됩니다");

		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/employees", "root",
				"java1234");

		PreparedStatement stmt1 = conn.prepareStatement("select max(comment_no) from qna_comment");
		ResultSet rs1 = stmt1.executeQuery();
		int commentNo = 1;
		if (rs1.next()) {
			commentNo = rs1.getInt("max(comment_no)") + 1;
		}
		System.out.println("코멘트 번호 : " + commentNo);
		PreparedStatement stmt2 = conn.prepareStatement(
				"insert into qna_comment (comment_no, qna_no, comment, comment_pw, comment_date) VALUES (?,?,?,?,now())");
		stmt2.setInt(1, commentNo);
		stmt2.setInt(2, qnaNo);
		stmt2.setString(3, comment);
		stmt2.setString(4, pw);
		stmt2.executeUpdate();
		response.sendRedirect(request.getContextPath() + "/qna/selectQna.jsp?no=" + qnaNo);
	}
%>