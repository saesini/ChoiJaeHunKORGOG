<%@page language="java" contentType="text/html;charesultsetet=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/include/common.jsp" %>
<%@include file="/include/tools.jsp" %>
<%@page import="org.korgog.dao.MemberDAO"%>
<%@page import="org.korgog.dto.MemberDTO"%>
<%@page import="org.korgog.service.Tools"%>
<%
	request.setCharacterEncoding("UTF-8");

	MemberDAO memberDAO = new MemberDAO();
	MemberDTO inputMemberDTO = new MemberDTO();
	MemberDTO outputMemberDTO = new MemberDTO();

	boolean loginResult = false;
	String refererPage = "";
	refererPage = request.getHeader("REFERER").toLowerCase();

	if (refererPage == null || refererPage.length() < 1 || !refererPage.contains("/member/memberloginform.jsp")) {
		response.sendRedirect("/");
	}

	String inflowPage = request.getParameter("inflowpage");
	if ((String) session.getAttribute("memberID") != null || !inflowPage.contains("office") && !inflowPage.contains("score") && !inflowPage.contains("board")) {
		inflowPage = "/";
	}

	String memberID = "";
	String password = "";
	if (request.getParameter("memberid") != null) {
		memberID = request.getParameter("memberid").trim().toLowerCase();
		memberID = Tools.removeTags(memberID);
	}
	if (request.getParameter("password") != null) {
		password = request.getParameter("password");
	}

	if (request.getHeader("REFERER") == null || refererPage.length() < 1 || memberID.length() < 1 || password.length() < 1) {
		loginResult = false;
	} else if (refererPage != null && refererPage.length() > 0 && refererPage.contains("/member/memberloginform.jsp")) {
		inputMemberDTO.setMemberID(memberID);
		inputMemberDTO.setPassword(password);
		if (memberDAO.getCountLogin(inputMemberDTO.getMemberID(), inputMemberDTO.getPassword()) > 0) {
			outputMemberDTO = memberDAO.getMember(inputMemberDTO);
			session.setAttribute("memberNum", outputMemberDTO.getMemberNum());
			session.setAttribute("permission", outputMemberDTO.getPermission());
			session.setAttribute("memberID", outputMemberDTO.getMemberID());
			session.setAttribute("memberName", outputMemberDTO.getMemberName());
			
			memberDAO.addLoginLog(outputMemberDTO, getIP(request));
			loginResult = true;
		}
	} else {
		loginResult = false;
	}
	
	if (loginResult == true) {
		if (inflowPage.contains("member")) {
			inflowPage = "/";
		}
		response.sendRedirect(inflowPage);
	}
%>