import Swal from "sweetalert2";

document.addEventListener("turbo:load", function() {

  window.getLocationAndDisplayStamps = function(stampRallyId) {
    const cardElement = document.querySelector(`[data-id='${stampRallyId}']`);
    const stampsData = JSON.parse(cardElement.getAttribute('data-stamps'));

    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(position => {
        showStampsWithinRadius(position, stampRallyId, stampsData);
      });
    } else {
      Swal.fire('エラー', 'このブラウザはGeolocationをサポートしていません。', 'error');
    }
  }
});

function showStampsWithinRadius(position, stampRallyId, stampsData) {
  const userLat = position.coords.latitude;
  const userLng = position.coords.longitude;

  const RADIUS_100M_IN_DEGREES = 100 / (111 * 1000); 
  const RADIUS_1KM_IN_DEGREES = 1 / 111;

  const stampsWithin100m = stampsData.filter(stamp => {
    const latDistance = Math.abs(stamp.latitude - userLat);
    const lngDistance = Math.abs(stamp.longitude - userLng);
    return latDistance <= RADIUS_100M_IN_DEGREES && lngDistance <= RADIUS_100M_IN_DEGREES;
  });

  const stampsWithin1km = stampsData.filter(stamp => {
    const latDistance = Math.abs(stamp.latitude - userLat);
    const lngDistance = Math.abs(stamp.longitude - userLng);
    return latDistance <= RADIUS_1KM_IN_DEGREES && lngDistance <= RADIUS_1KM_IN_DEGREES;
  });

  let alreadyGotStamps = stampsData.filter(stamp => stamp.got);

  if (stampsWithin100m.length) {
    if (stampsWithin100m[0].got) {
      Swal.fire('注意', `あなたは既にスタンプ「${stampsWithin100m[0].name}」を取得しています！`, 'warning');
    } else {
      saveStampToParticipantsStamp(stampRallyId, stampsWithin100m[0]);
    }
  } else if (stampsWithin1km.length) {
    Swal.fire('情報', '近く（1km以内）にスタンプがあります！', 'info');
    if (alreadyGotStamps.length) {
      Swal.fire('情報', `あなたは以下のスタンプを既に取得しています: ${alreadyGotStamps.map(stamp => stamp.name).join(", ")}`, 'info');
    }
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
        confirmButtonText: 'OK'
      });
    }
  });
}
