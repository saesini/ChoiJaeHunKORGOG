<%@page language="java" contentType="text/html;charesultsetet=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/include/common.jsp" %>
<%@include file="/include/tools.jsp" %>
<%@page import="org.korgog.dao.MemberDAO"%>
<%@page import="org.korgog.dto.MemberDTO"%>
<%@page import="org.korgog.service.Tools"%>
<%
	request.setCharacterEncoding("UTF-8");

	boolean joinResult = false;
	String refererPage;
	refererPage = request.getHeader("REFERER");

	if (refererPage == null || refererPage.length() < 1 || !refererPage.contains("/member/memberjoinform.jsp")) {
		response.sendRedirect("/");
	}

	String email = "";
	String memberID = "";
	String password = "";
	String password2 = "";
	String memberName = "";
	String area = "";
	String tell1 = "";
	String tell2 = "";
	String tell3 = "";
	String birthday = "";
	String gender = "";
	if (request.getParameter("email") != null) {
		email = request.getParameter("email").trim().toLowerCase();
		email = Tools.removeTags(email);
	}
	if (request.getParameter("memberid") != null) {
		memberID = request.getParameter("memberid").trim().toLowerCase();
		memberID = Tools.removeTags(memberID);
	}
	if (request.getParameter("password") != null && request.getParameter("password2") != null) {
		password = request.getParameter("password");
		password2 = request.getParameter("password2");
	}
	if (request.getParameter("membername") != null) {
		memberName = request.getParameter("membername").trim();
		memberName = Tools.removeTags(memberName);
	}
	if (request.getParameter("area") != null) {
		area = request.getParameter("area").trim();
		area = Tools.removeTags(area);
	}
	if (request.getParameter("tell1") != null) {
		tell1 = request.getParameter("tell1").trim();
		tell1 = Tools.removeTags(tell1);
	}
	if (request.getParameter("tell2") != null) {
		tell2 = request.getParameter("tell2").trim();
		tell2 = Tools.removeTags(tell2);
	}
	if (request.getParameter("tell3") != null) {
		tell3 = request.getParameter("tell3").trim();
		tell3 = Tools.removeTags(tell3);
	}
	if (request.getParameter("birthday") != null) {
		birthday = request.getParameter("birthday").trim();
		birthday = Tools.removeTags(birthday);
	}
	if (request.getParameter("gender") != null) {
		gender = request.getParameter("gender").trim();
		gender = Tools.removeTags(gender);
	}

	if (email.length() < 1 || memberID.length() < 1 || password.length() < 1 || password2.length() < 1 || memberName.length() < 1 || area.length() < 1 || birthday.length() < 1 || gender.length() < 1) {
		joinResult = false;
	} else if (!password.equals(password2)) {
		joinResult = false;
	} else if (refererPage != null && refererPage.length() > 1 && refererPage.contains("/member/memberjoinform.jsp")) {
		MemberDTO memberDTO = new MemberDTO();
		memberDTO.setPermission(1);
		memberDTO.setEmail(email);
		memberDTO.setMemberID(memberID);
		memberDTO.setPassword(password);
		memberDTO.setMemberName(memberName);
		memberDTO.setArea(area);
		memberDTO.setTell(tell1 + "-" + tell2 + "-" + tell3);
		memberDTO.setBirthday(birthday);
		memberDTO.setGender(gender);

		MemberDAO memberDAO = new MemberDAO();
		joinResult = memberDAO.addMember(memberDTO, getIP(request));
	}

	response.sendRedirect("/");
%>