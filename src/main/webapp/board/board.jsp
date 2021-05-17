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
		case "write":
			includePage = "/board/boardwriteform.jsp";
			title = "글작성";
			script.add("https://code.jquery.com/jquery-3.6.0.js");
			script.add("/script/boardform.js");
			css.add("/css/common.css");
			css.add("/css/boardform.css");
			break;
		case "edit":
			includePage = "/board/boardeditform.jsp";
			title = "글수정";
			script.add("https://code.jquery.com/jquery-3.6.0.js");
			script.add("/script/boardform.js");
			css.add("/css/common.css");
			css.add("/css/boardform.css");
			break;
		case "view":
			includePage = "/board/boardview.jsp";
			title = "";
			script.add("https://code.jquery.com/jquery-3.6.0.js");
			script.add("/script/boardview.js");
			css.add("/css/common.css");
			css.add("/css/board.css");
			break;
		default:
			includePage = "/board/boardlist.jsp";
			title = "토론게시판";
			script.add("https://code.jquery.com/jquery-3.6.0.js");
			script.add("/script/boardlist.js");
			css.add("/css/common.css");
			css.add("/css/board.css");
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