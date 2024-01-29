let map;
let marker;
let geocoder;


// マップの初期化関数
function initMap(){
  geocoder = new google.maps.Geocoder();

  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: 35.7100, lng:139.8107},
    zoom: 15,
  });
}


// 「取得」ボタンクリック時に実行される関数
function createMarker(){
  let inputAddress = document.getElementById('spot').value;

  geocoder.geocode( { 'address': inputAddress}, function(results, status) {
    if (status == 'OK') {
      if (marker) {
        marker.setMap(null);
      }

      let newLocation = results[0].geometry.location;
      map.setCenter(newLocation);
      marker = new google.maps.Marker({
        position:  newLocation,
        map: map,
        draggable: true,
      });

      getAddress(newLocation);

      google.maps.event.addListener(marker, 'dragend', function() {
        getAddress(marker.getPosition());
      });
    } else {
      alert('住所を取得できませんでした。');
    }
  });
}


// 「リセット」ボタンをクリックした際に実行される関数
function deleteMaker(){
  if (marker) {
    marker.setMap(null);
    document.getElementById('latitude').value = "";
    document.getElementById('longitude').value = "";
    document.getElementById('address').value = "";
  } else {
    alert('マーカーが作成されていません');
  }
}



// 座標から住所を取得し住所フォームに入力する関数
function getAddress(location) {
  document.getElementById('latitude').value = location.lat();
  document.getElementById('longitude').value = location.lng();

  geocoder.geocode({ 'location': location }, function(results, status) {
    if (status === 'OK') {
      let formattedAddress = results[0].formatted_address;
      let cleanedAddress = extractAddress(formattedAddress);
      document.getElementById('address').value = cleanedAddress;
    } else {
      alert('逆ジオコーディングに失敗しました');
    }
  });
}



// 座標から取得した住所から郵便番号や国名を取り除き都道府県より後ろだけを抽出する関数
function extractAddress(address) {
  const addressWithoutPostalCode = address.replace(/〒\s*\d{3}-?\d{4}\s*/, '').trim();
  const matchResult = addressWithoutPostalCode.match(/[^、]+、(.*)/);

  if (matchResult) {
    return matchResult[1].trim();
  } else {
    return address;
  }
}


// 編集でフォームを使用する場合、インスタンスのデータからマーカーを作成する関数
function initializeMarker(latitude, longitude) {
  if (latitude && longitude) {
    let location = new google.maps.LatLng(latitude, longitude);
    map.setCenter(location);
    if (marker) {
      marker.setMap(null);
    }
    marker = new google.maps.Marker({
      position: location,
      map: map,
      draggable: true,
    });

    google.maps.event.addListener(marker, 'dragend', function() {
      getAddress(marker.getPosition());
    });
  }
}


// 画面ロード時に緯度、経度がフォームに入力されていた場合、initializeMarker関数を実行するための処理
document.addEventListener('DOMContentLoaded', function() {
  let latitude = document.getElementById('latitude').value;
  let longitude = document.getElementById('longitude').value;

  if (latitude && longitude) {
    initializeMarker(parseFloat(latitude), parseFloat(longitude));
  }
});


// 関数をグローバルにするための記述
window.initMap = initMap;
window.createMarker = createMarker;
window.deleteMaker = deleteMaker;
