<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/include/common.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");

	session.removeAttribute("memberNum");
	session.removeAttribute("permission");
	session.removeAttribute("memberID");
	session.removeAttribute("memberName");
	session.invalidate();
	
	String refererPage;
	refererPage = request.getHeader("REFERER").toLowerCase();
	if (refererPage.contains("member") || refererPage.contains("admin") || refererPage == null || refererPage.length() < 1) {
		refererPage = "/";
	}
	response.sendRedirect(refererPage);
%>