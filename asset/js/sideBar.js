export const sideBar = () => {
    const btn = document.querySelector('.dropdown-toggle');

    btn.addEventListener('click', () => {

        console.log('click');
        const dropdownMenu = document.querySelector('.dropdown-menu');
        dropdownMenu.classList.toggle('dropdown-menu hidden');


    });
}
