let marker = [];
let infoWindow = [];
let currentOpenWindow = null;
const spots = gon.spots;
const artists = gon.artists;


// タブによるマップ表示、リスト表示の切り替え処理
document.addEventListener("turbo:load", () => {
  const listView = document.getElementById("list-view");
  const mapView = document.getElementById("map-view");
  const listTab = document.getElementById("list-tab");
  const mapTab = document.getElementById("map-tab");

  listTab.addEventListener("click", () => {
    mapView.style.display = "none";
    listView.style.display = "block";
    listTab.classList.add("tab-active");
    mapTab.classList.remove("tab-active");
  });

  mapTab.addEventListener("click", () => {
    mapView.style.display = "block";
    listView.style.display = "none";
    mapTab.classList.add("tab-active");
    listTab.classList.remove("tab-active");
  });

  mapView.style.display = "block";
  listView.style.display = "none";
  mapTab.classList.add("tab-active");
  listTab.classList.remove("tab-active");
});



// マップの初期化関数
function initMap(){
  let map = new google.maps.Map(document.getElementById('map'), {
    center: { lat: 35.7100, lng: 139.8107 },
    zoom: 9
  });

  for (let i = 0; i < spots.length; i++) {
    let spot = spots[i]
    let id = spot['id']
    let artist_id = spot['artist_id']
    let artist = artists.find(item => item.id === artist_id)

    let markerLatLng = new google.maps.LatLng({
      lat: parseFloat(spot['latitude']),
      lng: parseFloat(spot['longitude'])
    });

    marker[i] = new google.maps.Marker({
      position: markerLatLng,
      map: map
    });

    infoWindow[i] = new google.maps.InfoWindow({
      content: `<a href='/spots/${id}' class='hover:underline' data-turbo='false'>${spot['spot_name']} / ${artist['name']}</a>`
    });

    markerEvent(i);
  }
}


// ウィンドウを開くための関数
function markerEvent(i) {
  marker[i].addListener('click', function () {
    if (currentOpenWindow) {
      currentOpenWindow.close();
    }
    infoWindow[i].open(map, marker[i]);
    currentOpenWindow = infoWindow[i];
  });
}


// initMap関数をグローバルにするための記述
window.initMap = initMap;
