<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/include/common.jsp" %>
<%@page import="org.korgog.dao.BoardDAO"%>
<%@page import="org.korgog.dto.BoardDTO"%>
<%
	request.setCharacterEncoding("UTF-8");

	String getColumn = "";
	String searchString = "";
	if (request.getParameter("search") != null && request.getParameter("string") != null) {
		getColumn = request.getParameter("search").trim();
		searchString = request.getParameter("string").trim();
	}

	int currentPage = 1;
	String currentPageString = "";
	if (request.getParameter("page") != null) {
		currentPageString = request.getParameter("page");
		currentPage = Integer.parseInt(currentPageString);
	}

	int currentNum = 1;
	if (request.getParameter("num") != null) {
		String currentNumString = request.getParameter("num");
		currentNum = Integer.parseInt(currentNumString);
	}
	
	BoardDAO boardDAO = new BoardDAO();
	BoardDTO boardDTO = new BoardDTO();
	boardDTO = boardDAO.getView(currentNum);
	boardDAO.hit(currentNum);
%>
		<script>document.title = "<%=boardDTO.getSubject()%> - GOG";</script>
		<table id="view" class="boardviewtitle">
			<%
				if(boardDTO.getBoardNum() < 1) {
					out.print("<tr><td>존재하지 않는 게시물입니다.</th></tr></table>");
				} else {
			%>
			<tr>
				<td><%=boardDTO.getSubject()%></td>
			</tr>
		</table>
		<table id="boardview">
			<tr>
				<th class="boardtitle">작성자</th>
				<td class="boardmembername"><%=boardDTO.getMemberName()%>(<%=boardDTO.getMemberID()%>)</td>
			<th class="boardtitle">조회수</th>
				<td class="boardhits"><%=boardDTO.getHits()%></td>
				<th class="boardtitle">작성일시</th>
				<td class="boardtime"><%=boardDTO.getWriteTime()%></td>
				<th class="boardtitle">수정일시</th>
				<td class="boardtime"><%=boardDTO.getEditTime()%></td>
			</tr>
			<tr>
				<th class="titleth">글내용</th>
				<td colspan="7"><%=boardDTO.getContent()%></td>
			</tr>
			<tr>
				<td colspan="8" class="btntd">
					<input type="button" id="btnedit" class="btnboard" value="수정" onclick="<%
						if((boardDTO.getMemberID()).equals((String) session.getAttribute("memberID"))) {
							out.print("boardEdit(" + boardDTO.getBoardNum() + ", " + currentPage + ", '" + getColumn + "', '" + searchString + "')");
						} else {
							out.print("cantEdit()");
						}
					%>;"/><!--
					--><input type="button" id="btndelete" class="btnboard" value="삭제" onclick="<%
						if((boardDTO.getMemberID()).equals((String) session.getAttribute("memberID"))) {
							out.print("boardDelete(" + boardDTO.getBoardNum() + ", " + currentPage + ", '" + getColumn + "', '" + searchString + "')");
						} else {
							out.print("cantDelete()");
						}
					%>;"/><!--
					--><input type="button" id="btnlist" class="btnboard" value="목록" onclick="movePage(<%=currentPage%>, '<%=getColumn%>', '<%=searchString%>');"/>
				</td>
			</tr>
			<%
				}
			%>
		</table>