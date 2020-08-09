<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="gd.emp.*"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>departmentsList</title>
<!-- Latest compiled and minified CSS -->
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

<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
	integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ"
	crossorigin="anonymous">
</head>
<body>
	<div class="container-fluid">
		<%
			request.setCharacterEncoding("utf-8");
			//  1. 페이지
			String searchWord = "";
			String col = "";
			if (request.getParameter("searchWord") != null) {
				searchWord = request.getParameter("searchWord");
				if (request.getParameter("col") != null) {
					col = request.getParameter("col");
					System.out.println("검색어..." + searchWord);
					System.out.println("키워드..." + col);
				}
			}

			int currentPage = 1;//초기값은 1
			System.out.println(currentPage);
			if (request.getParameter("currentPage") != null) {//값이 넘어오면 조건문실행
				currentPage = Integer.parseInt(request.getParameter("currentPage"));
				System.out.println(currentPage);
			}
			int rowPerPage = 5;
			int beginRow = (currentPage - 1) * rowPerPage;

			//	2-1 . database
			Class.forName("org.mariadb.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/employees", "root",
					"java1234");
			//	2-2 . 현재의 departments 테이블 행
			ArrayList<Departments> list = new ArrayList<Departments>(); //현재 페이지 행을 저장할 변수
			PreparedStatement stmt1 = null;
			ResultSet rs1 = null;
			if (searchWord.equals("")) {
				stmt1 = conn
						.prepareStatement("select dept_no, dept_name from departments order by dept_no asc limit ?,?");
				stmt1.setInt(1, beginRow);
				stmt1.setInt(2, rowPerPage);
			} else {
				if (col.equals("no")) {
					stmt1 = conn.prepareStatement(
							"select * from departments where dept_no like ? order by dept_no asc limit ?,?");
					stmt1.setString(1, "%" + searchWord + "%");
					stmt1.setInt(2, beginRow);
					stmt1.setInt(3, rowPerPage);
				} else {
					stmt1 = conn.prepareStatement(
							"select * from departments where dept_name like ? order by dept_no asc limit ?,?");
					stmt1.setString(1, "%" + searchWord + "%");
					stmt1.setInt(2, beginRow);
					stmt1.setInt(3, rowPerPage);
				}
			}
			rs1 = stmt1.executeQuery();
			while (rs1.next()) {
				Departments d = new Departments();
				d.deptNo = rs1.getString("dept_no");
				d.deptName = rs1.getString("dept_name");
				list.add(d);
			}
			System.out.println(list.size());
			//	3. departments 테이블 전체행의 수
			int totalRow = 0;
			PreparedStatement stmt2 = null;
			ResultSet rs2 = null;
			if (searchWord.equals("")) {
				stmt2 = conn.prepareStatement("select count(*) from departments");
			} else {
				if (col.equals("no")) {
					stmt2 = conn.prepareStatement("select count(*) from departments where dept_no like ? ");
					stmt2.setString(1, "%" + searchWord + "%");
				} else {
					stmt2 = conn.prepareStatement("select count(*) from departments where dept_name like ? ");
					stmt2.setString(1, "%" + searchWord + "%");
				}
			}
			rs2 = stmt2.executeQuery();
			if (rs2.next()) {
				totalRow = rs2.getInt("count(*)");
			}
			int lastPage = totalRow / rowPerPage;//마지막 페이지를 저장할 변수
			if (totalRow % rowPerPage != 0) {//총데이터갯수/한페이지당 데이터갯수 에 나머지가 생길경우
				lastPage += 1;//페이지 하나더 추가해서 나머지 출력
			}
			System.out.println("마지막 페이지 쪽수 = " + lastPage);//마지막페이지 디버깅
		%>
		<div>
			<jsp:include page="/inc/mainmenu.jsp"></jsp:include>
		</div>
		<div class="row">
			<div class="col-sm-2"></div>
			<div class="col-sm-8">
				<h1>departmentsList</h1>
				<div class="row">
					<div class="col-sm-10">

						<form method="post"
							action="<%=request.getContextPath()%>/departments/departmentsList.jsp">
							<select name="col">
								<option value="no">번호</option>
								<option value="name">이름</option>
							</select> <input type="text" name="searchWord">
							<button type="submit" class="btn btn-primary">검색</button>
						</form>
					</div>
					<div class="col-sm-2">
						<a
							href="<%=request.getContextPath()%>/departments/insertDepartmentForm.jsp"
							class="btn btn-secondary d-flex justify-content-center">부서입력</a>
					</div>
				</div>

				<table border=1
					class="bg-dark text-light table table-dark table-hover">
					<thead>
						<tr>
							<th>deptNo</th>
							<th>deptName</th>
						</tr>
					</thead>
					<tbody class="bg-secondary text-light table table-dark ">
						<%
							for (Departments d : list) {
						%>
						<tr>
							<td><%=d.deptNo%></td>
							<td><%=d.deptName%></td>
							<td><a
								href="<%=request.getContextPath()%>/departments/passwordForm.jsp?no=<%=d.deptNo%>&btn=update"
								class="btn btn-warning">수정</a></td>
							<td><a
								href="<%=request.getContextPath()%>/departments/passwordForm.jsp?no=<%=d.deptNo%>&btn=delete"
								class="btn btn-danger">삭제</a></td>
						</tr>
						<%
							}
						%>
					</tbody>
				</table>
				<div class="d-flex justify-content-center">
					<%
						if (currentPage > 1) {
					%>
					<a
						href="<%=request.getContextPath()%>/departments/departmentsList.jsp?currentPage=<%=currentPage - 1%>&searchWord=<%=searchWord%>&col=<%=col%>"
						class="btn btn-outline-primary">이전페이지</a>
					<%
						}
					%>
					<%
						// 전체 몇 페이지가 필요한 지 체크
						// 10의 배수가 아닐 경우 +1 ex) 19개 데이터 => 19 / 10 = 몫:1 -> 2페이지 필요
						if ((totalRow % rowPerPage) == 0) {
							lastPage = totalRow / rowPerPage;
						} else {
							lastPage = (totalRow / rowPerPage) + 1; //lastPage구하기
						}

						//1~10page 그룹 시작페이지
						int groupStartPage = 0; // 0=1~10페이지        1=11~20페이지
						int pagePerGroup = 10; //한 화면당 하단 페이지 목록 수

						//하단 1~10 페이지 출력
						//페이지 그룹으로 총 10 * x개의 그룹 확인
						//10의 배수일 경우  - 1
						if (currentPage % pagePerGroup == 0) { //현재 페이지가 10의 배수 일 경우 (0포함)
							groupStartPage = currentPage / pagePerGroup - 1; //페이지 목록 의 시작 페이지 는 ((현재 페이지 나누기 10)-1)
							//System.out.println(groupStartPage);
							for (int i = (groupStartPage * 10) + 1; i <= (groupStartPage * 10) + 10; i = i + 1) { //반복문의 i를 페이지 목록 첫번째 숫자로 하고 그뒤로 10번 반복
					%>
					<a
						href="<%=request.getContextPath()%>/departments/departmentsList.jsp?currentPage=<%=i%>&searchWord=<%=searchWord%>&col=<%=col%> "
						class="
			btn btn-outline-primary"><%=i%></a>

					<%
						}
						} else {
							groupStartPage = currentPage / pagePerGroup; //현재 페이지가 10의 배수가 아닐경우
							//System.out.println(groupStartPage);
							if (lastPage < (groupStartPage * 10) + 10) {
								for (int i = (groupStartPage * 10) + 1; i <= lastPage; i = i + 1) {
					%>
					<a
						href="<%=request.getContextPath()%>/departments/departmentsList.jsp?currentPage=<%=i%>&searchWord=<%=searchWord%>&col=<%=col%>"
						class="
			btn btn-outline-primary"><%=i%></a>
					<%
						}
							} else {
								for (int i = (groupStartPage * 10) + 1; i <= (groupStartPage * 10) + 10; i = i + 1) {
					%>
					<a
						href="<%=request.getContextPath()%>/departments/departmentsList.jsp?currentPage=<%=i%>&searchWord=<%=searchWord%>&col=<%=col%>"
						class="
			btn btn-outline-primary"><%=i%></a>
					<%
						}
							}
						}
					%>
					<%
						if (currentPage < lastPage) {
					%>
					<a
						href="<%=request.getContextPath()%>/departments/departmentsList.jsp?currentPage=<%=currentPage + 1%>&searchWord=<%=searchWord%>&col=<%=col%>"
						class="btn btn-outline-primary">다음페이지</a>
					<%
						}
					%>
				</div>
				<div class="col-sm-2"></div>
			</div>
		</div>
	</div>
</body>
</html>