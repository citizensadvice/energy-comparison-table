// Entry point for the build script in your package.json
import initSupplierTableButton from "./supplier-table";

try {
  initSupplierTableButton();
} catch (error) {
  document.querySelector("html").classList.add("no-js");
  throw error;
}
