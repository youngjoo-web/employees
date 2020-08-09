<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="gd.emp.*"%>
<%
	request.setCharacterEncoding("utf-8");
	int no = Integer.parseInt(request.getParameter("no"));
	String pw = request.getParameter("pwd");
	System.out.println("deleteActionqnaNo = " + no);
	System.out.println("deleteActionpw = " + pw);
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/employees", "root",
			"java1234");
	PreparedStatement stmt1 = conn.prepareStatement("delete from qna where qna_no=? and qna_pw=?");
	stmt1.setInt(1,no);
	stmt1.setString(2, pw);
	int row = stmt1.executeUpdate();
	System.out.println("row값 : "+row);
	if(row == 0){
		response.sendRedirect(request.getContextPath() + "/qna/deleteQnaForm.jsp?no="+no);
	}else{
		response.sendRedirect(request.getContextPath() + "/qna/qnaList.jsp");
	}
	
	
	
%>