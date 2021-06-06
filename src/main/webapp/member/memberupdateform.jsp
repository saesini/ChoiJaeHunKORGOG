<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/include/common.jsp" %>
<%@page import="org.korgog.dao.MemberDAO"%>
<%@page import="org.korgog.dto.MemberDTO"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	String refererPage = "";
	refererPage = request.getHeader("REFERER").toLowerCase();

	if (refererPage == null || refererPage.length() < 1) {
		refererPage = "/";
	}

	if ((String) session.getAttribute("memberID") == null) {
		response.sendRedirect(refererPage);
	}

	MemberDAO memberDAO = new MemberDAO();
	MemberDTO memberDTO = new MemberDTO();
	memberDTO = memberDAO.getMember((String) session.getAttribute("memberID"));
	String getTell = memberDTO.getTell();
	getTell = getTell.replace("--", " - - ");

	String[] tellArray = getTell.split("-");
	String tell1 = tellArray[0].replace(" ", "");
	String tell2 = tellArray[1].replace(" ", "");
	String tell3 = tellArray[2].replace(" ", "");
%>
<!DOCTYPE html>
<html>
	<head>
		<% pageContext.include("/include/meta.jsp");%>
		<link rel="stylesheet" type="text/css" href="/css/common.css">
		<link rel="stylesheet" type="text/css" href="/css/memberupdate.css">
		<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
		<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.js"></script>
		<script type="text/javascript" src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
		<script type="text/javascript" src="/script/memberupdateform.js"></script>
		<title>회원 정보수정 - GOG</title>
	</head>
	<body>
		<%@ include file = "/header.jsp"%>
		<div id="titlediv">회원정보 수정</div>
		<div class="container">
			<form id="updateform" name="updateform" method="post" action="">
				<input type="hidden" id="memberid" name="memberid" value="<%=memberDTO.getMemberID()%>"/>
				<div class="row">
					<div class="divitem">
						<label for="email">(필수) <span class="bold">이메일</span></label>
					</div>
					<div class="divvalue">
						<input type="text" id="email" name="email" maxlength="50" value="<%=memberDTO.getEmail()%>" placeholder="현재 사용하고 있는 이메일 주소를 입력해 주십시오." required/>
					</div>
				</div>
				<div class="row">
					<div class="divitem">
						<label><span class="bold">회원 아이디</span></label>
					</div>
					<div class="divvalue textvalue">
						<%=memberDTO.getMemberID()%>
					</div>
				</div>
				<div class="row">
					<div class="divitem">
						<label for="password">(필수) <span class="bold"> 기존 비밀번호 인증</span></label>
					</div>
					<div class="divvalue">
						<input type="password" id="opassword" name="opassword" maxlength="20" placeholder="현재 사용하고 있는 비밀번호를 입력해 주십시오." required/>
					</div>
				</div>
				<div class="row">
					<div class="divitem">
						<label for="password">(선택) <span class="bold">비밀번호 변경</span></label>
					</div>
					<div class="divvalue">
						<input type="password" id="password" name="password" maxlength="20" placeholder="변경시 영어, 숫자 1자 이상 조합으로 최소 8자 이상 입력필요" required/>
					</div>
				</div>
				<div class="row">
					<div class="divitem">
						<label for="password2">(선택) <span class="bold">비밀번호 확인</span></label>
					</div>
					<div class="divvalue">
						<input type="password" id="password2" name="password2" maxlength="20" placeholder="입력오류 방지를 위해 비밀번호와 동일하게 입력해 주십시오." required/>
					</div>
				</div>
				<div class="row">
					<div class="divitem">
						<label><span class="bold">이름</span></label>
					</div>
					<div class="divvalue textvalue">
						<%=memberDTO.getMemberName()%>
					</div>
				</div>
				<div class="row">
					<div class="divitem">
						<label for="area">(필수) <span class="bold">거주지역</span></label>
					</div>
					<div class="divvalue">
						<select class="pointer" id="area" name="area" required>
							<option value="">현재 거주하시는 지역을 선택하여 주십시오.</option>
							<option value="서울특별시"<%if (memberDTO.getArea().equals("서울특별시"))out.print(" selected");%>>서울특별시</option>
							<option value="부산광역시"<%if (memberDTO.getArea().equals("부산광역시"))out.print(" selected");%>>부산광역시</option>
							<option value="대구광역시"<%if (memberDTO.getArea().equals("대구광역시"))out.print(" selected");%>>대구광역시</option>
							<option value="인천광역시"<%if (memberDTO.getArea().equals("인천광역시"))out.print(" selected");%>>인천광역시</option>
							<option value="광주광역시"<%if (memberDTO.getArea().equals("광주광역시"))out.print(" selected");%>>광주광역시</option>
							<option value="대전광역시"<%if (memberDTO.getArea().equals("대전광역시"))out.print(" selected");%>>대전광역시</option>
							<option value="세종특별자치시"<%if (memberDTO.getArea().equals("세종특별자치시"))out.print(" selected");%>>세종특별자치시</option>
							<option value="경기도"<%if (memberDTO.getArea().equals("경기도"))out.print(" selected");%>>경기도</option>
							<option value="강원도"<%if (memberDTO.getArea().equals("강원도"))out.print(" selected");%>>강원도</option>
							<option value="충청북도"<%if (memberDTO.getArea().equals("충청북도"))out.print(" selected");%>>충청북도</option>
							<option value="충청남도"<%if (memberDTO.getArea().equals("충청남도"))out.print(" selected");%>>충청남도</option>
							<option value="전라북도"<%if (memberDTO.getArea().equals("전라북도"))out.print(" selected");%>>전라북도</option>
							<option value="전라남도"<%if (memberDTO.getArea().equals("전라남도"))out.print(" selected");%>>전라남도</option>
							<option value="경상북도"<%if (memberDTO.getArea().equals("경상북도"))out.print(" selected");%>>경상북도</option>
							<option value="경상남도"<%if (memberDTO.getArea().equals("경상남도"))out.print(" selected");%>>경상남도</option>
							<option value="제주특별자치도"<%if (memberDTO.getArea().equals("제주특별자치도"))out.print(" selected");%>>제주특별자치도</option>
							<option value="국외거주"<%if (memberDTO.getArea().equals("국외거주"))out.print(" selected");%>>국외거주</option>
						</select>
					</div>
				</div>
				<div class="row">
					<div class="divitem">
						<label for="tell1">(선택) <span class="bold">연락처</span></label>
					</div>
					<div class="divvalue">
						<select class="tell pointer" id="tell1" name="tell1">
							<option value="">분류</option>
							<option value="010"<%if (tell1.equals("010"))out.print(" selected");%>>010</option>
							<option value="011"<%if (tell1.equals("011"))out.print(" selected");%>>011</option>
							<option value="016"<%if (tell1.equals("016"))out.print(" selected");%>>016</option>
							<option value="017"<%if (tell1.equals("017"))out.print(" selected");%>>017</option>
							<option value="019"<%if (tell1.equals("019"))out.print(" selected");%>>019</option>
							<option value="02"<%if (tell1.equals("02"))out.print(" selected");%>>02</option>
							<option value="031"<%if (tell1.equals("031"))out.print(" selected");%>>031</option>
							<option value="032"<%if (tell1.equals("032"))out.print(" selected");%>>032</option>
							<option value="033"<%if (tell1.equals("033"))out.print(" selected");%>>033</option>
							<option value="041"<%if (tell1.equals("041"))out.print(" selected");%>>041</option>
							<option value="042"<%if (tell1.equals("042"))out.print(" selected");%>>042</option>
							<option value="043"<%if (tell1.equals("043"))out.print(" selected");%>>043</option>
							<option value="044"<%if (tell1.equals("044"))out.print(" selected");%>>044</option>
							<option value="051"<%if (tell1.equals("051"))out.print(" selected");%>>051</option>
							<option value="052"<%if (tell1.equals("052"))out.print(" selected");%>>052</option>
							<option value="053"<%if (tell1.equals("053"))out.print(" selected");%>>053</option>
							<option value="054"<%if (tell1.equals("054"))out.print(" selected");%>>054</option>
							<option value="055"<%if (tell1.equals("055"))out.print(" selected");%>>055</option>
							<option value="061"<%if (tell1.equals("061"))out.print(" selected");%>>061</option>
							<option value="062"<%if (tell1.equals("062"))out.print(" selected");%>>062</option>
							<option value="063"<%if (tell1.equals("063"))out.print(" selected");%>>063</option>
							<option value="064"<%if (tell1.equals("064"))out.print(" selected");%>>064</option>
						</select>
						<span>&mdash;</span>
						<input type="text" class="tell" id="tell2" name="tell2" value="<%=tell2%>" maxlength="4"/>
						<span>&mdash;</span>
						<input type="text" class="tell" id="tell3" name="tell3" value="<%=tell3%>" maxlength="4"/>
					</div>
				</div>
				<div class="row">
					<div class="divitem">
						<label><span class="bold">생년월일</span></label>
					</div>
					<div class="divvalue textvalue">
						<%
							StringBuffer birthDay = new StringBuffer(memberDTO.getBirthday().substring(0, 10).replace("-", ""));
							birthDay.insert(4, "년 ");
							birthDay.insert(8, "월 ");
							birthDay.insert(12, "일");
							out.println(birthDay);
						%>
					</div>
				</div>
				<div class="row">
					<div class="divitem">
						<label><span class="bold">성별</span></label>
					</div>
					<div class="divvalue textvalue"><%
							if (memberDTO.getGender().equals("M")) {
								out.print("남");
							} else {
								out.print("여");
							}
						%>성</div>
				</div>
				<div class="row btnupdatediv">
						<input id="btnupdate" type="button" value="정보수정"/>
						<input id="btnexit" type="button" value="회원탈퇴"/>
						<input id="btnreturn" type="button" value="돌아가기"/>
				</div>
			</form>
		</div>
		<%@ include file = "/footer.jsp"%>
	</body>
</html>