<%@page language="java" contentType="text/html;charesultsetet=UTF-8" pageEncoding="UTF-8"%>
<div id="top_header" class="preventdrag">
	<a id="top_logo" href="/"><img src="/img/logo.svg" alt="GOG"/></a><!--
	--><a class="top_menu" href="/intro.jsp">서비스소개</a><!--
	--><a class="top_menu" href="/office/office.jsp">관공서정보</a><!--
	--><a class="top_menu" href="/score/score.jsp">평가리스트</a><!--
	--><a class="top_menu" href="/board/board.jsp">토론게시판</a><!--
	--><div class="member_menu_div">
		<%
			if ((String) session.getAttribute("memberID") != null) {
				String MemberID = (String) session.getAttribute("memberID");
				String memberName = (String) session.getAttribute("memberName");
		%>
		<ul><li class="member_menu"><a><%=memberName%>(<%=MemberID%>)</a></li></ul>
		<ul>
		<%
				if ((Integer) session.getAttribute("permission") > 1) {
		%>
			<li class="member_menu"><a href="/admin/accesslog.jsp">회원로그</a></li>
		<%
				} else {
		%>
			<li class="member_menu"><a href="/member/memberupdateform.jsp">정보수정</a></li>
		<%
				}
		%>
			<li class="member_menu"><a href="/member/memberlogout.jsp">로그아웃</a></li>
		</ul>
		<%
			} else {
		%>
		<ul><li class="member_menu"><a href="/member/memberloginform.jsp">로 그 인</a></li></ul>
		<ul><li class="member_menu"><a href="/member/memberjoinform.jsp">회원가입</a></li></ul>
		<%
			}
		%>
	</div>
</div>
<div id="top_blank" class="preventdrag"></div>
<%="\t\t"%>