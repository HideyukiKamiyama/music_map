// コントローラで作成した変数をJavaScriptに渡すための記法
const spot = gon.spot;
let map;

// マップの初期化関数
function initMap(){
  let mapPosition = {lat: parseFloat(spot['latitude']), lng: parseFloat(spot['longitude']) };

  map = new google.maps.Map(document.getElementById('map'), {
    zoom: 17,
    center: mapPosition
  });

  new google.maps.Marker({
    position: mapPosition,
    map: map
  });
}


// 現在地を取得するための関数
function getCurrentLocation(){
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(
      function(position) {
        let markerLatLng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);

        new google.maps.Marker({
          position: markerLatLng,
          map: map
        });
      }
    );
  } else {
    alert("このブラウザは位置情報に対応していません");
  }
}

// 現在地取得時に確認ダイアログを表示するための関数
function locationConfirm(){
  if(window.confirm("現在地を取得しますがよろしいですか？")){
    return true;
  }
  else{
    window.alert("キャンセルされました");
    return false;
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
window.locationConfirm = locationConfirm;
window.checkDelete = checkDelete;
