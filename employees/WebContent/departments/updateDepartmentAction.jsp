<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*"%>
    
    <%
    	String no = request.getParameter("no");
    	String name = request.getParameter("name");
    	System.out.println("수정할번호..."+no);
    	System.out.println("수정될 이름..."+name);
    	Class.forName("org.mariadb.jdbc.Driver");
    	Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/employees", "root",
    			"java1234");
    	PreparedStatement stmt1 = conn.prepareStatement("update departments set dept_name=? where dept_no=?");
    	stmt1.setString(1,name);
    	stmt1.setString(2,no);
    	stmt1.executeUpdate();
    	response.sendRedirect(request.getContextPath() + "/departments/departmentsList.jsp");
    %>
