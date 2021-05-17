<%@page language="java" contentType="text/html;charesultsetet=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/include/common.jsp" %>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="org.korgog.service.Pages"%>
<%@page import="org.korgog.dao.AccessLogDAO"%>
<%@page import="org.korgog.dto.AccessLogDTO"%>
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
			case "membernid":
				searchColumn = "B.MEMBERID";
				break;
			case "membername":
				searchColumn = "B.MEMBERNAME";
				break;
		}
	}
	
	out.println(searchColumn);
	out.println(searchString);

	AccessLogDAO accessLogDAO = new AccessLogDAO();
	Pages pages = new Pages();
	pages = accessLogDAO.getPage(currentPage, searchColumn, searchString);
	Iterator<AccessLogDTO> iterAccessLogList = null;
	List<AccessLogDTO> accessLogList = accessLogDAO.getList(currentPage, pages.getStartRow(), pages.getEndRow(), searchColumn, searchString);

	if (accessLogList != null) {
		iterAccessLogList = accessLogList.iterator();
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
				<td id="listtitle">회원로그</td>
				<td id="listsearch">
					<div id="searcharea">
						<form onsubmit="return false;">
							<select name="name" id="searchselect">
								<option value="memberid"<% if (getColumn.equalsIgnoreCase("memberid")) {
										out.print(" selected");
									}%>>아이디</option>
								<option value="membername"<% if (getColumn.equalsIgnoreCase("membername")) {
										out.print(" selected");
									}%>>이름</option>
							</select><!--
							--><!--
							--><input type="text" name="string" id="searchinput" value="<%=searchString%>" maxlength="30" onkeyup="enterkey();" /><!--
							--><input type="button" id="searchbutton" value="검색" onclick="searchAccessLog();" /><!--
							--><input type="button" id="returntolist" value="처음으로" onclick="movePage(1, '', '');" />
						</form>
					</div>
				</td>
			</tr>
		</table>
		<table id="accessloglist">
			<tr class="trline"><td colspan="6"><hr class="hrtop"/></td></tr>
			<tr>
				<th class="accesslognum">로그번호</th>
				<th class="membername">기록인</th>
				<th class="ipaddress">IP주소</th>
				<th class="worktable">테이블</th>
				<th class="worknum">기록번호</th>
				<th class="writetime">기록일시</th>
			</tr>
			<tr class="trline"><td colspan="6"><hr class="hrtop"/></td></tr>
					<%
						if (accessLogList == null || iterAccessLogList == null) {
							out.print("\t\t\t<tr class=\"accesslogrow\"><td colspan=\"6\" class=\"none\">게시물 정보가 존재하지 않습니다.</td></tr>");
						} else {
							while (iterAccessLogList.hasNext()) {
								AccessLogDTO row = iterAccessLogList.next();
					%>
			<tr class="accesslogrow" onclick="viewAccessLog(<%=row.getAccessLogNum()%>, <%=currentPage%>, '<%=getColumn%>', '<%=searchString%>');">
				<td class="accesslognum"><%=row.getAccessLogNum()%></td>
				<td class="membername"><%=row.getMemberName()%>(<%=row.getMemberID()%>)</td>
				<td class="ipaddress"><%=row.getIpAddress()%></td>
				<td class="worktable"><%=row.getWorkTable()%></td>
				<td class="worknum"><%=row.getWorkNum()%></td>
				<td class="writetime"><%=row.getAccessTime()%></td>
			</tr>
			<tr class="trline"><td colspan="6"><hr class="hrline"/></td></tr>
					<%
							}
							iterAccessLogList.remove();
							accessLogList.clear();
						}
					%>
		</table>
		<div id="pagewindow" class="preventdrag">
			<ul id="accesslogulist">
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