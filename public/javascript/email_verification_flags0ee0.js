$('#fcModal_1_Body').text("A verification message has been sent to the email provided. Please verify your email to login once the registration process is complete.");
$('#fcModal_1').modal("show");
$("#fcModal_1").on('hide.bs.modal', function(){
  var x = document.getElementById("mobile_box");
  if (x != undefined){
    if (x.value != undefined){      
        const recipient = phoneInput.getNumber();
        $.ajax({
                      beforeSend: function(xhr) {
                      xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
                    },
                  url: "/validate_mobile",
                  type: "POST",
                  data: {
                      recipient: recipient,
                      flags: 1,
                      query_mobile: phoneInput.getNumber()
                    }
                });
      }
    else{
      window.location.replace("/settings/profile");
    };
  }
  else{
    window.location.replace("/settings/profile");
    };
});