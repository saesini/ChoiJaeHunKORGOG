<%@page language="java" contentType="text/html;charesultsetet=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/include/common.jsp" %>
<%@include file="/include/tools.jsp" %>
<%@page import="org.korgog.dao.MemberDAO"%>
<%@page import="org.korgog.dto.MemberDTO"%>
<%@page import="org.korgog.service.Tools"%>
<%
	request.setCharacterEncoding("UTF-8");

	boolean updateResult = false;
	String refererPage;
	refererPage = request.getHeader("REFERER").toLowerCase();

	if (refererPage == null || refererPage.length() < 1 || !refererPage.contains("/member/memberupdateform.jsp")) {
		response.sendRedirect("/");
	}

	if ((String) session.getAttribute("memberID") == null) {
		response.sendRedirect(refererPage);
	}
	
	String email = "";
	String memberID = "";
	String password = "";
	String password2 = "";
	String area = "";
	String tell1 = "";
	String tell2 = "";
	String tell3 = "";
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

	if ((String) session.getAttribute("memberID") == null) {
		updateResult = false;
	} else if (!((String) session.getAttribute("memberID")).equals(memberID)) {
		updateResult = false;
	} else if (email.length() < 1 || memberID.length() < 1 || area.length() < 1) {
		updateResult = false;
	} else if (!password.equals(password2)) {
		updateResult = false;
	} else if (refererPage != null && refererPage.length() > 1 && refererPage.contains("/member/memberupdateform.jsp")) {
		MemberDTO memberDTO = new MemberDTO();
		memberDTO.setEmail(email);
		memberDTO.setMemberID(memberID);
		memberDTO.setPassword(password);
		memberDTO.setArea(area);
		memberDTO.setTell(tell1 + "-" + tell2 + "-" + tell3);

		MemberDAO memberDAO = new MemberDAO();
		updateResult = memberDAO.updateMember(memberDTO, getIP(request));
	}

	response.sendRedirect("/");
%>