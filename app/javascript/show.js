// コントローラで作成した変数をJavaScriptに渡すための記法
const spot = gon.spot;

// マップの初期化関数
function initMap(){
  let mapPosition = {lat: parseFloat(spot['latitude']), lng: parseFloat(spot['longitude']) };

  let map = new google.maps.Map(document.getElementById('map'), {
    zoom: 17,
    center: mapPosition
  });

  new google.maps.Marker({
    position: mapPosition,
    map: map
  });
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
window.checkDelete = checkDelete;
