// コントローラで作成した変数をJavaScriptに渡すための記法
const spot = gon.spot;

// マップの初期化関数
function initMap(){
  let mapPosition = {lat: spot.latitude, lng: spot.longitude };

  let map = new google.maps.Map(document.getElementById('map'), {
    zoom: 17,
    center: mapPosition
  });

  let marker = new google.maps.Marker({
    position: mapPosition,
    map: map
  });
}

// initMap関数をグローバルに配置するための記述
window.initMap = initMap;
