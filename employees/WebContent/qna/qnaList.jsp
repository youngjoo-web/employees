<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="gd.emp.QnA"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA List</title>
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
			//searchWord 설정
			String searchWord = "";
			String col = "";
			if (request.getParameter("searchWord") != null) {
				searchWord = request.getParameter("searchWord");

				col = request.getParameter("col");

			}
			System.out.println("검색어..." + searchWord);
			System.out.println("키워드..." + col);
			int currentPage = 1;

			if (request.getParameter("currentPage") != null) {
				currentPage = Integer.parseInt(request.getParameter("currentPage"));

			}
			System.out.println("현재 페이지..." + currentPage);
			int rowPerPage = 3;
			int beginRow = (currentPage - 1) * rowPerPage;

			Class.forName("org.mariadb.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/employees", "root",
					"java1234");

			PreparedStatement stmt1 = null;
			if (searchWord.equals("")) {
				stmt1 = conn.prepareStatement("select * from qna order by qna_no desc limit ?,?");
				stmt1.setInt(1, beginRow);
				stmt1.setInt(2, rowPerPage);
				System.out.println("검색값없음..." + stmt1);
			} else {
				/*
					쿼리문
					1.  select qna_no, qna_title, qna_user, qna_date 
						form qna 
						where qna_title like ?
						order by qna_no desc 
						limit ?,?
				*/
				if (col.equals("qna_title")) {
					stmt1 = conn.prepareStatement(
							"select * from qna where qna_title like ? order by qna_no desc limit ?,?");

					stmt1.setString(1, "%" + searchWord + "%");
					stmt1.setInt(2, beginRow);
					stmt1.setInt(3, rowPerPage);
					System.out.println("검색값있음..." + stmt1);
				} else {
					stmt1 = conn.prepareStatement(
							"select * from qna where qna_content like ? order by qna_no desc limit ?,?");

					stmt1.setString(1, "%" + searchWord + "%");
					stmt1.setInt(2, beginRow);
					stmt1.setInt(3, rowPerPage);
					System.out.println("검색값있음..." + stmt1);
				}
			}

			ArrayList<QnA> list = new ArrayList<QnA>();
			ResultSet rs1 = stmt1.executeQuery();
			while (rs1.next()) {

				QnA q = new QnA();
				q.qnaNo = rs1.getInt("qna_no");
				q.qnaTitle = rs1.getString("qna_title");
				q.qnaContent = rs1.getString("qna_content");
				q.qnaUser = rs1.getString("qna_user");
				q.qnaPw = rs1.getString("qna_pw");
				q.qnaDate = rs1.getString("qna_date");
				q.qnaIp = rs1.getString("qna_ip");
				list.add(q);
			}
			System.out.println("한 화면에 데이터크기..." + list.size());
			int firstPage = 1;
			int totalRow = 0;
			PreparedStatement stmt2 = null;
			ResultSet rs2 = null;
			if (searchWord.equals("")) {
				stmt2 = conn.prepareStatement("select count(*) from qna");
				System.out.println("검색값없음..." + stmt2);
			} else {
				if (col.equals("qna_title")) {
					stmt2 = conn.prepareStatement("select count(*) from qna where qna_title like ?");
					stmt2.setString(1, "%" + searchWord + "%");
					System.out.println("검색값있음..." + stmt2);
				} else {
					stmt2 = conn.prepareStatement("select count(*) from qna where qna_content like ?");
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
			System.out.println("마지막 페이지 쪽수 ... " + lastPage);//마지막페이지 디버깅
		%>
		<div>
			<jsp:include page="/inc/mainmenu.jsp"></jsp:include>
		</div>
		<div class="row">
			<div class="col-sm-2"></div>
			<div class="col-sm-8">
				<h1>QnA List</h1>
				<div class="row">
					<div class="col-sm-10">

						<form method="post"
							action="<%=request.getContextPath()%>/qna/qnaList.jsp">
							<select name="col">
								<option value="qna_title">제목</option>
								<option value="qna_content">내용</option>
							</select> <input type="text" name="searchWord">
							<button type="submit" class="btn btn-primary">검색</button>
						</form>
					</div>
					<div class="col-sm-2">
						<a href="<%=request.getContextPath()%>/qna/insertQnaForm.jsp"
							class="btn btn-secondary d-flex justify-content-center">질문등록</a>
					</div>
				</div>
				<table border=1
					class="bg-dark text-light table table-dark table-hover">
					<thead>
						<tr>
							<th>No</th>
							<th>Title</th>
							<th>user</th>
						</tr>
					</thead>
					<tbody>
						<%
							for (QnA q : list) {
								String qnaDateSub = q.qnaDate.substring(0, 10);
								System.out.println(q.qnaDate.substring(0, 10) + " <- qnaDate");

								Calendar today = Calendar.getInstance();
								int year = today.get(Calendar.YEAR);
								int month = today.get(Calendar.MONTH) + 1;
								String month2 = "" + month;
								if (month < 10) {
									month2 = "0" + month;
								}
								int day = today.get(Calendar.DATE);
								String day2 = "" + day;
								if (day < 10) {
									day2 = "0" + day;
								}

								String strToday = year + "-" + month2 + "-" + day;
						%>
						<tr>
							<td><%=q.qnaNo%></td>
							<td><a
								href="<%=request.getContextPath()%>/qna/selectQna.jsp?no=<%=q.qnaNo%> "><%=q.qnaTitle%></a>
								<%
									if (strToday.equals(qnaDateSub)) {
								%> <span class="badge badge-warning">new</span> <%
 	}
 %></td>
							<td><%=q.qnaUser%></td>


						</tr>
						<%
							}
						%>
					</tbody>
				</table>
				<div class="d-flex justify-content-center">
				<!-- 1페이지로 이동 -->
				<a
					href="<%=request.getContextPath()%>/qna/qnaList.jsp?currentPage=<%=1%>&searchWord=<%=searchWord%>&col=<%=col%>"
					class="
			btn btn-outline-primary">첫번째</a>


				<!-- 이전 페이지(첫 페이지 일시 링크 비활성화) -->
				<%
					if (currentPage > 1) {
				%>
				<a
					href="<%=request.getContextPath()%>/qna/qnaList.jsp?currentPage=<%=currentPage - 1%>&searchWord=<%=searchWord%>&col=<%=col%>"
					class="
			btn btn-outline-primary">이전페이지</a>
				<%
					} else {
				%>
				<a
					href="<%=request.getContextPath()%>/qna/qnaList.jsp?currentPage=<%=currentPage - 1%>&searchWord=<%=searchWord%>&col=<%=col%>"
					class="
			btn btn-outline-primary" onclick="return false">이전페이지</a>
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
					href="<%=request.getContextPath()%>/qna/qnaList.jsp?currentPage=<%=i%>&searchWord=<%=searchWord%>&col=<%=col%>" class="
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
					href="<%=request.getContextPath()%>/qna/qnaList.jsp?currentPage=<%=i%>&searchWord=<%=searchWord%>&col=<%=col%>" class="
			btn btn-outline-primary"><%=i%></a>
				<%
					}
						} else {
							for (int i = (groupStartPage * 10) + 1; i <= (groupStartPage * 10) + 10; i = i + 1) {
				%>
				<a
					href="<%=request.getContextPath()%>/qna/qnaList.jsp?currentPage=<%=i%>&searchWord=<%=searchWord%>&col=<%=col%>" class="
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
					href="<%=request.getContextPath()%>/qna/qnaList.jsp?currentPage=<%=currentPage + 1%>&searchWord=<%=searchWord%>&col=<%=col%>"
					class="
			btn btn-outline-primary">다음페이지</a>
				<%
					} else {
				%>
				<a
					href="<%=request.getContextPath()%>/qna/qnaList.jsp?currentPage=<%=currentPage + 1%>&searchWord=<%=searchWord%>&col=<%=col%>"
					onclick="return false" class="
			btn btn-outline-primary">다음페이지</a>
				<!-- 다음 페이지(마지막 페이지 일시 링크 비활성화) -->
				<%
					}
				%>


				<!-- 마지막 페이지로 이동 -->
				<a
					href="<%=request.getContextPath()%>/qna/qnaList.jsp?currentPage=<%=lastPage%>&searchWord=<%=searchWord%>&col=<%=col%>"
					class="
			btn btn-outline-primary">마지막</a> <br>
			</div>
			<div class="col-sm-2"></div>
		</div>
	</div>
	</div>
</body>
</html>