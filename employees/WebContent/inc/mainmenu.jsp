<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mainmenu</title>
</head>
<body>
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
		<ul class="navbar-nav">
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/index.jsp"><i class='fas fa-home'></i> 홈으로</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/about.jsp"><i class='far fa-address-card'></i> 소개</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/departments/departmentsList.jsp"><i class='fas fa-landmark'></i> departmentsList</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/employees/employeesList.jsp"><i class='fas fa-briefcase'></i> employeesList</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/deptEmp/deptEmpList.jsp"><i class='fab fa-accessible-icon'></i> deptEmpList</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/deptManager/deptManagerList.jsp"><i class='fas fa-user-tie'></i> deptManagerList</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/salaries/salariesList.jsp"><i class='fas fa-balance-scale'></i> salariesList</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/titles/titlesList.jsp"><i class='fas fa-clipboard'></i> titlesList</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/qna/qnaList.jsp"><i class='fas fa-comments'></i> Q / A</a></li>
		</ul>
	</nav>
</body>
</html>