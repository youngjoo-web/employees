<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.sql.*"%>
<%@ page import="gd.emp.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deptManagerList</title>
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
			String searchWord = "";
			String col = "";
			int searchNo=0;
			if (request.getParameter("searchWord") != null) {
				searchWord = request.getParameter("searchWord");
				col = request.getParameter("col");
				if(col.equals("empNo")){
					try{
						searchNo = Integer.parseInt(request.getParameter("searchWord"));
					}catch(Exception e){
						searchWord = "";
					}
				}
			}
			System.out.println("타이틀 검색어..." + searchWord);
			System.out.println("타이틀 검색 카테고리..." + col);
			int currentPage = 1;//첫 페이지 저장할 변수 초기값 1
			System.out.println("currentPage = " + currentPage);//디버깅(확인)
			if (request.getParameter("currentPage") != null) {//값이 넘어오면 조건문 실행
				currentPage = Integer.parseInt(request.getParameter("currentPage"));
				System.out.println("if문 currentPage = " + currentPage);//조건문 실행된후 바뀐 currentpage디버깅
			}
			int rowPerPage = 10;//한 페이지에 들어갈 데이터 수
			int beginRow = (currentPage - 1) * rowPerPage;//페이지의 맨위에 나타날 데이터
			//데이터 베이스 연결
			Class.forName("org.mariadb.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/employees", "root",
					"java1234");

			ArrayList<Titles> list = new ArrayList<Titles>();//현재 패이지 행을 저장할 변수
			PreparedStatement stmt1 = null;//쿼리문 저장할 변수
			ResultSet rs1 = null;//쿼리문에 의한 데이터값 저장할 변수
			if (searchWord == "") {
				stmt1 = conn.prepareStatement(
						"select emp_no, title, from_date, to_date from titles order by emp_no asc limit ?,?");
				//쿼리문 : employees테이블에 데이터 (번호, 생일, 성씨, 이름, 성별, 고용날자)를 불러와서 번호순서대로 ?부터 ?까지 나열하시오
				stmt1.setInt(1, beginRow);//첫번째 물음표에 들어갈 변수
				stmt1.setInt(2, rowPerPage);//두번째 물음표에 들어갈 변수
			} else {
				
				if (col.equals("empNo")) {
					
					stmt1 = conn.prepareStatement(
							"select emp_no, title, from_date, to_date from titles where emp_no like ? order by emp_no asc limit ?,?");
					//쿼리문 : employees테이블에 데이터 (번호, 생일, 성씨, 이름, 성별, 고용날자)를 불러와서 번호순서대로 ?부터 ?까지 나열하시오
					stmt1.setString(1, "%" +searchNo+ "%");//첫번째 물음표에 들어갈 변수
					stmt1.setInt(2, beginRow);//첫번째 물음표에 들어갈 변수
					stmt1.setInt(3, rowPerPage);//두번째 물음표에 들어갈 변수
					System.out.println("직원번호 선택 확인");
				}else{
					stmt1 = conn.prepareStatement(
							"select emp_no, title, from_date, to_date from titles where title like ? order by emp_no asc limit ?,?");
					//쿼리문 : employees테이블에 데이터 (번호, 생일, 성씨, 이름, 성별, 고용날자)를 불러와서 번호순서대로 ?부터 ?까지 나열하시오
					stmt1.setString(1,"%"+searchWord+"%" );//첫번째 물음표에 들어갈 변수
					stmt1.setInt(2, beginRow);//두번째 물음표에 들어갈 변수
					stmt1.setInt(3, rowPerPage);//두번째 물음표에 들어갈 변수
					System.out.println("직원직업선택");
				}
			}
			rs1 = stmt1.executeQuery();//stmt1쿼리 실행 후 저장
			while (rs1.next()) {//쿼리 실행 결과 데이터가 있으면 계속 반복
				Titles t = new Titles();//쿼리 실행결과 데이터로 리스트 작성
				t.empNo = rs1.getInt("emp_no");
				t.title = rs1.getString("title");
				t.fromDate = rs1.getString("from_date");
				t.toDate = rs1.getString("to_date");

				list.add(t);
			}
			System.out.println("list.size() = " + list.size());//리스트 크기 출력 디버깅

			int totalRow = 0;//총 데이터 갯수를 저장할 변수
			PreparedStatement stmt2 = null;
			ResultSet rs2 = null;
			if (searchWord == "") {
				stmt2 = conn.prepareStatement("select count(*) from titles");//데이터의 갯수를 구하라
			} else {
				if (col.equals("empNo")) {
					
					stmt2 = conn.prepareStatement("select count(*) from titles where emp_no like ?");
					stmt2.setString(1, "%" + searchNo + "%");
				} else {
					stmt2 = conn.prepareStatement("select count(*) from titles where title like ?");
					stmt2.setString(1, "%" + searchWord + "%");
				}
			}
			rs2 = stmt2.executeQuery();//쿼리문 실행 결과 저장
			if (rs2.next()) {//조건문 : 데이터가 있으면 'totalRow'변수에 값 을 정수형으로 저장
				totalRow = rs2.getInt("count(*)");
			}
			System.out.println("총 데이터 갯수 = " + totalRow);//데이터 갯수 디버깅
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
		<h1>title</h1>
		<div>
			<form method="post"
				action="<%=request.getContextPath()%>/titles/titlesList.jsp">
				<select name="col">
					<option value="title">직업이름</option>
					<option value="empNo">직원번호</option>
				</select> <input type="text" name="searchWord">
				<button type="submit" class="btn btn-primary">검색</button>
			</form>
		</div>
		<table border=1
			class="bg-dark text-light table table-dark table-hover">
			<thead>
				<tr>
					<th>empNo</th>
					<th>title</th>
					<th>from date</th>
					<th>to date</th>
				</tr>
			</thead>
			<tbody class="bg-secondary text-light table table-dark ">
				<%
					for (Titles t : list) {
				%>
				<tr>
					<td><%=t.empNo%></td>
					<td><%=t.title%></td>
					<td><%=t.fromDate%></td>
					<td><%=t.toDate%></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
		<div class="d-flex justify-content-center">
		<!-- 1페이지로 이동 -->
		<a
			href="<%=request.getContextPath()%>/titles/titlesList.jsp?currentPage=1&searchWord=<%=searchWord%>&col=<%=col%>"
			class="btn btn-outline-primary">first</a>


		<!-- 이전 페이지(첫 페이지 일시 링크 비활성화) -->
		<%
			if (currentPage > 1) {
		%>
		<a
			href="<%=request.getContextPath()%>/titles/titlesList.jsp?currentPage=<%=currentPage - 1%>&searchWord=<%=searchWord%>&col=<%=col%>"
			class="
			btn btn-outline-primary"><</a>
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
			href="<%=request.getContextPath()%>/titles/titlesList.jsp?currentPage=<%=i%> &searchWord=<%=searchWord%>&col=<%=col%>" class="
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
			href="<%=request.getContextPath()%>/titles/titlesList.jsp?currentPage=<%=i%>&searchWord=<%=searchWord%>&col=<%=col%>" class="
			btn btn-outline-primary"><%=i%></a>
		<%
			}
				} else {
					for (int i = (groupStartPage * 10) + 1; i <= (groupStartPage * 10) + 10; i = i + 1) {
		%>
		<a
			href="<%=request.getContextPath()%>/titles/titlesList.jsp?currentPage=<%=i%>&searchWord=<%=searchWord%>&col=<%=col%>" class="
			btn btn-outline-primary"><%=i%></a>
		<%
			}
				}
			}
		%>


		<!-- 다음 페이지(마지막 페이지 일시 링크 비활성화) -->
		<%
			if (currentPage < lastPage) {
		%>
		<a
			href="<%=request.getContextPath()%>/titles/titlesList.jsp?currentPage=<%=currentPage + 1%>&searchWord=<%=searchWord%>&col=<%=col%>"
			class="
			btn btn-outline-primary">></a>
		<%
			}
		%>



		<!-- 마지막 페이지로 이동 -->
		<a
			href="<%=request.getContextPath()%>/titles/titlesList.jsp?currentPage=<%=lastPage%>&searchWord=<%=searchWord%>&col=<%=col%>"
			class="
			btn btn-outline-primary">end</a>
			</div>
			<div class="col-sm-2"></div>
			</div>
	</div>
	</div>
</body>
</html>