<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="gd.emp.*"%>
<%
	String pw = request.getParameter("pwd" );
	System.out.println("입력한pw.." + pw );
	String btn = request.getParameter("btn");
	String no = request.getParameter("no");
	System.out.println("입력한버튼.." + btn );
	System.out.println("입력한항목번호.." + no );
	if(pw.equals("9449")){
		System.out.println("관리자님 안녕하세요!");
		if(btn.equals("update")){
			response.sendRedirect(request.getContextPath() + "/departments/updateDepartmentForm.jsp?no="+no);
		}else if(btn.equals("delete")){
			response.sendRedirect(request.getContextPath() + "/departments/departmentsDeleteAction.jsp?no="+no);
		}
		
	}else{
		System.out.println("비밀번호 오류!");
	response.sendRedirect(request.getContextPath() + "/departments/departmentsList.jsp");
	}
%>