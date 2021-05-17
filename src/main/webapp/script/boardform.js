var tabString = new RegExp(); // 정규식 생성자 만들고
tabString = /[<][^>]*[>]/gi; // 모든 HTML 태그에 매칭으로 대입

$(function () {
	$("#btnaction").click(function () {
		var strSubject = $("#subject").val().replace(tabString, "");
		var strContent = $("#content").val().replace(tabString, "");

		strSubject.trim();
		strContent.trim();

		$("#subject").val(strSubject);
		$("#content").val(strContent);

		if (strSubject.length < 5) {
			alert("제목을 5글자 이상으로 입력하여 주십시오.");
			$("#subject").focus();
			return false;
		}

		if (strContent.length < 5) {
			alert("내용을 10글자 이상으로 입력하여 주십시오.");
			$("#content").focus();
			return false;
		}

		if ($("#actionform").attr("action") === "/board/boardedit.jsp") {
			if (!confirm("게시물을 수정하시겠습니까?")) {
				return false;
			}
		}

		$("#actionform").submit();
	});

	$("#btnreturn").click(function () {
		history.back();
	});
});