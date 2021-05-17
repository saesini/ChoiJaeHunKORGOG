function addDelimeter(checkCount) {
	if (checkCount > 0) {
		return '&';
	} else {
		return '?';
	}
}

function movePage(page, searchColumn, searchString) {
	searchColumn = searchColumn.trim();
	searchString = searchString.trim();
	var checkParameter = 0;
	var targetURL = 'office.jsp';

	if (typeof (page) === 'number' && page > 1) {
		targetURL = targetURL + addDelimeter(checkParameter) + 'page=' + page;
		checkParameter++;
	}

	if (typeof (searchColumn) === 'string' && searchColumn.length > 0) {
		targetURL = targetURL + addDelimeter(checkParameter) + 'search=' + searchColumn;
		checkParameter++;
	}

	if (typeof (searchString) === 'string' && searchString.length > 0) {
		targetURL = targetURL + addDelimeter(checkParameter) + 'string=' + searchString;
		checkParameter++;
	}

	window.location.href = targetURL;
}

$(function () {
	$(".scoring").click(function () {
		$(this).attr("style", "opacity: 1;");
		var score = $(this).attr('alt').replace("점", "");
		score = parseInt(score);
		for (var i = 10; i <= score; i += 10) {
			//$("#star" + i).attr("style", "opacity: 1;");
			if (i % 20 === 0) {
				$("#star" + i).attr("src", "/img/star_right.png");		
			} else {
				$("#star" + i).attr("src", "/img/star_left.png");
			}
		}
		if (i <= 100) {
			for (var j = i; j < 101; j += 10) {
				if (j % 20 === 0) {
					$("#star" + j).attr("src", "/img/stargray_right.png");		
				} else {
					$("#star" + j).attr("src", "/img/stargray_left.png");
				}
			}
		}
		$("#score").val(score);
		$("#jum").attr("style", "visibility: visible;");
	});

	$("#btnscore").click(function () {
		if (!$("#score").val() || !$("#score").val() === null || $("#score").val() < 10) {
			alert("왼쪽의 별을 클릭하여 평가점수를 10점 이상으로 선택해 주십시오.");
			return false;
		}
		if (!$("#comments").val() || !$("#comments").val() === null || $("#comments").val().length < 10 || $("#comments").val().length > 50) {
			alert("평가멘트를 최소 10자 이상 최대 50자 이하로 작성하여 주십시오.");
			$("#comments").focus();
			return false;
		}
		$("#scoreform").submit();
	});
});