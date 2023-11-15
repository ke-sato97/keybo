// dropdown.js 複数反応する(class="dropdown_button" に反応)
document.addEventListener("turbo:load", function () {
  // ドロップダウンボタンとドロップダウンメニューの要素を取得
  const buttons = document.querySelectorAll(".dropdown_button");
  const dropdowns = document.querySelectorAll(".dropdown");

  // 各ボタンに対してイベントリスナーを設定
  buttons.forEach(function (button, index) {
    const dropdown = dropdowns[index];

    if (!button) { return false; }

    // ボタンがクリックされた時の処理
    button.addEventListener("click", function () {
      if (dropdown.style.display === "none") {
        dropdown.style.display = "block";
      } else {
        dropdown.style.display = "none";
      }
    });

    // ドキュメント全体でクリックされた時の処理
    document.addEventListener("click", function (event) {
      if (event.target !== button) {
        dropdown.style.display = "none";
      }
    });
  });
});
