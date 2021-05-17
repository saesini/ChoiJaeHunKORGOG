<%@page language="java" contentType="text/html;charesultsetet=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/include/common.jsp" %>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="org.korgog.service.Pages"%>
<%@page import="org.korgog.dao.OfficeDAO"%>
<%@page import="org.korgog.dto.OfficeDTO"%>
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
			case "name":
				searchColumn = "SNAME";
				break;
			case "add":
				searchColumn = "ADDRESS";
				break;
		}
	}

	OfficeDAO officeDAO = new OfficeDAO();
	Pages pages = new Pages();
	pages = officeDAO.getPage(currentPage, searchColumn, searchString);
	Iterator<OfficeDTO> iterOfficeList = null;
	List<OfficeDTO> officeList = officeDAO.getList(currentPage, pages.getStartRow(), pages.getEndRow(), searchColumn, searchString);

	if (officeList != null) {
		iterOfficeList = officeList.iterator();
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
					관공서정보 목록
				</td>
				<td id="listsearch">
					<div id="searcharea">
						<form onsubmit="return false;">
							<select name="name" id="searchselect">
								<option value="name"<% if (getColumn.equalsIgnoreCase("namd")) {
										out.print(" selected");
									} %>>관공서명</option>
								<option value="add"<% if (getColumn.equalsIgnoreCase("add")) {
										out.print(" selected");
									}%>>주소정보</option>
							</select><!--
							--><input type="text" name="string" id="searchinput" value="<%=searchString%>" maxlength="30" onkeyup="enterkey();" /><!--
							--><input type="button" id="searchbutton" value="검색" onclick="searchOffice();" /><!--
							--><input type="button" id="returntolist" value="처음으로" onclick="movePage(1, '', '');" />
						</form>
					</div>
				</td>
			</tr>
		</table>
		<table id="officelist">
			<tr class="trline"><td colspan="5"><hr class="hrtop"/></td></tr>
			<tr>
				<th class="part">행정구분</th>
				<th class="sname">관공서명</th>
				<th class="fname">정식명칭</th>
				<th class="countscore">평가횟수</th>
				<th class="grade">평균점수</th>
			</tr>
			<tr class="trline"><td colspan="5"><hr class="hrtop"/></td></tr>
			<%
				if (officeList == null || iterOfficeList == null) {
					out.print("\t\t\t<tr class=\"officerow\"><td colspan=\"6\">관공서 정보가 존재하지 않습니다.</td></tr>");
				} else {
					while (iterOfficeList.hasNext()) {
						OfficeDTO row = iterOfficeList.next();
			%>
			<tr class="officerow" onclick="viewOffice(<%=row.getOfficeNum()%>, <%=currentPage%>, '<%=getColumn%>', '<%=searchString%>');">
				<td class="part"><%=row.getPart()%></td>
				<td class="sname"><%=row.getSname()%></td>
				<td class="fname"><%=row.getFname()%></td>
				<td class="countscore"><%=row.getScoreCount()%></td>
				<td class="grade"><%
						int score = row.getScoreAverage() / 10;
						if (score > 0) {
							for (int i = 0; i < score; i++) {
								out.print("<img class=\"scoredstargrade\" src=\"/img/star_");
								if (i % 2 == 0) {
									out.print("left.png\" alt=\"\"/>");
								} else {
									out.print("right.png\" alt=\"\"/>");
								}
							}
	
							if (score < 10) {
								for (int i = score; i < 10; i++) {
									out.print("<img class=\"scoredstargrade\" src=\"/img/stargray_");
									if (i % 2 == 0) {
										out.print("left.png\" alt=\"\"/>");
									} else {
										out.print("right.png\" alt=\"\"/>");
									}
								}
							}
						}
					%></td>
			</tr>
			<tr class="trline"><td colspan="5"><hr class="hrline"/></td></tr>
			<%
					}
					iterOfficeList.remove();
					officeList.clear();
				}
			%>
		</table>
		<div id="pagewindow" class="preventdrag">
			<ul id="officeulist">
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
						out.print(" onclick=\"movePage(1,'" + getColumn + "','" + searchString + "');\"");
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
						out.print(" onclick=\"movePage(" + pages.getPrevPage() + ",'" + getColumn + "','" + searchString + "');\"");
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
								out.print("onclick=\"movePage(" + printPage + ",'" + getColumn + "','" + searchString + "');\"");
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
							out.print(" onclick=\"movePage(" + pages.getNextPage() + ",'" + getColumn + "','" + searchString + "');\"");
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
						out.print(" onclick=\"movePage(" + totalPage + ",'" + getColumn + "','" + searchString + "');\"");
					}
					out.print(">▶▶</li>");
				%>
			</ul>
		</div>