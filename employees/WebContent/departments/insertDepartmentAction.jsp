<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("utf-8");
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/employees","root","java1234");
	PreparedStatement stmt = conn.prepareStatement("select dept_no from departments order by dept_no desc limit 0, 1");
	//select max(dept_no) from departments
	ResultSet rs = stmt.executeQuery();
	String deptNo = "";
	if(rs.next()){
		deptNo = rs.getString("dept_no");
	}else{
		deptNo = "d000";
	}
	System.out.println("deptNo : " + deptNo);
	
	String deptNo2 = deptNo.substring(1);
	System.out.println("deptNo2 : " + deptNo2);
	
	int deptNo3= Integer.parseInt(deptNo2);
	System.out.println("deptNo3 : " + deptNo3);
	
	int nextDeptNo = deptNo3 + 1;
	System.out.println("nextDeptNo : " + nextDeptNo);
	
	String nextDeptNo2 = "";
	if(nextDeptNo < 10){
		nextDeptNo2 = "d00"+nextDeptNo;
	}else if(nextDeptNo < 100){
		nextDeptNo2 = "d0"+nextDeptNo;
	}else{
		nextDeptNo2 = "d"+nextDeptNo;
	}
	System.out.println(nextDeptNo2);
	String deptName = request.getParameter("deptName");
	PreparedStatement stmt2 = conn.prepareStatement("insert into departments (dept_no,dept_name) VALUES (?,?)");
	stmt2.setString(1,nextDeptNo2);
	stmt2.setString(2,deptName);
	stmt2.executeUpdate();
	response.sendRedirect("./departmentsList.jsp");
%>