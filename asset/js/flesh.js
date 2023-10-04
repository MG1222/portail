export const flesh = () => {
    document.querySelectorAll('.bnt-close').forEach((button) => {
        button.addEventListener('click', function(event) {
            event.target.parentElement.classList.add('flash-message-out');
            setTimeout(function() {
                event.target.parentElement.remove();
            }, 500); // 500ms = 0.5s
        });
    });
};
