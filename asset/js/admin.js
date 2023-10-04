export const toggleForms = () => {
    // Select all the toggle buttons
    const buttons = document.querySelectorAll('.toggle-form');

    buttons.forEach(button => {
        button.addEventListener('click', function() {
            // Select the corresponding form row
            console.log(this.parentElement.parentElement.nextElementSibling);
            const formRow = this.parentElement.parentElement.nextElementSibling;
            formRow.classList.toggle('hidden');
        });
    });
};

export const changeFormAction = () => {
    const form = document.querySelector('form');
    const dropdown = document.querySelector('#role_id');

    dropdown.addEventListener('change', function() {
        const selectedOptionText = dropdown.options[dropdown.selectedIndex].innerText;

        if (selectedOptionText === 'Utilisateur') {

            form.action = form.action.replace(/\/admin\/[^\/]+$/, '/admin/store-user');

            const input = document.querySelector('#project_name');
            if (input) {
                input.remove();
            }
        } else {
            form.action = form.action.replace(/\/admin\/[^\/]+$/, '/admin/store-admin');

            const projectContainer = document.querySelector('#project_container');
            if (projectContainer) {
                projectContainer.innerHTML = '<input type="text" name="project_name" placeholder="* Project" required>';
            }
        }
    });
};





const addOptionsToDropdown = (dropdown, options) => {
    dropdown.innerHTML = '';
    options.forEach(option => {
        const optionElement = document.createElement('option');
        optionElement.value = option.id;
        optionElement.text = option.name;
        dropdown.appendChild(optionElement);
    });
};



export const documentOptions = () => {
    const checkBoxUser = document.querySelector('#checkbox_user');
    const checkBoxAdmin = document.querySelector('#checkbox_admin');
    const userIdDropdown = document.querySelector('#user_id');
    const adminIdDropdown = document.querySelector('#admin_id');
    const projectIdDropdown = document.querySelector('#project_id');

    const handleCheckboxChange = () => {
        if (checkBoxUser.checked) {
            console.log('userIdDropdown')
            // Listen for changes in the user_id dropdown
            userIdDropdown.addEventListener('change', () => {
                const id = userIdDropdown.value;
                const endpointUrl = `./admin/getProjects?user_id=${id}`;

                // Fetch the projects for the selected user
                fetch(endpointUrl)
                    .then(response => response.json())
                    .then(projects => {
                        // Clear the current options from the project_id dropdown if it's the user dropdown
                        if (projectIdDropdown.parentNode === userIdDropdown.parentNode) {
                            projectIdDropdown.innerHTML = '';
                        }

                        if (projects.length > 0) {
                            addOptionsToDropdown(projectIdDropdown, projects);
                        } else {
                            projectIdDropdown.innerHTML = '<option value="" selected="selected" hidden="hidden">Aucun projet disponible</option>';

                        }
                    });
            });
        } else {
            console.log('adminIdDropdown');
            // Listen for changes in the admin_id dropdown
            adminIdDropdown.addEventListener('change', () => {
                const id = adminIdDropdown.value;
                const endpointUrl = `./admin/getProjects?admin_id=${id}`;
                console.log(endpointUrl);

                // Fetch the projects for the selected admin
                fetch(endpointUrl)
                    .then(response => response.json())
                    .then(projects => {
                        // Clear the current options from the project_id dropdown if it's the admin dropdown
                        if (projectIdDropdown.parentNode === adminIdDropdown.parentNode) {
                            projectIdDropdown.innerHTML = '';
                        }

                        if (projects.length > 0) {
                            addOptionsToDropdown(projectIdDropdown, projects);
                        } else {
                            projectIdDropdown.innerHTML = '<option value="" selected="selected" hidden="hidden">Aucun projet disponible</option>';

                        }
                    });
            });
        }
    };

    handleCheckboxChange(); // Call the function to check the initial state of the checkbox

    // Listen for changes in the checkbox
    checkBoxUser.addEventListener('change', handleCheckboxChange);
    checkBoxAdmin.addEventListener('change', handleCheckboxChange);
};


