// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import "@fortawesome/fontawesome-free"

// import "./dropdown";
// // autocomplete.js ファイルの読み込み
// import "./autocomplete";
import "./ranks.js";

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


document.addEventListener("turbo:load", function () {
  const button = document.getElementById("dropdown_button");
  const dropdown = document.getElementById("dropdown");

  if (!button){ return false;}
  button.addEventListener("click", function () {
    if (dropdown.style.display === "none") {
      dropdown.style.display = "block";
    } else {
      dropdown.style.display = "none";
    }
  });

  document.addEventListener("click", function (event) {
    if (event.target !== button) {
      dropdown.style.display = "none";
    }
  });
});
