<%@page language="java" contentType="text/html;charesultsetet=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/include/common.jsp" %>
<%@include file="/include/tools.jsp" %>
<%@page import="org.korgog.service.Tools"%>
<%@page import="org.korgog.dao.BoardDAO"%>
<%@page import="org.korgog.dto.BoardDTO"%>
<%
	request.setCharacterEncoding("UTF-8");

	int memberNum = (Integer) session.getAttribute("memberNum");
	String subject = "";
	String content = "";

	if (request.getParameter("subject") != null) {
		subject = request.getParameter("subject").trim().toLowerCase();
		subject = Tools.removeTags(subject);
	}

	if (request.getParameter("content") != null) {
		content = request.getParameter("content").trim().toLowerCase();
		content = Tools.removeTags(content);
		content = content.replaceAll("\r\n", "<br/>");
		content = content.replaceAll("\n", "<br/>");
	}

	BoardDTO boardDTO = new BoardDTO();
	boardDTO.setMemberNum(memberNum);
	boardDTO.setSubject(subject);
	boardDTO.setContent(content);

	BoardDAO boardDAO = new BoardDAO();
	boardDAO.write(boardDTO, getIP(request));

	response.sendRedirect("/board/board.jsp");
%>