<%@page language="java" contentType="text/html;charesultsetet=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/include/common.jsp" %>
<%
	if (request.getParameter("agree1") == null || request.getParameter("agree1") == null) {
		response.sendRedirect("/member/memberterms.jsp");
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<% pageContext.include("/include/meta.jsp");%>
		<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.js"></script>
		<script type="text/javascript" src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
		<script type="text/javascript" src="/script/memberjoinform.js"></script>
		<link rel="stylesheet" type="text/css" href="/css/common.css">
		<link rel="stylesheet" type="text/css" href="/css/memberjoin.css">
		<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
		<title>회원 가입 - GOG</title>
	</head>
	<body>
		<%@ include file = "/header.jsp"%>
		<div id="titlediv">회원 가입</div>
		<div class="container">
			<form id="joinform" name="joinform" method="post" action="/member/memberjoin.jsp">
				<div class="row">
					<div class="divitem">
						<label for="email">(필수) <span class="bold">이메일</span></label>
					</div>
					<div class="divvalue">
						<input type="text" id="email" name="email" maxlength="50" placeholder="현재 사용하고 있는 이메일 주소를 입력해 주십시오." required/>
					</div>
				</div>
				<div class="row">
					<div class="divitem">
						<label for="memberid">(필수)  <span class="bold">회원 아이디</span></label>
					</div>
					<div class="divvalue">
						<input type="text" id="memberid" name="memberid" maxlength="20" placeholder="영어 + 숫자 20자 이내로 희망 아이디를 입력해 주십시오." required/>
					</div>
				</div>
				<div class="row">
					<div class="divitem">
						<label for="password">(필수) <span class="bold">비밀번호 입력</span></label>
					</div>
					<div class="divvalue">
						<input type="password" id="password" name="password" maxlength="20" placeholder="영어, 숫자 1자 이상 조합으로 최소 8자 이상 입력해 주십시오." required/>
					</div>
				</div>
				<div class="row">
					<div class="divitem">
						<label for="password2">(필수)  <span class="bold">비밀번호 확인</span></label>
					</div>
					<div class="divvalue">
						<input type="password" id="password2" name="password2" maxlength="20" placeholder="입력오류 방지를 위해 비밀번호와 동일하게 입력해 주십시오." required/>
					</div>
				</div>
				<div class="row">
					<div class="divitem">
						<label for="membername">(필수) <span class="bold">이름</span></label>
					</div>
					<div class="divvalue">
						<input type="text" id="membername" name="membername" maxlength="40" placeholder="한글 20자 이하 영어 40자 이하 실명을 입력하여 주십시오." required/>
					</div>
				</div>
				<div class="row">
					<div class="divitem">
						<label for="area">(필수) <span class="bold">거주지역</span></label>
					</div>
					<div class="divvalue">
						<select class="pointer" id="area" name="area" required>
							<option value="">현재 거주하시는 지역을 선택하여 주십시오.</option>
							<option value="서울특별시">서울특별시</option>
							<option value="부산광역시">부산광역시</option>
							<option value="대구광역시">대구광역시</option>
							<option value="인천광역시">인천광역시</option>
							<option value="광주광역시">광주광역시</option>
							<option value="대전광역시">대전광역시</option>
							<option value="세종특별자치시">세종특별자치시</option>
							<option value="경기도">경기도</option>
							<option value="강원도">강원도</option>
							<option value="충청북도">충청북도</option>
							<option value="충청남도">충청남도</option>
							<option value="전라북도">전라북도</option>
							<option value="전라남도">전라남도</option>
							<option value="경상북도">경상북도</option>
							<option value="경상남도">경상남도</option>
							<option value="제주특별자치도">제주특별자치도</option>
							<option value="국외거주">국외거주</option>
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
							<option value="010">010</option>
							<option value="011">011</option>
							<option value="016">016</option>
							<option value="017">017</option>
							<option value="019">019</option>
							<option value="02">02</option>
							<option value="031">031</option>
							<option value="032">032</option>
							<option value="033">033</option>
							<option value="041">041</option>
							<option value="042">042</option>
							<option value="043">043</option>
							<option value="044">044</option>
							<option value="051">051</option>
							<option value="052">052</option>
							<option value="053">053</option>
							<option value="054">054</option>
							<option value="055">055</option>
							<option value="061">061</option>
							<option value="062">062</option>
							<option value="063">063</option>
							<option value="064">064</option>
						</select>
						<span>&mdash;</span>
						<input type="text" class="tell" id="tell2" name="tell2" maxlength="4"/>
						<span>&mdash;</span>
						<input type="text" class="tell" id="tell3" name="tell3" maxlength="4"/>
					</div>
				</div>
				<div class="row">
					<div class="divitem">
						<label for="birthday">(필수, 만 14세 이상만 가입 가능) <span class="bold">생년월일</span></label>
					</div>
					<div class="divvalue">
						<input type='text' class="pointer" id="birthday" name="birthday"  placeholder="이곳을 클릭하여 생년월일을 선택하여 주십시오." maxlength="10" readOnly  required/>
					</div>
				</div>
				<div class="row">
					<div class="divitem">
						<label>(필수) <span class="bold">성별</span></label>
					</div>
					<div class="divvalue">
						<input type='hidden' id="gender" name="gender"/>
						<input type="button" id="male" class="gender pointer" value="남성"/><input type="button" id="female" class="gender pointer" value="여성"/>
					</div>
				</div>
				<div class="row btnjoindiv">
					<div class="divitem"></div>
					<div class="divvalue">
						<input id="btnjoin" type="button" value="회원가입"/>
					</div>
				</div>
			</form>
		</div>
		<%@ include file = "/footer.jsp"%>
	</body>
</html>