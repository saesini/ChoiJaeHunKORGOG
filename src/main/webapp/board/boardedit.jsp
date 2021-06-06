<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/include/common.jsp" %>
<%@include file="/include/tools.jsp" %>
<%@page import="org.korgog.service.Tools"%>
<%@page import="org.korgog.dao.BoardDAO"%>
<%@page import="org.korgog.dto.BoardDTO"%>
<%
	request.setCharacterEncoding("UTF-8");

	String refererPage = "";
	refererPage = request.getHeader("REFERER");

	if (refererPage == null || refererPage.length() < 1) {
		refererPage = "/";
	}
	
	int boardNum = 0;
	int memberNum = (Integer) session.getAttribute("memberNum");
	String subject = "";
	String content = "";
	
	if (request.getParameter("boardnum") != null) {
		String currentNumString = request.getParameter("boardnum");
		boardNum = Integer.parseInt(currentNumString);
	}

	BoardDAO boardDAO = new BoardDAO();
	BoardDTO originalDTO = new BoardDTO();
	originalDTO = boardDAO.getView(boardNum);

	if(memberNum != originalDTO.getMemberNum()) {
		response.sendRedirect(refererPage);
	} else {
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
		boardDTO.setBoardNum(boardNum);
		boardDTO.setMemberNum(memberNum);
		boardDTO.setSubject(subject);
		boardDTO.setContent(content);

		boardDAO.edit(boardDTO, getIP(request), boardNum, memberNum);

		response.sendRedirect("/board/board.jsp?mode=view&num=" + boardNum);
	}
%>