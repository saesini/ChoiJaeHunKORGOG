<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/include/common.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");

	String referer = "";
	if (request.getHeader("REFERER") != null) {
		referer = request.getHeader("REFERER").toLowerCase();
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<% pageContext.include("/include/meta.jsp");%>
		<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.js"></script>
		<script type="text/javascript" src="/script/memberloginform.js"></script>
		<link rel="stylesheet" type="text/css" href="/style/common.css">
		<link rel="stylesheet" type="text/css" href="/style/memberloginform.css">
		<title>회원 로그인 - GOG</title>
	</head>
	<body>
		<%@ include file = "/header.jsp"%>
		<div id="titlediv">회원 로그인</div>
		<form id="loginform" name="loginform" method="post" action="/member/memberlogin.jsp">
			<input type="hidden" id="inflowpage" name="inflowpage" value="<%=referer%>"/>
			<div class="imgcontainer">
				<img src="/img/taegeuk.svg" class="taegeuk" alt="Taegeuk"/>
			</div>
			<div class="container">
				<label for="memberid" class="loginlabel">회원 아이디</label>
				<input type="text" id="memberid" name="memberid" placeholder="회원 아이디를 입력해 주십시오." required/>
				<label for="password" class="loginlabel">비밀번호</label>
				<input type="password" id="password" name="password" placeholder="비밀번호를 입력해 주십시오." required/>
			</div>
			<div class="container">
				<input type="button" id="btnlogin" class="btnleft" value="로그인"/><!--
				--><input type="button" id="return" value="돌아가기"/>
			</div>
		</form>
		<%@ include file = "/footer.jsp"%>
	</body>
</html>