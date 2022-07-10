const form = document.getElementById('User');
form.addEventListener('submit', validateUser);

const phoneInputField = document.querySelector("#mobile_box");
const phoneInput = window.intlTelInput(phoneInputField, {
    utilsScript:"https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/utils.js",
});

//const info = document.querySelector(".alert-info");

function password_show_hide(this_id) {
    if (this_id === "password_box_toggle") {
        var x = document.getElementById("password_box");
        var show_eye = document.getElementById("show_eye");
        var hide_eye = document.getElementById("hide_eye");
    } else {
        var x = document.getElementById("password_confirmation_box");
        var show_eye = document.getElementById("show_eye_2");
        var hide_eye = document.getElementById("hide_eye_2");
    };

    hide_eye.classList.remove("d-none");
    if (x.type === "password") {
        x.type = "text";
        show_eye.style.display = "none";
        hide_eye.style.display = "block";
    } else {
        x.type = "password";
        show_eye.style.display = "block";
        hide_eye.style.display = "none";
    }
};

function password_validation(){
    const $result = $("#login_alert");
    const pwd = $("#password_box").val();
    const conf_pwd = $("#password_confirmation_box").val();
    $result.text("");
    if (pwd != conf_pwd) {
        $result.text("Please ensure that the passwords match.");
    };
};

function validateUser(event) {
    console.log("test")
    event.preventDefault();
    const email = document.getElementById("email_box");
    const mobile = document.getElementById("mobile_box");
    var inputs = document.getElementsByTagName("input");
    var flag = 0;
    if ($("#password_box").val() != $("#password_confirmation_box").val()){
        $('#fcModal_1_Body').text("Please ensure that the passwords match.");
        $('#fcModal_1').modal("show");
        flag = 1;
        return;
    };

    if ((mobile.value != '') && (!validMobile(mobile.value))) {
        $('#fcModal_1_Body').text("Please enter a valid phone number.");
        $('#fcModal_1').modal("show");
        flag = 1;
        return;
    };

    if (flag == 1) {
        return;
    }

    for(var i = 0; i < inputs.length; i++){
        if (inputs[i].value == ""){
            if(inputs[i].name == "query_mobile"){
                ;
            }
            else {
                $('#fcModal_1_Body').text("Please ensure all fields are completed. You must include a valid " + inputs[i].name.replace("query_","").replace("_box","").replace("_", " ") + ".");
                $('#fcModal_1').modal("show");
                flag = 1;
                break;
                return;
            };
        };
    }

    if (flag == 1) {
        return;
    }

    if (email.value != ""){
        if (!validEmail(email.value)) {
            $('#fcModal_1_Body').text("Please enter a valid email address.");
            $('#fcModal_1').modal("show");
            return;
        } 
        else{
            create_user();
        };
    };
}

function validEmail(email){
    var re = /\S+[^\s][@][^\s]\S+[^\s][\.]\S{3}/;
    return re.test(email);
};

function validMobile(mobile) {
    var re = /([0-9]{10})/;
    return re.test(mobile);
};

function create_user(){
    $.ajax({
                beforeSend: function(xhr) {
                xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
                },
                url: "/create_user",
                type: "POST",
                data: {
                query_first_name: document.getElementById("first_name_box").value,
                query_last_name: document.getElementById("last_name_box").value,
                query_email: document.getElementById("email_box").value,
                query_password: document.getElementById("password_box").value,
                query_password_confirmation: document.getElementById("password_confirmation_box").value,
                query_mobile: phoneInput.getNumber()
                }
            });
    };