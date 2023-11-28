declare global {
    interface Window {
        // eslint-disable-next-line
        dataLayer: Record<string, any>;
    }
}

const initMoreSuppliersTracking = (): void => {
    const showMoreSuppliers = document.querySelector<HTMLElement>(
        '.show_more_button_classes'
    );

    if (showMoreSuppliers) {
        showMoreSuppliers.addEventListener('click', () => {
            window.dataLayer.push({
                event: 'showMoreSuppliers'
            })
        })
    }
};

export default initMoreSuppliersTracking;
