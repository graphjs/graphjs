export default function() {
    // Remove previous overlay
    let previousOverlayItem = document.querySelector('graphjs-overlay');
    previousOverlayItem && previousOverlayItem.parentNode.removeChild(previousOverlayItem);
    document.body.style.overflow = 'auto';
}