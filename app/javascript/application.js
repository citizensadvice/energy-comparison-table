// Entry point for the build script in your package.json
import initHeader from '@citizensadvice/design-system/lib/header';
import initGreedyNav from "./greedy-nav";
import initSupplierTableButton from "./supplier-table";

try {
  initHeader();
  initGreedyNav();
  initSupplierTableButton();
} catch (error) {
  document.querySelector("html").classList.add("no-js");
  throw error;
}
