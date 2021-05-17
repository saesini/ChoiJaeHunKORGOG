// 가입 입력값 형식 체크 정규 표현식
var regExpEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
var regExpID = /^[a-z]+[a-z0-9]{3,20}$/;
var regExpEng = /[a-zA-Z]/;
var regExpNum = /[0-9]/;
var regExpNameKor = /^[가-힣]{2,20}$/;
var regExpNameEng = /^[a-zA-Z]{2,40}\s[a-zA-Z]{2,40}$/;

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

	$("#btnupdate").click(function () {
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
					checkID: $("#memberid").val(),
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

		if (!regExpEng.test($("#opassword").val()) || !regExpNum.test($("#opassword").val()) || $("#opassword").val().length < 8) {
			alert("기존 비밀번호 인증란은 현재 사용 중인 정보수정 시 본인인증을 위하여 반드시 입력해야 하며 영어와 숫자를 조합하여 최소 8자 이상입니다.");
			$("#opassword").val(null);
			$("#opassword").focus();
			return false;
		}

		if ($("#password").val().length > 0 || $("#password2").val().length > 0) {
			if (!regExpEng.test($("#password").val()) || !regExpNum.test($("#password").val()) || $("#password").val().length < 8) {
				alert("비밀번호를 변경하려면 비밀번호는 반드시 영어와 숫자를 조합하여\n최소 8자 이상 입력해야 합니다.");
				$("#password2").val(null);
				$("#password").val(null);
				$("#password").focus();
				return false;
			}

			if ($("#password").val() !== $("#password2").val()) {
				alert("비밀번호를 변경하려면 비밀번호 엽력란과 비밀번호 확인란에\n입력된 비밀번호가 일치하지 않습니다.\n다시 입력해주십시오.");
				$("#password2").val(null);
				$("#password").val(null);
				$("#password").focus();
				return false;
			}
		}

		var area = $("#area option:selected").val();
		if (area === null || area === "" || area.length < 1) {
			alert("거주지역을 선택해주십시오.");
			$("#area").focus();
			return false;
		}


		var loginMatchedCount = 0;
		$.ajax({
			cache: false,
			async: false,
			type: "POST",
			url: "/ajax/checklogin.jsp",
			data: {
				memberid: $("#memberid").val(),
				password: $("#opassword").val()
			},
			dataType: "json",
			success: function (count) {
				loginMatchedCount = parseInt(count);
			}, error: function (e) {
				alert(e.responseText);
			}
		});
		if (loginMatchedCount < 1) {
			alert("기존 비밀번호 입력란에 잘못된 비밀번호가 입력되었습니다. 회원인증을 위하여 현재 사용하고 계신 비밀번호를 정확하게 입력하여 주십시오.");
			$("#opassword").val(null);
			$("#opassword").focus();
			return false;
		}

		$("#updateform").attr("action", "/member/memberupdate.jsp");
		$("#updateform").submit();
	});

	$("#btnexit").click(function () {
		if (!regExpEng.test($("#opassword").val()) || !regExpNum.test($("#opassword").val()) || $("#opassword").val().length < 8) {
			alert("기존 비밀번호 인증란은 현재 사용 중인 정보수정 시 본인인증을 위하여 반드시 입력해야 하며 영어와 숫자를 조합하여 최소 8자 이상입니다.");
			$("#opassword").val(null);
			$("#opassword").focus();
			return false;
		}

		var loginMatchedCount = 0;
		$.ajax({
			cache: false,
			async: false,
			type: "POST",
			url: "/ajax/checklogin.jsp",
			data: {
				memberid: $("#memberid").val(),
				password: $("#opassword").val()
			},
			dataType: "json",
			success: function (count) {
				loginMatchedCount = parseInt(count);
			}, error: function (e) {
				alert(e.responseText);
			}
		});
		if (loginMatchedCount < 1) {
			alert("기존 비밀번호 입력란에 잘못된 비밀번호가 입력되었습니다. 회원인증을 위하여 현재 사용하고 계신 비밀번호를 정확하게 입력하여 주십시오.");
			$("#opassword").val(null);
			$("#opassword").focus();
			return false;
		}
		if (confirm("정말 회원 탈퇴 절차를 진행하시겠습니까?.\n탈퇴시 해당 아이디와 이메일로 가입할 수 없습니다.")) {
			$("#updateform").attr("action", "/member/memberexit.jsp");
			$("#updateform").submit();
		}
	});

	$("#btnreturn").click(function () {
		history.back();
	});
});