function addDelimeter(checkCount) {
	if (checkCount > 0) {
		return '&';
	} else {
		return '?';
	}
}

function viewAccessLog(num, page, searchColumn, searchString) {
	searchColumn = searchColumn.trim();
	searchString = searchString.trim();
	var checkParameter = 1;
	var targetURL = 'accesslog.jsp?mode=view';

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
	var targetURL = 'accesslog.jsp';

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

function searchAccessLog() {
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
		searchAccessLog();
	} else {
		return false;
	}
}