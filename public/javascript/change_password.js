const form = document.getElementById('Password');
form.addEventListener('submit', validatePassword);

const $info = $("#change_password_alert");

function password_show_hide(this_id) {
    if (this_id === "current_password_box_toggle") {
        var x = document.getElementById("current_password_box");
        var show_eye = document.getElementById("show_eye");
        var hide_eye = document.getElementById("hide_eye");
    } else if (this_id === "password_box_toggle") {
        var x = document.getElementById("password_box");
        var show_eye = document.getElementById("show_eye_2");
        var hide_eye = document.getElementById("hide_eye_2");
    } else {
        var x = document.getElementById("password_confirmation_box");
        var show_eye = document.getElementById("show_eye_3");
        var hide_eye = document.getElementById("hide_eye_3");
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
    
    new_pwd = $("#password_box").val();
    new_pwd_confirm = $("#password_confirmation_box").val();

    $info.text("");
    if (new_pwd != new_pwd_confirm) {
        $info.text("Please ensure that the passwords match.");
    };
};

function validatePassword(event) {
    event.preventDefault();

    current_pwd = $("#current_password_box").val();
    new_pwd = $("#password_box").val();
    new_pwd_confirm = $("#password_confirmation_box").val();
    
    flag = 0;

    if (new_pwd != new_pwd_confirm){
        $('#fcModal_1_Body').text("Please ensure that the passwords match.");
        $('#fcModal_1').modal("show");
        flag = 1;
        return;
    };

    if (flag == 1) {
        return;
    }

    if (new_pwd != ""){
        if (!validPassword(new_pwd)) {
            $info.text("Please enter a valid password. Passwords must include at least one capital letter, at least one number and at least one special character.");
            return;
        } 
        else{
            verify_password(current_pwd,new_pwd,new_pwd_confirm);
        };
    };
}

function validPassword(pwd){
    var re = /^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{6,16}$/; //at least one number and at least one special character
    return re.test(pwd);
};

function verify_password(current_pwd,new_pwd,new_pwd_confirm){
    console.log("running")
    $.ajax({
                beforeSend: function(xhr) {
                xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
                },
                url: "/verify_password",
                type: "POST",
                data: {
                curr: current_pwd,
                new: new_pwd,
                confirm: new_pwd_confirm
                }
            });
    };