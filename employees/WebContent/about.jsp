<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>about</title>
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
	
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">

</head>
<body>
	<div class="container-fluid">
		<div>
			<jsp:include page="/inc/mainmenu.jsp"></jsp:include>
		</div>
		<h1>이력서</h1>
		<!-- 기본정보 -->
		<table class="table table-bordered">
			<tbody>
				<tr>
					<td rowspan="3"><img src="/employees/img/bepo.jpg"></td>
					<td rowspan="2" class="bg-secondary text-light">성명</td>
					<td>(한글) 백영주</td>
					<td class="bg-secondary text-light">생년월일</td>
					<td> 1996. 07. 15</td>
				</tr>
				<tr>
					<!-- <td>사진</td> -->
					<!-- <td>성명</td> -->
					<td>(영문) baek young joo</td>
					<td class="bg-secondary text-light">휴대폰</td>
					<td>010 - 9449 - 4370</td>
				</tr>
				<tr>
					<!-- <td>사진</td> -->
					<td class="bg-secondary text-light">주소</td>
					<td> 경기도 파주시 금촌동 황골로 12 201동 1111호</td>
					<td class="bg-secondary text-light">이메일</td>
					<td> youngjoo715@gmail.com</td>
				</tr>
			</tbody>
		</table>
		<!-- 학력사항 -->
		<table class="table table-bordered">
			<tbody>
				<tr>
					<td rowspan="3" class="bg-dark text-light">학<br>력<br>사<br>항</td>
					<td class="bg-secondary text-light"> 졸업일 </td>
					<td class="bg-secondary text-light"> 학교명 </td>
					<td class="bg-secondary text-light"> 전공 </td>
					<td class="bg-secondary text-light"> 졸업여부 </td>
					<td class="bg-secondary text-light"> 소재지</td>
					<td class="bg-secondary text-light"> 성적 </td>
				</tr>
				<tr>
					<!-- <td>학력사항</td> -->
					<td>2020년 2월 15일</td>
					<td>두원공과대학교</td>
					<td>스마트 IT과</td>
					<td>졸업</td>
					<td>파주</td>
					<td>B+</td>
				</tr>
				<tr>
					<!-- <td>학력사항</td> -->
					<td>2015년 2월 20일</td>
					<td>금촌고등학교</td>
					<td>인문계</td>
					<td>졸업</td>
					<td>파주</td>
					<td>B+</td>
				</tr>
			</tbody>
		</table>
		<!-- 경력사항 -->
		<table class="table table-bordered">
			<tbody>
				<tr>
					<td rowspan="2" class="bg-dark text-light">경<br>력<br>사<br>항</td>
					<td class="bg-secondary text-light"> 근무기간 </td>
					<td class="bg-secondary text-light"> 회사명 </td>
					<td class="bg-secondary text-light"> 직위 </td>
					<td class="bg-secondary text-light"> 담당업무 </td>
					<td class="bg-secondary text-light"> 퇴사사유</td>
				</tr>
				<tr>
					<!-- <td>경력사항</td> -->
					<td>2020년 2월 3일 ~ 2020년 8월 3일</td>
					<td>구디 아카데미</td>
					<td>수강생</td>
					<td>수강</td>
					<td>수료</td>
					
				</tr>
				
			</tbody>
		</table>
		<!-- 기타사항 -->
		<table class="table table-bordered">
			<tbody>
				<tr>
					<td rowspan="6" class="bg-dark text-light">기<br>타<br>사<br>항<br></td>
					<td class="bg-secondary text-light"> 신장</td>
					<td> 182 cm </td>
					<td class="bg-secondary text-light"> 체중 </td>
					<td> 92 kg </td>
					<td class="bg-secondary text-light"> 시력</td>
					<td> 0.3/0.3 </td>
				</tr>
				<tr>
					<!-- <td>기타사항</td> -->
					<td class="bg-secondary text-light">취미</td>
					<td>스노우보딩</td>
					<td class="bg-secondary text-light">특기</td>
					<td>헬스트레이닝</td>
					<td class="bg-secondary text-light">종교</td>
					<td>해당없음</td>
					
				</tr>
				<tr>
					<!-- <td>기타사항</td> -->
					<td rowspan="6" class="bg-dark text-light">전산능력</td>
					<td class="bg-secondary text-light"> 프로그램명 </td>
					<td class="bg-secondary text-light"> 활용도 </td>
					<td colspan="3" class="bg-secondary text-light"> 자격증 보유현황</td>
					<!-- <td> 자격증 보유현황</td> -->
					<!-- <td> 자격증 보유현황</td> -->
					
				</tr>
				<tr>
					<!-- <td>기타사항</td> -->
					<!-- <td>전산능력</td> -->
					<td>자바</td>
					<td>하</td>
					<td colspan="3">해당없음</td>
					<!-- <td> 자격증 보유현황</td> -->
					<!-- <td> 자격증 보유현황</td> -->
					
				</tr>
				<tr>
					<!-- <td>기타사항</td> -->
					<!-- <td>전산능력</td> -->
					<td>정보처리</td>
					<td>중</td>
					<td colspan="3">정보처리산업기사</td>
					<!-- <td> 자격증 보유현황</td> -->
					<!-- <td> 자격증 보유현황</td> -->
					
				</tr>
				<tr>
					<!-- <td>기타사항</td> -->
					<!-- <td>전산능력</td> -->
					<td></td>
					<td></td>
					<td colspan="3"></td>
					<!-- <td> 자격증 보유현황</td> -->
					<!-- <td> 자격증 보유현황</td> -->
					
				</tr>
			</tbody>
		</table>
	</div>
</body>
</html>