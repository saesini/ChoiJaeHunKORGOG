var mapContainer = document.getElementById("officemap"),
		mapOption = {
			center: new kakao.maps.LatLng(33.450701, 126.570667),
			level: 3
		};
var map = new kakao.maps.Map(mapContainer, mapOption);
var mapTypeControl = new kakao.maps.MapTypeControl();
map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
var zoomControl = new kakao.maps.ZoomControl();
map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
var geocoder = new kakao.maps.services.Geocoder();
geocoder.addressSearch(officeAddress, function (result, status) {
	if (status === kakao.maps.services.Status.OK) {
		var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		var marker = new kakao.maps.Marker({
			map: map, position: coords
		});
		var infowindow = new kakao.maps.InfoWindow({
			content: officeName
		});
		infowindow.open(map, marker);
		map.setCenter(coords);
	}
});