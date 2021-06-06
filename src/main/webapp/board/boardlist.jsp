<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/include/common.jsp" %>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="org.korgog.service.Pages"%>
<%@page import="org.korgog.dao.BoardDAO"%>
<%@page import="org.korgog.dto.BoardDTO"%>
<%
	request.setCharacterEncoding("UTF-8");

	int currentPage = 1;
	if (request.getParameter("page") != null) {
		currentPage = Integer.parseInt(request.getParameter("page"));
	}

	String getColumn = "";
	String searchColumn = "";
	String searchString = "";
	if (request.getParameter("search") != null && request.getParameter("string") != null) {
		getColumn = request.getParameter("search").trim();
		searchColumn = getColumn;
		searchString = request.getParameter("string").trim();
		switch (searchColumn) {
			case "subject":
				searchColumn = "SUBJECT";
				break;
			case "content":
				searchColumn = "CONTENT";
				break;
			case "membernid":
				searchColumn = "MEMBERID";
				break;
			case "membername":
				searchColumn = "MEMBERNAME";
				break;
		}
	}

	BoardDAO boardDAO = new BoardDAO();
	Pages pages = new Pages();
	pages = boardDAO.getPage(currentPage, searchColumn, searchString);
	Iterator<BoardDTO> iterBoardList = null;
	List<BoardDTO> boardList = boardDAO.getList(currentPage, pages.getStartRow(), pages.getEndRow(), searchColumn, searchString);

	if (boardList != null) {
		iterBoardList = boardList.iterator();
	}
%>
		<table id="listnsearch">
			<tr>
				<td id="listinfo">
					<ul>
						<li id="totalpages"><%=currentPage%> / <%=pages.getTotalPage()%>페이지</li><!--
						--><li>총 <%=pages.getTotalRow()%>건</li>
					</ul>
				</td>
				<td id="listtitle">
					토론게시판
				</td>
				<td id="listsearch">
					<div id="searcharea">
						<form onsubmit="return false;">
							<select name="name" id="searchselect">
								<option value="subject"<% if (getColumn.equalsIgnoreCase("subject")) {
										out.print(" selected");
									} %>>제목</option>
								<option value="content"<% if (getColumn.equalsIgnoreCase("content")) {
										out.print(" selected");
									}%>>내용</option>
								<option value="memberid"<% if (getColumn.equalsIgnoreCase("memberid")) {
										out.print(" selected");
									}%>>아이디</option>
								<option value="membername"<% if (getColumn.equalsIgnoreCase("membername")) {
										out.print(" selected");
									}%>>이름</option>
							</select><!--
							--><!--
							--><input type="text" name="string" id="searchinput" value="<%=searchString%>" maxlength="30" onkeyup="enterkey();" /><!--
							--><input type="button" id="searchbutton" value="검색" onclick="searchBoard();" /><!--
							--><input type="button" id="returntolist" value="처음으로" onclick="movePage(1, '', '');" /><!--
							--><input type="button" id="boardwrite" value="글쓰기" onclick="<%
									if ((String) session.getAttribute("memberID") != null) {
										out.print("boardWrite()");
									} else {
										out.print("cantWrite()");
									}
								%>;" />
						</form>
					</div>
				</td>
			</tr>
		</table>
		<table id="boardlist">
			<tr class="trline"><td colspan="5"><hr class="hrtop"/></td></tr>
			<tr>
				<th class="boardnum">글번호</th>
				<th class="subject">제목</th>
				<th class="membername">작성자</th>
				<th class="writetime">작성일시</th>
				<th class="hits">조회</th>
			</tr>
			<tr class="trline"><td colspan="5"><hr class="hrtop"/></td></tr>
					<%
						if (boardList == null || iterBoardList == null) {
							out.print("\t\t\t<tr class=\"boardrow\"><td colspan=\"6\" class=\"none\">게시물 정보가 존재하지 않습니다.</td></tr>");
						} else {
							while (iterBoardList.hasNext()) {
								BoardDTO row = iterBoardList.next();
					%>
			<tr class="boardrow" onclick="viewBoard(<%=row.getBoardNum()%>, <%=currentPage%>, '<%=getColumn%>', '<%=searchString%>');">
				<td class="boardnum"><%=row.getBoardNum()%></td>
				<td class="subject"><%=row.getSubject()%></td>
				<td class="membername"><%=row.getMemberName()%>(<%=row.getMemberID()%>)</td>
				<td class="writetime"><%=row.getWriteTime()%></td>
				<td class="hits"><%=row.getHits()%></td>
			</tr>
			<tr class="trline"><td colspan="5"><hr class="hrline"/></td></tr>
					<%
							}
							iterBoardList.remove();
							boardList.clear();
						}
					%>
		</table>
		<div id="pagewindow" class="preventdrag">
			<ul id="boardulist">
						<%
					int totalPage = pages.getTotalPage();
					out.print("<li class=\"arrow ");
					if (currentPage != 1) {
						out.print("pagelink");
					} else {
						out.print("startpage");
					}
					out.print("\"");
					if (currentPage != 1) {
						out.print(" onclick=\"movePage(1,'" + getColumn + "', '" + searchString + "');\"");
					}
					out.print(">◀◀</li>");

					out.print("<li class=\"arrow ");
					if (currentPage > pages.getPrevPage()) {
						out.print("pagelink");
					} else {
						out.print("startpage");
					}
					out.print("\"");
					if (currentPage > pages.getPrevPage()) {
						out.print(" onclick=\"movePage(" + pages.getPrevPage() + ", '" + getColumn + "', '" + searchString + "');\"");
					}
					out.print(">◀</li>");

					for (int printPage = pages.getStartPage(); printPage <= pages.getEndPage(); printPage++) {
						if (printPage <= totalPage) {
							out.print("<li class=\"");
							if (printPage != currentPage) {
								out.print("pagelink");
							} else {
								out.print("currentpage");
							}
							out.print("\"");
							if (printPage != currentPage) {
								out.print("onclick=\"movePage(" + printPage + ", '" + getColumn + "', '" + searchString + "');\"");
							}
							out.print(">" + printPage + "</li>");
						}
					}

					if (pages.getNextPage() <= totalPage) {
						out.print("<li class=\"arrow ");
						if (totalPage > 0 && totalPage != currentPage) {
							out.print("pagelink");
						} else {
							out.print("endpage");
						}
						out.print("\"");
						if (totalPage > 0 && totalPage != currentPage) {
							out.print(" onclick=\"movePage(" + pages.getNextPage() + ", '" + getColumn + "', '" + searchString + "');\"");
						}
						out.print(">▶</li>");
					} else {
						out.print("<li class=\"arrow endpage\">▶</li>");
					}

					out.print("<li class=\"arrow ");
					if (totalPage > 0 && totalPage != currentPage) {
						out.print("pagelink");
					} else {
						out.print("endpage");
					}
					out.print("\"");
					if (totalPage > 0 && totalPage != currentPage) {
						out.print(" onclick=\"movePage(" + totalPage + ", '" + getColumn + "', '" + searchString + "');\"");
					}
					out.print(">▶▶</li>");
				%>
			</ul>
		</div>