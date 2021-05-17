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
	var targetURL = 'board.jsp';

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

function cantEdit() {
	alert("글 작성자만 수정할 수 있습니다.");
}

function cantDelete() {
	alert("글 작성자만 삭제할 수 있습니다.");
}

function boardEdit(boardNum, page, searchColumn, searchString) {
	searchColumn = searchColumn.trim();
	searchString = searchString.trim();
	var checkParameter = 0;
	var targetURL = '/board/board.jsp';

	targetURL = targetURL + addDelimeter(checkParameter) + 'mode=edit';
	checkParameter++;

	if (typeof (boardNum) === 'number' && boardNum > 0) {
		targetURL = targetURL + addDelimeter(checkParameter) + 'boardnum=' + boardNum;
		checkParameter++;
	}

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

function boardDelete(boardNum, page, searchColumn, searchString) {
	searchColumn = searchColumn.trim();
	searchString = searchString.trim();
	var checkParameter = 0;
	var targetURL = '/board/boarddelete.jsp';

	if (typeof (boardNum) === 'number' && boardNum > 0) {
		targetURL = targetURL + addDelimeter(checkParameter) + 'boardnum=' + boardNum;
		checkParameter++;
	}

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

	if (!confirm("삭제한 게시물은 복구할 수 없습니다.\n정말 수정하시겠습니까?")) {
		return false;
	}

	window.location.href = targetURL;
}