// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import "@fortawesome/fontawesome-free"

import "./autocomplete"
import "./dropdown"
import "./ranks.js"


// autocomplete.js
document.addEventListener("turbo:load", function() {
  const keyboardSearch = document.querySelector("#keyboard_search");
  const keyboardResults = document.querySelector("#keyboard_results");

  if (keyboardSearch) {
    keyboardSearch.addEventListener("input", function() {
      const searchTerm = keyboardSearch.value; // 入力をそのまま使用
      if (searchTerm.length >= 1) {
        fetch(`/keyboards?search=${encodeURIComponent(searchTerm)}`, { headers: { accept: "application/json" } })
          .then(response => response.json())
          .then(data => {
            keyboardResults.innerHTML = "";
            data.slice(0, 10).forEach(name => {
              const p = document.createElement("p");
              p.classList.add("truncate","py-2", "px-3", "text-slate-600", "hover:bg-slate-100");
              p.setAttribute("data-text", name);
              p.textContent = name.substring(0, 35);
              p.addEventListener("click", function() {
                keyboardSearch.value = p.getAttribute("data-text");
                keyboardResults.innerHTML = "";
              });
              keyboardResults.appendChild(p);
            });
          });
      } else {
        keyboardResults.innerHTML = "";
      }
    });
  }
});


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


// ranks.js
document.addEventListener('turbo:load', function () {
  // ここにJavaScriptコードを配置
  const switchRankingLinks = document.querySelectorAll('.switch-ranking');

  switchRankingLinks.forEach(function (link) {
    link.addEventListener('click', function () {
      const targetId = link.getAttribute('data-target');
      const allRankings = document.querySelectorAll('.blind');

      allRankings.forEach(function (ranking) {
        ranking.style.display = 'none';
      });

      const targetRanking = document.querySelector(targetId);
      targetRanking.style.display = 'block';
      console.log(targetRanking)
    });
  });
});