/**
 * dropdown menu admin
 */

export const dropDown = () => {

    const dropdownToggle = document.querySelector('.dropdown-toggle');

    dropdownToggle.addEventListener('click', (event) => {
        const dropdownMenu = document.querySelector('.dropdown-menu');

        dropdownMenu.classList.toggle('hidden');


    });



}

/**
 * Display the role input if the user selects the "New role" option
 */
export const roles = () => {
    // Select the role dropdown
    const form = document.querySelector('.form');
    const role_new_input = document.querySelector('#role_new_input');
    if (role_new_input) {
        let select = document.querySelector('#role_id');
        const role_new_input = document.querySelector('#role_new_input');
        const type_project = document.querySelector('#type_project');

        role_new_input.style.display = 'none';
        type_project.style.display = 'none';

        select.addEventListener('change', function () {
            // Get the selected role
            let role = select.value;

            if (role === 'role_new_option') {
                role_new_input.style.display = 'block';
                type_project.style.display = 'block';
            } else {
                role_new_input.style.display = 'none';
                type_project.style.display = 'none';
            }
        });
    }
}

/**
 * Confirm the deletion of a user/admin/project
 */
export const alertDelete = () => {

    const btnDelete = document.querySelectorAll('.btn-delete');
    const popupContainers = document.querySelectorAll('.popup-container');

// Fonction pour afficher le popup de confirmation de suppression
    btnDelete.forEach(function(btn) {
        btn.addEventListener('click', function(e) {
            e.preventDefault();
            console.log(this);
            const userId = this.getAttribute('data-userid');
            const popupContainer = document.querySelector(`#popup-container-${userId}`);
            popupContainer.classList.remove('hidden');
            popupContainer.classList.add('show');
        });
    });

    popupContainers.forEach(function(popupContainer) {
        const btnCancel = popupContainer.querySelector('.btn-cancel');
        btnCancel.addEventListener('click', function(e) {
            popupContainer.classList.add('hidden');
            popupContainer.classList.remove('show');
        });
    });

}

/**
 * NO USE
 * Confirm the deletion of a document
 */
export const alertDocDelete = () => {

    const btnDelete = document.querySelectorAll('.btn-delete');
    const popupContainers = document.querySelectorAll('.popup-container');

    // Fonction pour afficher le popup de confirmation de suppression
    btnDelete.forEach(function(btn) {
        btn.addEventListener('click', function(e) {
            e.preventDefault();
            console.log(this);
            const documentId = this.getAttribute('data-documentid');
            const popupContainer = document.querySelector(`#popup-container-${documentId}`);
            popupContainer.classList.remove('hidden');
            popupContainer.classList.add('show');
        });
    });

    popupContainers.forEach(function(popupContainer) {
        const btnCancel = popupContainer.querySelector('.btn-cancel');
        btnCancel.addEventListener('click', function(e) {
            popupContainer.classList.add('hidden');
            popupContainer.classList.remove('show');
        });
    });

}



/**
 * Display select of user or admin for a new project
 */
export const checkboxes = () => {
    console.log('test')
    const checkboxAdmin = document.querySelector('#checkbox_admin')
    const checkboxUser = document.querySelector('#checkbox_user')


    checkboxAdmin.addEventListener('change', function () {

        checkboxUser.checked = false;
        const selectAdmin = document.querySelector('#admin_id');
        selectAdmin.classList.remove('hidden');
        const selectUser = document.querySelector('#user_id');
        selectUser.classList.add('hidden');
    });

    checkboxUser.addEventListener('click', function () {
        checkboxAdmin.checked = false;
        const selectUser = document.querySelector('#user_id');
        selectUser.classList.remove('hidden');
        const selectAdmin = document.querySelector('#admin_id');
        selectAdmin.classList.add('hidden');

    });


}
