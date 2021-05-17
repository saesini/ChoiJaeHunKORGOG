<%@page language="java" contentType="text/html;charesultsetet=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/include/common.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<% pageContext.include("/include/meta.jsp");%>
		<link rel="stylesheet" type="text/css" href="/css/common.css">
		<link rel="stylesheet" type="text/css" href="/css/front.css">
		<title>관공서 정보 안내 시스템 - GOG</title>
	</head>
	<body>
		<%@ include file = "/header.jsp"%>
		<video autoplay muted loop id="myVideo"><source src="/video/korea.mp4" type="video/mp4"></video>
		<div id="welcome">
			&nbsp;&nbsp;관공서 정보 안내 서비스 GOG에 접속하신 것을 환영합니다.
			GOG는 대한민국 행정부 산하 모든 관공서의 연락처와 위치 정보를 제공하는 서비스입니다.
			GOG는 관공서 정보 및 평가기능, 토론게시판을 제공하고 있으며 더 다양한 기능을 안정적인 환경에서 제공할 수 있도록 노력하고 있습니다.
		</div>
		<%@ include file = "/footer.jsp"%>
	</body>
</html>