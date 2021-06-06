<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/include/common.jsp" %>
<%@include file="/include/tools.jsp" %>
<%@page import="org.korgog.dao.MemberDAO"%>
<%@page import="org.korgog.dto.MemberDTO"%>
<%@page import="org.korgog.service.Tools"%>
<%
	request.setCharacterEncoding("UTF-8");

	boolean exitResult = false;
	String refererPage;
	refererPage = request.getHeader("REFERER").toLowerCase();

	if (refererPage == null || refererPage.length() < 1 || !refererPage.contains("/member/memberupdateform.jsp")) {
		response.sendRedirect("/");
	}

	if ((String) session.getAttribute("memberID") == null) {
		response.sendRedirect(refererPage);
	}
	
	String memberID = "";
	String password = "";
	if (request.getParameter("memberid") != null) {
		memberID = request.getParameter("memberid").trim().toLowerCase();
		memberID = Tools.removeTags(memberID);
	}
	if (request.getParameter("opassword") != null) {
		password = request.getParameter("opassword");
	}

	if ((String) session.getAttribute("memberID") == null) {
		exitResult = false;
	} else if (!((String) session.getAttribute("memberID")).equals(memberID)) {
		exitResult = false;
	} else if (memberID.length() < 1 || password.length() < 1) {
		exitResult = false;
	} else if (refererPage != null && refererPage.length() > 0 && refererPage.contains("/member/memberupdateform.jsp")) {
		MemberDTO memberDTO = new MemberDTO();
		memberDTO.setMemberID(memberID);

		MemberDAO memberDAO = new MemberDAO();
		exitResult = memberDAO.exitMember(memberDTO, getIP(request));

		if (exitResult) {
			session.removeAttribute("memberNum");
			session.removeAttribute("permission");
			session.removeAttribute("memberID");
			session.removeAttribute("memberName");
			session.invalidate();
		}
	}

	response.sendRedirect("/");
%>