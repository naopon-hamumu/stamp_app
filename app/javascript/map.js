// google_maps_initializer.js

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
    center: {lat: 40.7828, lng:-73.9653},
    zoom: 12,
  });

  const marker = new google.maps.Marker({
    position: {lat: 40.7828, lng:-73.9653},
    map: map
  });
}

window.initMap = initMap;  // グローバルスコープに関数をエクスポートします。
