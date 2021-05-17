<%@page language="java" contentType="text/html;charesultsetet=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/include/common.jsp" %>
<%@page import="org.korgog.dao.MemberDAO"%>
<%@page import="org.korgog.service.Tools"%>
<%
	request.setCharacterEncoding("UTF-8");

	int count = 1;
	String checkID = "";
	String checkColumn = request.getParameter("checkColumn");
	String checkString = "";
	if (request.getParameter("checkString") != null) {
		checkString = request.getParameter("checkString").toLowerCase();
		checkString = Tools.removeTags(checkString);
		if (request.getParameter("checkID") != null) {
			checkID = request.getParameter("checkID").toLowerCase();
			checkID = Tools.removeTags(checkID);
		}
		MemberDAO memberDAO = new MemberDAO();
		count = memberDAO.getCount(checkID, checkColumn, checkString);
	}

	out.println(count);
%>