// Entry point for the build script in your package.json
import initGreedyNav from "./greedy-nav";
import initSupplierTableButton from "./supplier-table";
import initHeader from '@citizensadvice/design-system/lib/header';

try {
  initGreedyNav();
  initSupplierTableButton();
  initHeader();
} catch (error) {
  document.querySelector("html").classList.add("no-js");
  throw error;
}
