  const form = document.getElementById('editEmail');
  form.addEventListener('submit', validate_email);
  const info = document.querySelector(".alert-info");

  function validate_email() {
    event.preventDefault();
    const email = document.getElementById("email_box");

    if ((email.value == "" )||(!validEmail(email.value))){
      $('#fcModal_1_Body').text("Please enter a valid email address.");
      $('#fcModal_1').modal("show");
      return;
    }
    else{
        $.ajax({
            beforeSend: function(xhr) {
              xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
            },
            url: "/validate_email",
            type: "POST",
            data: {
              query_email: email.value,
              flags: 1
            }
          });
    };
  };

  function validEmail(email) 
  {
      var re = /\S+@\S+\.\S+/;
      return re.test(email);
  }
