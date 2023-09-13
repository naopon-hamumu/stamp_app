export const MapShow = {
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
      } else {
          console.error("Element with ID:", elementId, "not found.");
      }
  }
}
