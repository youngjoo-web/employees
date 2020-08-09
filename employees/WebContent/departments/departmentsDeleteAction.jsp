<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%

	String id = request.getParameter("no");
	System.out.print(id);
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/employees","root","java1234");
	PreparedStatement stmt = conn.prepareStatement
			("delete from departments where dept_no=?");
	stmt.setString(1, id);
	stmt.executeUpdate();
	response.sendRedirect(request.getContextPath() + "/departments/departmentsList.jsp");
%>