<%@page language="java" contentType="text/html;charesultsetet=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/include/common.jsp" %>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%
	request.setCharacterEncoding("UTF-8");

	String mode = "";
	String title = "";
	String includePage = "";
	List<String> script = new ArrayList<>();
	List<String> css = new ArrayList<>();

	if (request.getParameter("mode") != null) {
		mode = request.getParameter("mode").trim();
	}

	switch (mode) {
		case "view":
			includePage = "/office/officeview.jsp";
			title = "관공서정보 상세보기";
			script.add("//dapi.kakao.com/v2/maps/sdk.js?appkey=1473f6d777f7970037217ffe4332b3bc&libraries=services");
			script.add("https://code.jquery.com/jquery-3.6.0.js");
			script.add("/script/officeview.js");
			css.add("/css/common.css");
			css.add("/css/office.css");
			break;
		default:
			includePage = "/office/officelist.jsp";
			title = "관공서정보 목록";
			script.add("/script/officelist.js");
			css.add("/css/common.css");
			css.add("/css/office.css");
			break;
	}
	Iterator<String> iterScript = script.iterator();
	Iterator<String> iterCss = css.iterator();
%>
<!DOCTYPE html>
<html>
	<head>
		<%
			pageContext.include("/include/meta.jsp");
			out.println("");
			while (iterScript.hasNext()) {
				out.println("\t\t<script type=\"text/javascript\" src=\"" + iterScript.next() + "\"></script>");
			}

			while (iterCss.hasNext()) {
				out.println("\t\t<link rel=\"stylesheet\" type=\"text/css\" href=\"" + iterCss.next() + "\"/>");

			}
			out.print("\t\t");
		%>
		<title><%=title%> - GOG</title>
	</head>
	<body>
		<%@ include file = "/header.jsp"%>
		<% pageContext.include(includePage);%>
		<%@ include file = "/footer.jsp"%>
	</body>
</html>