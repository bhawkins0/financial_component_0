const form = document.getElementById('forgotPassword');
form.addEventListener('submit', resetPassword);

function resetPassword(){
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