document.addEventListener("turbo:load", function() {
  const keyboardSearch = document.querySelector("#keyboard_search");
  const keyboardResults = document.querySelector("#keyboard_results");

  if (keyboardSearch) {
    keyboardSearch.addEventListener("input", function() {
      const searchTerm = keyboardSearch.value;

      if (searchTerm.length >= 3) {
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
        keyboardResults.innerHTML = "";
      }
    });
  }
});
