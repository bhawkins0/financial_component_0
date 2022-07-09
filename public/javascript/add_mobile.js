
  const phoneInputField = document.querySelector("#mobileInput");
  const phoneInput = window.intlTelInput(phoneInputField, {
    utilsScript:
      "https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/utils.js",
  });

  function submitMobile(event) {
    event.preventDefault();
    const recipient = phoneInput.getNumber();
    $.ajax({
              beforeSend: function(xhr) {
                xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
              },
              url: "/verify_mobile",
              type: "POST",
              data: {
                recipient: recipient
              }
            });
  };

  function submitCode(daCode){
    event.preventDefault();
    $.post( '/verify_mobile_code', { code: daCode});
  };
 