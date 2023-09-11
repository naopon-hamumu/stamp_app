document.addEventListener('turbo:load', function() {
  const mapContainers = document.querySelectorAll('[data-controller="map-container"]');
  mapContainers.forEach((container) => {
    initMap(container);
  });
});

function initMap(containerElement) {
  const geocoder = new google.maps.Geocoder();

  const mapElement = containerElement.querySelector('.map');
  const map = new google.maps.Map(mapElement, {
    center:  {lat: 35.6803997, lng:139.7690174},  //東京
    zoom: 15,
  });

  const marker = new google.maps.Marker({
    position: {lat: 40.7828, lng: -73.9653},
    map: map,
    draggable: true
  });

  containerElement.mapInstance = map;
  containerElement.geocoderInstance = geocoder;
  containerElement.markerInstance = marker;
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

  // マーカーのドロップ（ドラッグ終了）時のイベント
  google.maps.event.addListener(marker, 'dragend', function(ev){
    containerElement.querySelector('.lat').value = ev.latLng.lat();
    containerElement.querySelector('.lng').value = ev.latLng.lng();
  });
}

window.initMap = initMap;
window.codeAddress = codeAddress;
