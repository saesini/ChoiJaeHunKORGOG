<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/include/common.jsp" %>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="org.korgog.config.Environment"%>
<%@page import="org.korgog.service.Pages"%>
<%@page import="org.korgog.dao.OfficeDAO"%>
<%@page import="org.korgog.dto.OfficeDTO"%>
<%@page import="org.korgog.dao.ScoreDAO"%>
<%@page import="org.korgog.dto.ScoreDTO"%>
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

	OfficeDAO officeDAO = new OfficeDAO();
	OfficeDTO officeDTO = new OfficeDTO();
	officeDTO = officeDAO.getView(currentNum);

	ScoreDAO scoreDAO = new ScoreDAO();
	Pages pages = new Pages();
	pages = scoreDAO.getPage(currentNum, 1, "", "");
	Iterator<ScoreDTO> iterScoreList = null;
	int startRowAtScore = pages.getStartRow();
	int endRowAtScore = startRowAtScore - Environment.getSCORE_OFFICE_ROWS() + 1;
	List<ScoreDTO> scoreList = scoreDAO.getList(currentNum, 1, startRowAtScore, endRowAtScore, "", "");
	if (scoreList != null) {
		iterScoreList = scoreList.iterator();
	}

	String memberID;
	memberID = (String) session.getAttribute("memberID");
	String scoring = printScoring(memberID);
%>
<%!
	public String printScoring(String MemberID) {
		if (MemberID != null && MemberID.length() > 3) {
			return " scoring";
		} else {
			return "";
		}
	}
%>
<script>
	document.title = "<%=officeDTO.getSname()%> ???????????? - GOG";
	var officeAddress = "<%=officeDTO.getAddress()%>";
	var officeName = '<div class="officenamemarker preventdrag"><%=officeDTO.getSname()%></div>';
</script>
<table id="listnsearch" class="officeviewtitle">
	<tr>
		<td id="listtitle">
			<%=officeDTO.getSname()%> ????????????
		</td>
	</tr>
