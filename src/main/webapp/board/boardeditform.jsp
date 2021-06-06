<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/include/common.jsp" %>
<%@page import="org.korgog.dao.BoardDAO"%>
<%@page import="org.korgog.dto.BoardDTO"%>
<%
	request.setCharacterEncoding("UTF-8");

	request.setCharacterEncoding("UTF-8");

	String refererPage = "";
	refererPage = request.getHeader("REFERER");

	if (refererPage == null || refererPage.length() < 1) {
		refererPage = "/";
	}

	if ((String) session.getAttribute("memberID") == null) {
		response.sendRedirect(refererPage);
	}

	int boardNum = 1;
	if (request.getParameter("boardnum") != null) {
		String currentNumString = request.getParameter("boardnum");
		boardNum = Integer.parseInt(currentNumString);
	}

	BoardDAO boardDAO = new BoardDAO();
	BoardDTO boardDTO = new BoardDTO();
	boardDTO = boardDAO.getView(boardNum);
	boardDTO.setContent(boardDTO.getContent().replaceAll("<br/>", "\r\n"));
	
	if((Integer) session.getAttribute("memberNum") != boardDTO.getMemberNum()) {
		response.sendRedirect(refererPage);
	}
%>
<script>document.title = "[수정] <%=boardDTO.getSubject()%> - GOG";</script>
<table id="view" class="boardwritetitle">
	<%
		if (boardDTO.getBoardNum() < 1) {
			out.print("<tr><td>존재하지 않는 게시물입니다.</th></tr></table>");
		} else {
	%>
	<tr>
		<td>[수정] <% out.print(boardDTO.getSubject()); } %></td>
	</tr>
</table>
<div class="container">
	<form id="actionform" name="writeform" method="post" action="/board/boardedit.jsp">
		<input type="hidden" id="boardnum" name="boardnum" value="<%=boardNum%>"/> 
		<label for="subject">제목</label>
		<input type="text" id="subject" name="subject" value="<%=boardDTO.getSubject()%>" placeholder="">
		<label for="content">내용</label>
		<textarea id="content" name="content"><%=boardDTO.getContent()%></textarea>
		<div id="btnarea">
			<input id="btnaction" type="button" value="수정하기">
			<input id="btnreturn" type="button" value="돌아가기">
		</div>
	</form>
</div>