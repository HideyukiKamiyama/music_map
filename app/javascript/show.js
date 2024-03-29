// コントローラで作成した変数をJavaScriptに渡すための記法
const spot = gon.spot;
let mapPosition;
let map;


// マップの初期化関数
function initMap(){
  mapPosition = {lat: parseFloat(spot['latitude']), lng: parseFloat(spot['longitude']) };

  map = new google.maps.Map(document.getElementById('map'), {
    zoom: 17,
    center: mapPosition
  });

  new google.maps.Marker({
    position: mapPosition,
    map: map
  });
}


// 現在地と経路を表示するための関数
function getCurrentLocation(){
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(
      function(position) {
        let currentLocation = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);

        new google.maps.Marker({
          position: currentLocation,
          map: map,
          icon: {
            url: '/images/current_location_marker.png',
            scaledSize: new google.maps.Size(37, 37)
          }
        });

        let directionsService = new google.maps.DirectionsService();
        let directionsRenderer = new google.maps.DirectionsRenderer({
          suppressMarkers: true
        });
        let request = {
          origin: currentLocation,
          destination: mapPosition,
          travelMode: google.maps.DirectionsTravelMode.WALKING,
        };

        directionsService.route(request, function(result, status) {
          if (status == 'OK') {
            directionsRenderer.setDirections(result);
            directionsRenderer.setMap(map);
          }
        });
      }
    );
  } else {
    alert("このブラウザは位置情報に対応していません");
  }
}


// 聖地削除時に確認ダイアログを表示するための関数
function checkDelete(){
  if(window.confirm("本当に削除しますか？")){
    return true;
  }
  else{
    window.alert("キャンセルされました");
    return false;
  }
}


// 関数をグローバルにするための記述
window.initMap = initMap;
window.getCurrentLocation = getCurrentLocation;
window.checkDelete = checkDelete;
