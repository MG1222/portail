import {roles, dropDown, toggleForms, alertDelete, documentOptions, checkboxes, changeFormAction} from "./admin.js";
import {changeIcon} from "./icon.js";
import {flesh} from "./flesh.js";
import {sideBar} from "./sideBar.js";

const main = () => {

    if (document.querySelector('.sidebar')) {
        sideBar();
    }


    if (document.querySelector('.eye')) {
        changeIcon();
    }

    if (document.querySelector('.success') || document.querySelector('.error')) {
        flesh();
    }

    if (document.querySelector('.form')) {
        roles();
    }

    if (document.querySelector('.form-new-user')) {
        changeFormAction();
    }

    if (document.querySelector('.dropdown-toggle')) {
        dropDown();
    }

    if (document.querySelector('.toggle-form')) {
        toggleForms();
    }

    if (document.querySelector('.btn-delete')) {
        alertDelete();
    }

    if (document.querySelector('#checkbox_user') || document.querySelector('#checkbox_admin')) {
        documentOptions();
    }

    if (document.querySelector('#checkbox_admin') || document.querySelector('#checkbox_user')) {
        checkboxes();
    }

}

addEventListener('DOMContentLoaded', main);
