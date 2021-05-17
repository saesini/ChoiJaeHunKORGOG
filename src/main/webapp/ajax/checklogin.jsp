<%@page language="java" contentType="text/html;charesultsetet=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/include/common.jsp" %>
<%@page import="org.korgog.dao.MemberDAO"%>
<%@page import="org.korgog.service.Tools"%>
<%
	request.setCharacterEncoding("UTF-8");

	int count = 0;
	String memberid = "";
	String password = "";
	if (request.getParameter("memberid") != null && request.getParameter("password") != null) {
		MemberDAO memberDAO = new MemberDAO();
		memberid = request.getParameter("memberid").trim().toLowerCase();
		memberid = Tools.removeTags(memberid);
		password = request.getParameter("password");
		count = memberDAO.getCountLogin(memberid, password);
	}

	out.println(count);
%>