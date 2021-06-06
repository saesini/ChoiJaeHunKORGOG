<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/include/common.jsp" %>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%
	request.setCharacterEncoding("UTF-8");

	String refererPage = "";
	refererPage = request.getHeader("REFERER").toLowerCase();

	if (refererPage == null || refererPage.length() < 1) {
		refererPage = "/";
	}
	
	if ((String) session.getAttribute("memberID") == null || (Integer) session.getAttribute("permission") < 2) {
		response.sendRedirect(refererPage);
	}
	
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
			includePage = "/admin/accesslogview.jsp";
			title = "";
			script.add("/script/accesslogview.js");
			css.add("/css/common.css");
			css.add("/css/accesslog.css");
			break;
		default:
			includePage = "/admin/accessloglist.jsp";
			title = "회원로그";
			script.add("/script/accessloglist.js");
			css.add("/css/common.css");
			css.add("/css/accesslog.css");
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