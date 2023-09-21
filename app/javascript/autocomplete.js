document.addEventListener("turbo:load", function() {
  const keyboardResults = document.querySelector("#keyboard_results");
  const autocompleteResults = document.querySelector("#autocomplete_results");

  if (keyboardSearch) {
    keyboardSearch.addEventListener("input", function() {
      const searchTerm = keyboardSearch.value;
      console.log(searchTerm)

      if (searchTerm.length >= 3) {
        fetch(`/keyboards?search=${searchTerm}`, { headers: { accept: "application/json" } })
          .then(response => response.json())
          .then(data => {
            keyboardResults.innerHTML = "";
            autocompleteResults.innerHTML = ""; // オートコンプリートの結果をクリア
            data.forEach(name => {
              const li = document.createElement("li");
              li.textContent = name;
              li.addEventListener("click", function() {
                keyboardSearch.value = name;
                keyboardResults.innerHTML = "";
              });
              autocompleteResults.appendChild(li); // オートコンプリートの結果を追加
            });
          });
      } else {
        keyboardResults.innerHTML = "";
        autocompleteResults.innerHTML = ""; // オートコンプリートの結果をクリア
      }
    });
  }
}):
