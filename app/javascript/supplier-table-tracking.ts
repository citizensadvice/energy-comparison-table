const initSupplierTableTracking = (): void => {
    const supplierRow = document.querySelector<HTMLElement>(
        '.gtm-supplier-table-row'
    );
    const supplierLink = supplierRow?.querySelector<HTMLElement>('link');

    if (supplierLink && supplierRow) {
        supplierLink.addEventListener('click', () => {
            const supplier = supplierRow.querySelector<HTMLElement>('.supplier-table__name');
            const supplierText = supplier?.innerText;

            window.dataLayer.push({
                event: 'supplierMoreDetailsSelection',
                supplier_name: supplierText
            });
        });
    }
};

export default initSupplierTableTracking;
