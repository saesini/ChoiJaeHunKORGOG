<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/include/common.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	String refererPage = "";
	refererPage = request.getHeader("REFERER");

	if (refererPage == null || refererPage.length() < 1) {
		refererPage = "/";
	}

	if ((String) session.getAttribute("memberID") == null) {
		response.sendRedirect(refererPage);
	}
%>
<table id="view" class="boardwritetitle">
	<tr>
		<td>글쓰기</td>
	</tr>
</table>
<div class="container">
	<form id="actionform" name="writeform" method="post" action="/board/boardwrite.jsp">
		<label for="subject">제목</label>
		<input type="text" id="subject" name="subject" placeholder="">
		<label for="content">내용</label>
		<textarea id="content" name="content"></textarea>
		<div id="btnarea">
			<input id="btnaction" type="button" value="글쓰기">
			<input id="btnreturn" type="button" value="돌아가기">
		</div>
	</form>
</div>