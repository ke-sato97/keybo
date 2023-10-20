// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import 'flowbite';
import "@fortawesome/fontawesome-free"

// autocomplete.js ファイルの読み込み
// import "./autocomplete";
document.addEventListener("turbo:load", function() {
  const keyboardSearch = document.querySelector("#keyboard_search");
  const keyboardResults = document.querySelector("#keyboard_results");

  if (keyboardSearch) {
    keyboardSearch.addEventListener("input", function() {
      const searchTerm = keyboardSearch.value; // 入力をそのまま使用

      if (searchTerm.length >= 3) {
        fetch(`/keyboards?search=${encodeURIComponent(searchTerm)}`, { headers: { accept: "application/json" } })
          .then(response => response.json())
          .then(data => {
            keyboardResults.innerHTML = "";
            data.slice(0, 10).forEach(name => { // 最大5個の結果を表示
              const p = document.createElement("p");
              p.classList.add("truncate", "border-2", "py-2", "border-slate-400", "text-slate-700", "hover:bg-slate-100");
              p.setAttribute("data-text", name);
              p.textContent = name.substring(0, 35); // 最初の20文字を表示
              p.addEventListener("click", function() {
                keyboardSearch.value = p.getAttribute("data-text"); // 完全なテキストを挿入
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