</table>
<table  id="officeview">
	<tr>
		<th class="titleth">????????????</th>
		<td class="infotd"><%=officeDTO.getPart()%></td>
		<th class="titleth">????????????</th>
		<td class="infotd"><%=officeDTO.getParent()%></td>
	</tr>
	<tr>
		<th class="titleth">????????????</th>
		<td class="infotd"><%=officeDTO.getCat()%></td>
		<th class="titleth">????????????</th>
		<td class="infotd"><%=officeDTO.getSname()%></td>
	</tr>
	<tr>
		<th class="titleth">????????????</th>
		<td class="infotd"><%=officeDTO.getFname()%></td>
		<th class="titleth">????????????</th>
		<td class="infotd"><%=officeDTO.getTell()%></td>
	</tr>
	<tr>
		<th>????????????</th>
		<td><%=officeDTO.getScoreCount()%></td>
		<th>????????????</th>
		<td><%
				int average = officeDTO.getScoreAverage() / 10;
				if (average > 0) {
					for (int i = 0; i < average; i++) {
						out.print("<img class=\"scoredstargrade\" src=\"/img/star_");
						if (i % 2 == 0) {
							out.print("left.png\" alt=\"\"/>");
						} else {
							out.print("right.png\" alt=\"\"/>");
						}
					}

					if (average < 10) {
						for (int i = average; i < 10; i++) {
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
	<tr>
		<th>????????????</th>
		<td colspan="3"><%=officeDTO.getAddress()%> (???<%=officeDTO.getZipcode()%>)</td>
	</tr>
	<tr>
		<th colspan="4">????????????</th>
	</tr>
	<tr class="mapcell">
		<td  class="mapcell" colspan="4">
			<div id="officemap"></div>
			<script type="text/javascript" src="/script/officemap.js"></script>
		</td>
	</tr>
	<tr class="backtolist" onclick="movePage(<%=currentPage%>, '<%=getColumn%>', '<%=searchString%>');">
		<td colspan="4">???????????? ????????????</td>
	</tr>
	<tr>
		<th>????????????</th>
		<td id="scoretd" class="preventdrag" colspan="3">
			<form id="scoreform" name="scoreform" method="post" action="/score/scoreoffice.jsp"><!--
				--><input type="hidden" name="officenum" value="<%=currentNum%>"/><!--
				--><img id="star10" class="star<%=scoring%>" src="/img/stargray_left.png" alt="10???"/><img id="star20" class="star star_right<%=scoring%>" src="/img/stargray_right.png" alt="20???"/><!--
				--><img id="star30" class="star<%=scoring%>" src="/img/stargray_left.png" alt="30???"/><img id="star40" class="star star_right<%=scoring%>" src="/img/stargray_right.png" alt="40???"/><!--
				--><img id="star50" class="star<%=scoring%>" src="/img/stargray_left.png" alt="50???"/><img id="star60" class="star star_right<%=scoring%>" src="/img/stargray_right.png" alt="60???"/><!--
				--><img id="star70" class="star<%=scoring%>" src="/img/stargray_left.png" alt="70???"/><img id="star80" class="star star_right<%=scoring%>" src="/img/stargray_right.png" alt="80???"/><!--
				--><img id="star90" class="star<%=scoring%>" src="/img/stargray_left.png" alt="90???"/><img id="star100" class="star star_right<%=scoring%>" src="/img/stargray_right.png" alt="100???"/><!--
				--><input type="text" id="score" name="score" maxlength="3" required readonly/><span id="jum">???</span><!--
				--><span id="commentname">???????????? : </span>
				<input type="text" id="comments" name="comments" maxlength="50" <%
					if (session.getAttribute("memberID") == null) {
						out.print("class=\"cantscore\" placeholder=\"???????????? ????????? ????????? ????????? ??? ????????????.\" disabled readonly ");
					}
					   %>required /><!--
				--><input id="btnscore" type="button" value="????????????"<%
					if (session.getAttribute("memberID") == null) {
						out.print(" class=\"cantscore\" disabled");
					}
						  %>/>
			</form>
		</td>
	</tr>
	<tr>
		<td colspan="4">
			<table id="scorelog">
				<%
					if (scoreList == null || iterScoreList == null) {
						out.print("<tr><td class=\"none\">" + officeDTO.getSname() + "??? ?????? ??????????????? ???????????? ????????????.</td></tr>");
					} else {
						while (iterScoreList.hasNext()) {
							ScoreDTO row = iterScoreList.next();
				%>
				<tr class="scoretr">
					<td class="scorename"><%=row.getMemberName()%></td>
					<td class="scoringtime"><%=row.getScoringTime()%></td>
					<td class="scorepoint"><%
							int score = row.getScore() / 10;

							for (int i = 0; i < score; i++) {
								out.print("<img class=\"scoredstar\" src=\"/img/star_");
								if (i % 2 == 0) {
									out.print("left.png\" alt=\"\"/>");
								} else {
									out.print("right.png\" alt=\"\"/>");
								}
							}

							if (score < 10) {
								for (int i = score; i < 10; i++) {
									out.print("<img class=\"scoredstar\" src=\"/img/stargray_");
									if (i % 2 == 0) {
										out.print("left.png\" alt=\"\"/>");
									} else {
										out.print("right.png\" alt=\"\"/>");
									}
								}
							}
						%></td>
					<td class="comments"><%=row.getComments()%></td>
				</tr>
				<%
						}
						iterScoreList.remove();
						scoreList.clear();
					}
				%>
			</table>
		</td>
	</tr>
	<tr class="backtolist" onclick="movePage(<%=currentPage%>, '<%=getColumn%>', '<%=searchString%>');">
		<td class="backbutton" colspan="4">???????????? ????????????</td>
	</tr>
</table>
<div id="dummyofficeview"></div>