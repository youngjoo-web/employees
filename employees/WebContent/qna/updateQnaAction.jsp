<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="gd.emp.*"%>
<%
	request.setCharacterEncoding("utf-8");
	int no = Integer.parseInt(request.getParameter("qnaNo"));
	String pw = request.getParameter("qnaPw");
	String content = request.getParameter("qnaContent");
	String title = request.getParameter("qnaTitle");
	System.out.println("번호 .."+ no);
	System.out.println("내용 ..."+ content);
	System.out.println("패스워드 ..."+ pw);
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/employees", "root",
			"java1234");
	PreparedStatement stmt1 = conn.prepareStatement("update qna set qna_title=?, qna_content=? where qna_no=?");
	stmt1.setString(1, title);
	stmt1.setString(2, content);
	stmt1.setInt(3, no);
	stmt1.executeUpdate();
	
	response.sendRedirect(request.getContextPath() + "/qna/selectQna.jsp?no="+no);
%>