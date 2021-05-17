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
	var targetURL = 'accesslog.jsp';

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