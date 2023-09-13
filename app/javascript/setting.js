document.addEventListener('turbo:load', function() {
    // 背景画像のURLを直接指定
    var backgroundImageUrl = "/assets/background.jpg"; // 画像のパスを指定

    // 背景画像を設定
    document.body.style.backgroundImage = 'url("' + backgroundImageUrl + '")'; // 画像のパスを指定

    document.body.style.backgroundAttachment = 'fixed';
    document.body.style.backgroundSize = 'cover'; // 画像をカバーするように表示
    document.body.style.backgroundRepeat = 'no-repeat';
});
