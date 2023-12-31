// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()
import "bootstrap"
import "bootstrap/scss/bootstrap.scss"
//
// console.log("Hello");


document.addEventListener('DOMContentLoaded', function() {
    let flashMessages = document.querySelectorAll('.auto-dismiss');

    flashMessages.forEach(function(message) {
        setTimeout(function() {
            message.style.display = 'none';
        }, 1000); // 5000 milliseconds (5 seconds)
    });
});

someAsyncFunction()
    .then(result => {
        // Handle the successful result here
        console.log(`Success: ${result}`);
    })
    .catch(error => {
        // Handle the error here
        console.error(`Error: ${error.message}`);
    });


