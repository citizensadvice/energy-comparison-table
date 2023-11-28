// Entry point for the build script in your package.json
import initHeader from '@citizensadvice/design-system/lib/header';
import initGreedyNav from "./greedy-nav";
import initSupplierTableButton from "./supplier-table";
import initSupplierTableTracking from "./supplier-table-tracking";

try {
  // Initialise design-system modules first
  initHeader();
  initGreedyNav();

  // Initialise application modules
  initSupplierTableButton();

  // Initialise tracking modules
  initSupplierTableTracking();
} catch (error) {
  document.querySelector("html").classList.add("no-js");
  throw error;
}
