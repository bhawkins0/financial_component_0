const form = document.getElementById('verifyEmailCode');
form.addEventListener('submit', verify_code);

function validCode(code) 
{
    var re = /([0-9]{4})/;
    return re.test(code);
};

function verify_code() {
  const code = $("#code_box").val();
  event.preventDefault();
  if ((code == "") || !(validCode(code))){
    $('#fcModal_1_Body').text("Please enter a valid code.");
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
            query_email: '',
            code: code,
            flags: 1
          }
        });
  };
};