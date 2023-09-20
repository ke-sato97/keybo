document.addEventListener("turbo:load", function() {
  const keyboardSearch = document.querySelector("#keyboard_search");
  const keyboardResults = document.querySelector("#keyboard_results");

  if (keyboardSearch) {
    keyboardSearch.addEventListener("input", function() {
      const searchTerm = keyboardSearch.value;

      if (searchTerm.length >= 3) {
        fetch(`/keyboards?search=${searchTerm}`, { headers: { accept: "application/json" } })
          .then(response => response.json())
          .then(data => {
            keyboardResults.innerHTML = "";
            data.forEach(name => {
              const li = document.createElement("li");
              li.textContent = name;
              li.addEventListener("click", function() {
                keyboardSearch.value = name;
                keyboardResults.innerHTML = "";
              });
              keyboardResults.appendChild(li);
            });
          });
      } else {
        keyboardResults.innerHTML = "";
      }
    });
  }
});
