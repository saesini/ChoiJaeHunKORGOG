<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/include/common.jsp" %>
<%@page import="org.korgog.dao.AccessLogDAO"%>
<%@page import="org.korgog.dto.AccessLogDTO"%>
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
	
	AccessLogDAO accessLogDAO = new AccessLogDAO();
	AccessLogDTO accessLogDTO = new AccessLogDTO();
	accessLogDTO = accessLogDAO.getView(currentNum);
%>
		<script>document.title = "회원로그 <%=accessLogDTO.getAccessLogNum()%> - GOG";</script>
		<table id="view" class="accesslogviewtitle">
			<%
				if(accessLogDTO.getAccessLogNum() < 1) {
					out.print("<tr><td>존재하지 않는 기록입니다.</th></tr></table>");
				} else {
			%>
			<tr>
				<td>회원로그 <%=accessLogDTO.getAccessLogNum()%></td>
			</tr>
		</table>
		<table id="accesslogview">
			<tr>
				<th class="accesslogtitle">기록인</th>
				<td class="accesslogmembername"><%=accessLogDTO.getMemberName()%>(<%=accessLogDTO.getMemberID()%>)</td>
				<th class="accesslogtitle">IP주소</th>
				<td class="accesslogip"><%=accessLogDTO.getIpAddress()%></td>
				<th class="accesslogtitle">테이블(번호)</th>
				<td class="accesslogtable"><%=accessLogDTO.getWorkTable()%>(<%=accessLogDTO.getWorkNum()%>)</td>
				<th class="accesslogtitle">기록일시</th>
				<td class="accesslogtime"><%=accessLogDTO.getAccessTime()%></td>
			</tr>
			<tr>
				<th>기록내용</th>
				<td colspan="7"><%=accessLogDTO.getDetail()%></td>
			</tr>
			<tr>
				<td colspan="8" class="btntd"><input type="button" id="btnlist" class="btnaccesslog" value="목록" onclick="movePage(<%=currentPage%>, '<%=getColumn%>', '<%=searchString%>');"/>
				</td>
			</tr>
			<%
				}
			%>
		</table>