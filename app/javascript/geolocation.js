import Swal from "sweetalert2";

document.addEventListener("turbo:load", function() {
  const buttons = document.querySelectorAll('[id^="get-location-btn-"]');

  buttons.forEach(button => {
    button.addEventListener('touchend', function() {
      const ids = button.id.split('-').slice(-2);
      const stampRallyId = ids[0];
      const stampId = ids[1];
      getLocationAndDisplayStamps(stampRallyId, stampId);
    }, false);

    button.addEventListener('click', function() {
      const ids = button.id.split('-').slice(-2);
      const stampRallyId = ids[0];
      const stampId = ids[1];
      getLocationAndDisplayStamps(stampRallyId, stampId);
    }, false);
  });
});

window.getLocationAndDisplayStamps = function(stampRallyId, stampId) {
  Swal.fire({
    title: '位置情報取得🐹',
    text: 'しばらくお待ちください...',
    showLoaderOnConfirm: true,
    allowOutsideClick: false,
    showConfirmButton: false
  });

  const stampElement = document.querySelector(`[data-stamp-id='${stampId}']`);
  if (!stampElement) {
    Swal.fire('エラー', 'スタンプのデータが見つかりませんでした。', 'error');
    return;
  }
  const stampData = JSON.parse(stampElement.getAttribute('data-stamp'));

  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(position => {
      Swal.close();
      showStampWithinRadius(position, stampRallyId, stampData);
    });
  } else {
    Swal.fire('エラー', 'このブラウザはGeolocationをサポートしていません。', 'error');
  }
};

function showStampWithinRadius(position, stampRallyId, stampData) {
  const userLat = position.coords.latitude;
  const userLng = position.coords.longitude;

  const RADIUS_100M_IN_DEGREES = 100 / (111 * 1000); 
  const RADIUS_1KM_IN_DEGREES = 1 / 111;

  const isWithin100m = Math.abs(stampData.latitude - userLat) <= RADIUS_100M_IN_DEGREES && Math.abs(stampData.longitude - userLng) <= RADIUS_100M_IN_DEGREES;
  const isWithin1km = Math.abs(stampData.latitude - userLat) <= RADIUS_1KM_IN_DEGREES && Math.abs(stampData.longitude - userLng) <= RADIUS_1KM_IN_DEGREES;

  if (isWithin100m) {
    saveStampToParticipantsStamp(stampRallyId, stampData);
  } else if (isWithin1km) {
    Swal.fire('情報', '近く（1km以内）にスタンプがあります！', 'info');
  } else {
    Swal.fire('情報', '近くにスタンプは見つかりませんでした。', 'info');
  }
}

function saveStampToParticipantsStamp(stampRallyId, stamp) {
  fetch(`/stamp_rallies/${stampRallyId}/participants_stamps`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    },
    body: JSON.stringify({
      stamp_id: stamp.id
    })
  })
  .then(response => response.json())
  .then(data => {
    if (data.status !== "success") {
      Swal.fire('エラー', `スタンプの保存エラー: ${data.message}`, 'error');
    } else {
      Swal.fire({
        title: "スタンプをゲットしました！",
        text: stamp.name,
        imageUrl: stamp.sticker.url,
        imageWidth: 200,
        imageHeight: 200,
        imageAlt: 'Stamp Image',
        showConfirmButton: true
      });
    }
  });
}
