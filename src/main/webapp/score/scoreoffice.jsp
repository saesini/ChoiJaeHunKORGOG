<%@page language="java" contentType="text/html;charesultsetet=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/include/common.jsp" %>
<%@include file="/include/tools.jsp" %>
<%@page import="org.korgog.dao.ScoreDAO"%>
<%@page import="org.korgog.dto.ScoreDTO"%>
<%
	request.setCharacterEncoding("UTF-8");

	String refererPage;
	refererPage = request.getHeader("REFERER").toLowerCase();

	String officeNum = request.getParameter("officenum");
	String score = request.getParameter("score");
	String comments = request.getParameter("comments");

	int intOfficeNum = Integer.parseInt(officeNum);
	int intScore = Integer.parseInt(score);

	if (session.getAttribute("memberID") == null) {
		response.sendRedirect(refererPage);
	} else if (intScore < 10 || intScore > 100) {
		response.sendRedirect(refererPage);
	} else if (comments.length() < 10 || comments.length() > 50) {
		response.sendRedirect(refererPage);
	}

	ScoreDTO scoreDTO = new ScoreDTO();
	scoreDTO.setMemberNum((Integer) session.getAttribute("memberNum"));
	scoreDTO.setOfficeNum(intOfficeNum);
	scoreDTO.setScore(intScore);
	scoreDTO.setComments(comments);

	ScoreDAO scoreDAO = new ScoreDAO();
	scoreDAO.scoreOffice(scoreDTO, getIP(request));

	response.sendRedirect(refererPage);
%>