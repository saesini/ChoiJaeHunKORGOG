<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
<%
	pageContext.include("/include/meta.jsp");
%>
		<link rel="stylesheet" type="text/css" href="/css/common.css">
		<link rel="stylesheet" type="text/css" href="/css/intro.css">
		<title>서비스 소개 - GOG</title>
	</head>
	<body>
		<%@ include file = "/header.jsp"%>
		<p class="message">서비스 소개</p>
		<table id="intro">
			<tr>
				<th>관공서정보</th>
				<td>
					&nbsp;&nbsp;대한민국 행정부 산하 13,459개 관공서 개별 전화번호, 주소 및 관할 정보를 열람할 수 있으며 지도의 출력도 함께 제공하고 있습니다.
					회원 가입 및 로그인 후 관공서에 대한 평가점수와 평가멘트를 기록할 수 있습니다.
				</td>
			</tr>
			<tr>
				<th>평가리스트</th>
				<td>
					&nbsp;&nbsp;회원들이 관공서에 대하여 평가한 명세가 최신 갱신 순으로 목록화 제공되어 지역 및 시간에 따른 관공서 평판을 가늠할 수 있는 자료입니다.
				</td>
			</tr>
			<tr>
				<th>토론게시판</th>
				<td>
					&nbsp;&nbsp;회원들 간의 소통을 위한 공간으로써 회원가입 및 로그인을 한 경우에는 누구나 자유롭게 의견을 표현할 수 있습니다.
					서로 배려하는 아름다운 토론문화를 만들어 주시기를 부탁드립니다.
				</td>
			</tr>
		</table>
		<%@ include file = "/footer.jsp"%>
	</body>
</html>