const MapShow = {
  init: function(elementId, lat, lng) {
      let map;
      let position = { lat: lat, lng: lng };

      // 要素IDを基にマップ要素を取得
      let mapElement = document.getElementById(elementId);

      if (mapElement) {
        map = new google.maps.Map(mapElement, {
            center: position,
            zoom: 15
        });

        let marker = new google.maps.Marker({
            position: position,
            map: map
        });

        // マーカーをクリックしたときにGoogle Mapsにリダイレクトするイベントリスナーを追加
        marker.addListener('click', function() {
            window.location.href = `https://www.google.com/maps/?q=${lat},${lng}`;
        });

      } else {
        console.error("Element with ID:", elementId, "not found.");
      }
  }
};

function initializeMaps() {
  if (document.querySelector('.stamp-rally-show-page')) {
    document.querySelectorAll('[id^="map-show-"]').forEach((mapElement, index) => {
      const stamp = window.stamps[index];
      if (stamp && mapElement) {
        const lat = parseFloat(stamp.latitude);
        const lng = parseFloat(stamp.longitude);

        MapShow.init(mapElement.id, lat, lng);
      }
    });
  }
}

// Turboの読み込みイベントでマップ初期化
document.addEventListener('turbo:load', initializeMaps);

// 通常の読み込みイベントでもマップ初期化
document.addEventListener('DOMContentLoaded', initializeMaps);
