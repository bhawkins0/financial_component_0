$(document).ready(function(){      
  $("#editProfile").click(function(){
    window.location = "/edit_user_profile";
  });
  $("#deleteProfile").click(function(){
    $('#fcModal_1').modal("show");
  });
  $("#confirmDelete").click(function(){
    window.location = "/cancel_user_account";
  });
});