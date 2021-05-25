$(function () {
	function agreeTerms() {
		if (!$("#agree1").is(":checked")) {
			alert("서비스 이용약관에 동의하여야만 회원가입을 할 수 있습니다.");
			return false;
		} else if (!$("#agree2").is(":checked")) {
			alert("개인정보 수집 및 이용에 동의하여야만 회원가입을 할 수 있습니다.");
			return false;
		}
		$("#termsform").submit();
	}

	$("#btnagree").click(function () {
		agreeTerms();
	});

	$("#return").click(function () {
		history.back();
	});
});