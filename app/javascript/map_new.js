// マップの初期化関数
function initializeStampRallyMap() {
  console.log("Initialize function called");
  if (document.querySelector('.stamp-rally-new-page')) {
      console.log("stamp-rally-new-page detected");
      const mapContainers = document.querySelectorAll('[data-controller="map-container"]');
      mapContainers.forEach((container) => {
          console.log("Initializing map for container", container);
          const lat = parseFloat(container.querySelector('.lat').value) || 43.9965;
          const lng = parseFloat(container.querySelector('.lng').value) || 144.2305;
          initMap(container, lat, lng);
      });
  }
}

function initMap(containerElement, initialLat = 43.9965, initialLng = 144.2305) {
  const geocoder = new google.maps.Geocoder();

  const mapElement = containerElement.querySelector('.map');
  const map = new google.maps.Map(mapElement, {
      center: {lat: initialLat, lng: initialLng},
      zoom: 15,
  });

  const marker = new google.maps.Marker({
      position: {lat: initialLat, lng: initialLng},
      map: map,
      draggable: true
  });

  containerElement.mapInstance = map;
  containerElement.geocoderInstance = geocoder;
  containerElement.markerInstance = marker;

  // マーカーのドロップ（ドラッグ終了）時のイベント
  google.maps.event.addListener(marker, 'dragend', function(ev){
      containerElement.querySelector('.lat').value = ev.latLng.lat();
      containerElement.querySelector('.lng').value = ev.latLng.lng();
  });
}

function codeAddress(containerElement) {
  const geocoder = containerElement.geocoderInstance;
  const map = containerElement.mapInstance;
  const marker = containerElement.markerInstance;

  let inputAddress = containerElement.querySelector('.address').value;

  geocoder.geocode({ 'address': inputAddress }, function(results, status) {
      if (status == 'OK') {
          map.setCenter(results[0].geometry.location);
          marker.setPosition(results[0].geometry.location);

          containerElement.querySelector('.lat').value = results[0].geometry.location.lat();
          containerElement.querySelector('.lng').value = results[0].geometry.location.lng();
      } else {
          alert('該当する結果がありませんでした：' + status);
      }
  });
}

window.initMap = initMap;
window.codeAddress = codeAddress;

// DOMContentLoadedイベントのリスナー
document.addEventListener('DOMContentLoaded', function() {
  console.log("DOMContentLoaded event triggered");
  initializeStampRallyMap();
});

// turbo:loadイベントのリスナー
document.addEventListener('turbo:render', function() {
  console.log("turbo:load event triggered");
  initializeStampRallyMap();
});
