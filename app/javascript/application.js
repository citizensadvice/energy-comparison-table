// Entry point for the build script in your package.json
import initGreedyNav from "./greedy-nav";
import initSupplierTableButton from "./supplier-table";

try {
  initGreedyNav();
  initSupplierTableButton();
} catch (error) {
  document.querySelector("html").classList.add("no-js");
  throw error;
}
