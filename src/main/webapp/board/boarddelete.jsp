<%@page language="java" contentType="text/html;charesultsetet=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/include/common.jsp" %>
<%@include file="/include/tools.jsp" %>
<%@page import="org.korgog.dao.BoardDAO"%>
<%@page import="org.korgog.dto.BoardDTO"%>
<%
	request.setCharacterEncoding("UTF-8");

	String getColumn = "";
	String searchString = "";
	if (request.getParameter("search") != null && request.getParameter("string") != null) {
		getColumn = request.getParameter("search").trim();
		searchString = request.getParameter("string").trim();
	}

	int currentPage = 1;
	String currentPageString = "";
	if (request.getParameter("page") != null) {
		currentPageString = request.getParameter("page");
		currentPage = Integer.parseInt(currentPageString);
	}

	int boardNum = 0;
	if (request.getParameter("boardnum") != null) {
		String currentNumString = request.getParameter("boardnum");
		boardNum = Integer.parseInt(currentNumString);
	}

	BoardDTO boardDTO = new BoardDTO();
	boardDTO.setBoardNum(boardNum);
	boardDTO.setMemberID((String) session.getAttribute("memberID"));

	BoardDAO boardDAO = new BoardDAO();
	boardDAO.delete(boardDTO, getIP(request));

	response.sendRedirect(
			"/board/board.jsp?page="
			+ currentPage
			+ "&search="
			+ getColumn
			+ "&string="
			+ searchString);
%>