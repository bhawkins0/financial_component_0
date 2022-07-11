const form = document.getElementById('forgotPassword');
form.addEventListener('submit', validateEmail);

const $info = $("#change_password_alert");

function validateEmail(event) {
    event.preventDefault();
    const email = document.getElementById("email_box");
    
    if (email.value != ""){
        if (!validEmail(email.value)) {
            $info.text("");
            $info.text("Please enter a valid email address.");
            return;
        } 
        else{
            $.ajax({
                beforeSend: function(xhr) {
                xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
                },
                url: "/reset_password",
                type: "POST",
                data: {
                query_email: document.getElementById("email_box").value
                }
            });
        };
    };
}

function validEmail(email){
    var re = /\S+[^\s][@][^\s]\S+[^\s][\.]\S{3}/;
    return re.test(email);
};