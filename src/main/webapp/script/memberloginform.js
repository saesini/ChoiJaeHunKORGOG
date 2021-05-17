var regExpID = /^[a-z]+[a-z0-9]{3,20}$/;
var regExpEng = /[a-zA-Z]/;
var regExpNum = /[0-9]/;

$(function () {
	function memberLogin() {
		if (!regExpID.test($("#memberid").val())) {
			alert("회원 아이디 형식이 유효하지 않습니다.");
			$("#memberid").val(null);
			$("#memberid").focus();
			return false;
		} else if (!regExpEng.test($("#password").val()) || !regExpNum.test($("#password").val()) || $("#password").val().length < 8) {
			alert("비밀번호 형식이 유효하지 않습니다.");
			$("#password").val(null);
			$("#password").focus();
			return false;
		} else {
			var loginMatchedCount = 0;
			$.ajax({
				cache: false,
				async: false,
				type: "POST",
				url: "/ajax/checklogin.jsp",
				data: {
					memberid: $("#memberid").val(),
					password: $("#password").val()
				},
				dataType: "json",
				success: function(count) {
					loginMatchedCount = parseInt(count);
				}, error: function(e) {
					alert(e.responseText);
				}
			});
			if (loginMatchedCount < 1) {
				alert("잘못된 비밀번호가 입력되었거나 존재하지 않는 회원 ID 또는 탈퇴한 회원입니다. 다시 입력하여 주십시오.");
				$("#password").val(null);
				$("#password").focus();
				return false;
			}
		}
		$("#loginform").submit();
	}

	$("#btnlogin").click(function () {
		memberLogin();
	});

	$('#memberid').keypress(function (e) {
		var key = e.which;
		if (key === 13)  // the enter key code
		{
			if ($("#memberid").val().length >= 4 && $("#password").val().length >= 8) {
				memberLogin();
			} else if ($("#memberid").val().length >= 4) {
				$("#password").focus();
			} else {
				alert("회원 아이디 형식이 유효하지 않습니다.");
			}
		}
	});

	$('#password').keypress(function (e) {
		var key = e.which;
		if (key === 13)  // the enter key code
		{
			if ($("#memberid").val().length >= 4 && $("#password").val().length >= 8) {
				memberLogin();
			} else if ($("#password").val().length >= 8) {
				$("#memberid").focus();
			} else {
				alert("비밀번호 형식이 유효하지 않습니다.");
			}
		}
	});

	$("#return").click(function () {
		history.back();
	});
});