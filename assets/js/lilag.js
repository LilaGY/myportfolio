function sendMail() {

    // get fields values to check if not empty
    var name = document.getElementById('name').value;
    var email = document.getElementById('email').value;
    var message = document.getElementById('message').value;

    if (name.length && email.length && message.length) {
        $.post('send.php', $('#mailform').serialize());
        openModal();
    }

}

function openModal() {
    
    // Get the modal
    var modal = document.getElementById('myModal');

    // Display the modal
    modal.style.display = "block";

    // Get the <span> element that closes the modal
    var span = document.getElementsByClassName("close")[0];
        
    // When the user clicks on <span> (x), close the modal
    span.onclick = function() {
        modal.style.display = "none";
    }

    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }

}