document.addEventListener("turbo:load", function() {
  // 既に取得したスタンプのIDを保持する配列
  window.alreadyAcquiredStamps = [];

  window.getLocationAndDisplayStamps = function(stampRallyId) {
      if (navigator.geolocation) {
          navigator.geolocation.getCurrentPosition(position => {
              showStampsWithinRadius(position, stampRallyId);
          });
      } else {
          alert("このブラウザはGeolocationをサポートしていません。");
      }
  }
});

function showStampsWithinRadius(position, stampRallyId) {
  const userLat = position.coords.latitude;
  const userLng = position.coords.longitude;
  const RADIUS_3KM = 3/111; 

  const stampsWithin3km = stampsData.filter(stamp => {
      return (Math.abs(stamp.latitude - userLat) <= RADIUS_3KM) && (Math.abs(stamp.longitude - userLng) <= RADIUS_3KM);
  });

  if (stampsWithin3km.length) {
      const targetStampId = stampsWithin3km[0].id;
      
      // 既に取得したスタンプのIDを確認
      if (!window.alreadyAcquiredStamps.includes(targetStampId)) {
          saveStampToParticipantsStamp(stampRallyId, targetStampId);
          window.alreadyAcquiredStamps.push(targetStampId);  // 取得したスタンプのIDを配列に追加
      } else {
          alert("このスタンプは既に取得しています。");
      }
      return;
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
          console.error("Error saving stamp to ParticipantsStamp: ", data.message);
      } else {
          alert("スタンプをゲットしました！");
      }
  });
}
