function addDelimeter(checkCount) {
	if (checkCount > 0) {
		return '&';
	} else {
		return '?';
	}
}

function cantWrite() {
	alert('로그인한 회원만 글을 작성할 수 있습니다.');
}

function boardWrite() {
	window.location.href = '/board/board.jsp?mode=write';
}

function viewBoard(num, page, searchColumn, searchString) {
	searchColumn = searchColumn.trim();
	searchString = searchString.trim();
	var checkParameter = 1;
	var targetURL = 'board.jsp?mode=view';

	if (typeof (num) === 'number' && num > 0) {
		targetURL = targetURL + addDelimeter(checkParameter) + 'num=' + num;
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

function movePage(page, searchColumn, searchString) {
	searchColumn = searchColumn.trim();
	searchString = searchString.trim();
	var checkParameter = 0;
	var targetURL = 'board.jsp';

	if (typeof (page) === 'number' && page > 1 && page > 0) {
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

function searchBoard() {
	var selectSource = document.getElementById("searchselect");
	var searchColumn = selectSource.options[selectSource.selectedIndex].value;
	var searchString = document.getElementById("searchinput").value;

	searchColumn = searchColumn.trim();
	searchString = searchString.trim();

	if(searchString.length < 1 || searchString.length < 1) {
		alert("검색어를 입력한 후 다시 검색을 시도하여 주십시오.");
		return false;
	}

	movePage(0, searchColumn, searchString);
}

function enterkey() {
	if (window.event.keyCode === 13) {
		searchBoard();
	} else {
		return false;
	}
}