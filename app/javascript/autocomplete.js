document.addEventListener("turbo:load", function() {
  const keyboardSearch = document.querySelector("#keyboard_search");
  const keyboardResults = document.querySelector("#keyboard_results");

  // 検索実行時の処理
  if (keyboardSearch) {
    keyboardSearch.addEventListener("input", function() {
      const searchTerm = keyboardSearch.value;

      if (searchTerm.length >= 3) {
        // 検索結果の処理
        // fetch メソッドを使用して非同期にサーバーにリクエストを送信し、サーバーからの JSON レスポンスを処理。searchパラメータを送信
        fetch(`/keyboards?search=${encodeURIComponent(searchTerm)}`, { headers: { accept: "application/json" } })
          .then(response => response.json())
          .then(data => {
            keyboardResults.innerHTML = "";
            data.slice(0, 10).forEach(name => {
              const p = document.createElement("p");
              p.classList.add("truncate", "border-2", "py-2", "border-slate-400", "text-slate-700", "hover:bg-slate-100");
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
        // 検索結果をクリア
        keyboardResults.innerHTML = "";
      }
    });
  }
});
