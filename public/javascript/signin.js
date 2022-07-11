
function validEmail(email) 
{
    var re = /\S+[^\s][@][^\s]\S+[^\s][\.]\S{3}/;
    return re.test(email);
};

function validate_email(email){
$.ajax({
            beforeSend: function(xhr) {
            xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
            },
            url: "/validate_email",
            type: "POST",
            data: {
            query_email: email,
            flags: 0
            }
        });
};