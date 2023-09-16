document.addEventListener("turbo:load", function() {

  window.getLocationAndDisplayStamps = function(stampRallyId) {
    const cardElement = document.querySelector(`[data-id='${stampRallyId}']`);
    const stampsData = JSON.parse(cardElement.getAttribute('data-stamps'));

    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(position => {
        showStampsWithinRadius(position, stampRallyId, stampsData);
      });
    } else {
      alert("このブラウザはGeolocationをサポートしていません。");
    }
  }
});

function showStampsWithinRadius(position, stampRallyId, stampsData) {
  const userLat = position.coords.latitude;
  const userLng = position.coords.longitude;

  const RADIUS_100M_IN_DEGREES = 100 / (111 * 1000); // Convert 100m to degrees.
  const RADIUS_1KM_IN_DEGREES = 1 / 111; // Convert 1km to degrees.

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
      alert(`あなたは既にスタンプ「${stampsWithin100m[0].name}」を取得しています！`);
    } else {
      saveStampToParticipantsStamp(stampRallyId, stampsWithin100m[0].id);
    }
  } else if (stampsWithin1km.length) {
    alert("近く（1km以内）にスタンプがあります！");
    if (alreadyGotStamps.length) {
      alert(`あなたは以下のスタンプを既に取得しています: ${alreadyGotStamps.map(stamp => stamp.name).join(", ")}`);
    }
  } else {
    alert("近くにスタンプは見つかりませんでした。");
  }
}

function saveStampToParticipantsStamp(stampRallyId, stampId) {
  fetch(`/stamp_rallies/${stampRallyId}/participants_stamps`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    },
    body: JSON.stringify({
      stamp_id: stampId
    })
  })
  .then(response => response.json())
  .then(data => {
    if (data.status !== "success") {
      alert(`スタンプの保存エラー: ${data.message}`);
    } else {
      alert("スタンプをゲットしました！");
    }
  });
}
