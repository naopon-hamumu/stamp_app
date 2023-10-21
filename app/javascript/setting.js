function setBackgroundImage() {
    var backgroundImageUrl = "/assets/background.webp"; // 画像のパスを指定

    // 背景画像を設定
    document.body.style.backgroundImage = 'url("' + backgroundImageUrl + '")'; // 画像のパスを指定

    document.body.style.backgroundAttachment = 'fixed';
    document.body.style.backgroundSize = 'cover'; // 画像をカバーするように表示
    document.body.style.backgroundRepeat = 'no-repeat';
}

// 伝統的なDOM読み込み完了イベント
document.addEventListener('DOMContentLoaded', setBackgroundImage);

// Turboのナビゲーションイベント
document.addEventListener('turbo:render', setBackgroundImage);
