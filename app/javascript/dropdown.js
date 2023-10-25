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
