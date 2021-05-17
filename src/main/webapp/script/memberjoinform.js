// 가입 입력값 형식 체크 정규 표현식
var regExpEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
var regExpID = /^[a-z]+[a-z0-9]{3,20}$/;
var regExpEng = /[a-zA-Z]/;
var regExpNum = /[0-9]/;
var regExpNameKor = /^[가-힣]{2,20}$/;
var regExpNameEng = /^[a-zA-Z]{2,40}\s[a-zA-Z]{2,40}$/;

// 생년월일 선택 날짜 범위 지정 - 최소날짜:국내 최고령자 기준 , 최대날짜:만14세 이상(개인정보보호법)
var today = new Date();
var year = today.getFullYear();
var month = today.getMonth();
var date = today.getDate();
if (month < 10) {
	month = '0' + month;
}
if (date < 10) {
	date = '0' + date;
}
month++;
var minDateVar = '1900-01-01';
var maxDateVar = year - 14 + '-' + month + '-' + date;
var defaulDateVar = year - 35 + '-01-01';

$(function () {
	$(".tell").on("change paste keyup keypress", function () {
		regNumber = /^[0-9]*$/;
		var str = $(this).val();
		if (!regNumber.test(str)) {
			var res = str.substring(0, str.length - 1);
			$(this).val(res);
			$(this).focus();
		}
	});

	$("#tell1").on("change", function () {
		if (this.value !== null && this.value.length > 0) {
			$("#tell2").focus();
		}
	});

	$("#tell2").on("change paste keyup", function () {
		if ($(this).val().length >= 4) {
			$("#tell3").focus();
		}
	});

	$("#male").click(function () {
		$("#female").attr("style", "font-weight: normal;");
		$("#male").attr("style", "font-weight: bold;");
		$("#male").attr("style", "border-color: #000000;");
		$("#gender").val("M");
	});

	$("#female").click(function () {
		$("#male").attr("style", "font-weight: normal;");
		$("#female").attr("style", "font-weight: bold;");
		$("#female").attr("style", "border-color: #000000;");
		$("#gender").val("F");
	});

	$("#btnjoin").click(function () {
		if (!regExpEmail.test($("#email").val())) {
			alert("이메일 주소가 유효한 형식이 아닙니다.");
			$("#email").val(null);
			$("#email").focus();
			return false;
		} else {
			var emailCount = 0;
			$.ajax({
				cache: false,
				async: false,
				type: "POST",
				url: "/ajax/checkcount.jsp",
				data: {
					checkColumn: "EMAIL",
					checkString: $("#email").val()
				},
				dataType: "json",
				success: function (count) {
					emailCount = parseInt(count);
				}, error: function (e) {
					alert(e.responseText);
				}
			});
			if (emailCount > 0) {
				alert("이미 가입한 내역이 존재하는 이메일 주소입니다.");
				$("#email").focus();
				return false;
			}
		}

		if (!regExpID.test($("#memberid").val())) {
			alert("회원 아이디는 영어로 시작되어야 하고\n영어와 숫자만 허용되며 최소 4자 이상\n최대 20자 이하로 입력 가능합니다.");
			$("#memberid").val(null);
			$("#memberid").focus();
			return false;
		} else {
			var memberidCount = 0;
			$.ajax({
				cache: false,
				async: false,
				type: "POST",
				url: "/ajax/checkcount.jsp",
				data: {
					checkColumn: "MEMBERID",
					checkString: $("#memberid").val()
				},
				dataType: "json",
				success: function (count) {
					memberidCount = parseInt(count);
				}, error: function (e) {
					alert(e.responseText);
				}
			});
			if (memberidCount > 0) {
				alert("이미 다른 회원이 사용 중인 아이디입니다.");
				$("#memberid").focus();
				return false;
			}
		}

		if (!regExpEng.test($("#password").val()) || !regExpNum.test($("#password").val()) || $("#password").val().length < 8) {
			alert("비밀번호는 반드시 영어와 숫자를 조합하여\n최소 8자 이상 입력해야 합니다.");
			$("#password2").val(null);
			$("#password").val(null);
			$("#password").focus();
			return false;
		}

		if ($("#password").val() !== $("#password2").val()) {
			alert("비밀번호 엽력란과 비밀번호 확인란에\n입력된 비밀번호가 일치하지 않습니다.\n다시 입력해주십시오.");
			$("#password2").val(null);
			$("#password").val(null);
			$("#password").focus();
			return false;
		}

		if (!regExpNameKor.test($("#membername").val()) && !regExpNameEng.test($("#membername").val())) {
			alert("이름을 입력해주십시오.\n이름은 한글 2~20자,\n영어 2~40자 까지 입력할 수 있습니다.");
			$("#membername").val(null);
			$("#membername").focus();
			return false;
		}

		var area = $("#area option:selected").val();
		if (area === null || area === "" || area.length < 1) {
			alert("거주지역을 선택해주십시오.");
			$("#area").focus();
			return false;
		}

		if ($("#birthday").val() === null || $("#birthday").val() === "" || $("#birthday").val().length != 10) {
			alert("생년월일을 선택하여 주십시오.");
			return false;
		}

		if ($("#gender").val() !== "M" && $("#gender").val() !== "F") {
			alert("성별을 선택해주십시오.");
			return false;
		}

		$("#joinform").submit();
	});
});

$.datepicker.setDefaults({
	dateFormat: 'yy-mm-dd',
	useCurrent: false,
	showClose: true,
	yearRange: "c-131:c",
	minDate: minDateVar,
	maxDate: maxDateVar,
	defaultDate: defaulDateVar,
	changeYear: true,
	changeMonth: false,
	prevText: '이전 달',
	nextText: '다음 달',
	monthNames: ['01월', '02월', '03월', '04월', '05월', '06월', '07월', '08월', '09월', '10월', '11월', '12월'],
	monthNamesShort: ['01월', '02월', '03월', '04월', '05월', '06월', '07월', '08월', '09월', '10월', '11월', '12월'],
	dayNames: ['일', '월', '화', '수', '목', '금', '토'],
	dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
	dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	showMonthAfterYear: true,
	yearSuffix: '년'
});

$('#birthdate').datepicker({
	startView: 2,
	maxViewMode: 2,
	daysOfWeekHighlighted: "1,2"
});

$(function () {
	$("#birthday").datepicker();
});