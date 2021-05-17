function addDelimeter(checkCount) {
	if (checkCount > 0) {
		return '&';
	} else {
		return '?';
	}
}

function viewOffice(num, page, searchColumn, searchString) {
	searchColumn = searchColumn.trim();
	searchString = searchString.trim();
	var checkParameter = 1;
	var targetURL = 'office.jsp?mode=view';

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
	var targetURL = 'office.jsp';

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

function searchOffice() {
	var selectSource = document.getElementById("searchselect");
	var searchColumn = selectSource.options[selectSource.selectedIndex].value;
	var searchString = document.getElementById("searchinput").value;

	searchColumn = searchColumn.trim();
	searchString = searchString.trim();

	movePage(0, searchColumn, searchString);
}

function enterkey() {
	if (window.event.keyCode === 13) {
		searchOffice();
	} else {
		return false;
	}
}