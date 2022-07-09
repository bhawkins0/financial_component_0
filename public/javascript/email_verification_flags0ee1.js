$('#fcModal_1_Body').text("There is already an account associated with this email address.");
$('#fcModal_1').modal("show");
$("#fcModal_1").on('hide.bs.modal', function(){
  window.location = "/sign_up";
});