declare global {
    interface Window {
        // eslint-disable-next-line
        dataLayer: Record<string, any>;
    }
}

const initSupplierTableTracking = (): void => {
    const supplierRows = document.querySelectorAll<HTMLElement>(
        '.gtm-supplier-table-row',
    );

    supplierRows?.forEach((row) => {
        const supplierLink = row.querySelector('a');
        const supplier = row.querySelector<HTMLElement>('.supplier-table__name');
        const supplierText = supplier?.innerText;
        supplierLink?.addEventListener('click', () => {
            window.dataLayer.push({
                event: 'supplierDetailsSelection',
                supplier_name: supplierText
            });
        });
    });
};

export default initSupplierTableTracking;
