document.addEventListener("DOMContentLoaded", function () {
  const checkCommandDialog = setInterval(() => {
    const commandDialog = document.querySelector(".quick-input-widget");
    if (commandDialog) {
      // Create an DOM observer to 'listen' for changes in element's attribute.
      const observer = new MutationObserver((mutations) => {
        mutations.forEach((mutation) => {
          if (
            mutation.type === "attributes" &&
            mutation.attributeName === "style"
          ) {
            if (commandDialog.style.display === "none") {
              handleEscape();
            } else {
              // If the .quick-input-widget element (command palette) is in the DOM
              // but no inline style display: none, show the backdrop blur.
              setBlur();
            }
          }
        });
      });

      observer.observe(commandDialog, { attributes: true });

      // Clear the interval once the observer is set
      clearInterval(checkCommandDialog);
    } else {
      console.log("Command dialog not found yet. Retrying...");
    }
  }, 500); // Check every 500ms

  const checkActivityBar = setInterval(() => {
    const activitybar = document.querySelector(".part.activitybar");
    if (activitybar) {
      const x = document.querySelector("html");
      console.log("eeeeeeeeeeeeeeeeee")
      x.setAttribute("id", "window");
      // Selecciona todos los elementos <li> dentro del <ul>
      const listItems = document.querySelectorAll(
        ".actions-container .action-item.icon"
      );

      // Crea un observador para escuchar cambios en el atributo aria-selected de los elementos <li>
      const observer = new MutationObserver((mutations) => {
        mutations.forEach((mutation) => {
          if (
            mutation.type === "attributes" &&
            mutation.attributeName === "aria-selected"
          ) {
            const anySelected = Array.from(listItems).some(
              (li) => li.getAttribute("aria-selected") === "true"
            );

            if (anySelected) {
              activitybar.classList.remove("activity-shadow");
            } else {
              activitybar.classList.add("activity-shadow");
            }
          }
        });
      });

      // Observa cambios en los atributos de cada <li>
      listItems.forEach((item) => {
        observer.observe(item, { attributes: true });
      });

      // Llama a la función para establecer el estado inicial
      activitybar.classList.add("activity-shadow");

      // Limpiar el intervalo una vez que se establece el observador
      clearInterval(checkActivityBar);
    } else {
      console.log("activitybar no encontrado todavía. Reintentando...");
    }
  }, 500); // Verificar cada 500ms

  // Execute when command palette was launched.
  document.addEventListener("keydown", function (event) {
    if ((event.metaKey || event.ctrlKey) && event.key === "p") {
      event.preventDefault();
      setBlur();
    } else if (event.key === "Escape" || event.key === "Esc") {
      event.preventDefault();
      handleEscape();
    }
  });

  // Ensure the escape key event listener is at the document level
  document.addEventListener(
    "keydown",
    function (event) {
      if (event.key === "Escape" || event.key === "Esc") {
        handleEscape();
      }
    },
    true
  );

  // Remove the backdrop blur from the DOM when esc key is pressed.
  function handleEscape() {
    const element = document.getElementById("command-blur");
    if (element) {
      element.click();
    }
  }

  function setBlur() {
    const targetDiv = document.querySelector(".monaco-workbench");

    // Remove existing element if it already exists
    const existingElement = document.getElementById("command-blur");
    if (existingElement) {
      existingElement.remove();
    }

    // Create and configure the new element
    const newElement = document.createElement("div");
    newElement.setAttribute("id", "command-blur");

    newElement.addEventListener("click", function () {
      newElement.remove();
    });

    // Append the new element as a child of the targetDiv
    targetDiv.appendChild(newElement);
  }

});
