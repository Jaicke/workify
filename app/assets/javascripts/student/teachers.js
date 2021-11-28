var TEACHERS = (function(teachers){
  'use strict'

  var sendConnection = function(){
    $('.connect').on('click', function(){
      let buttonConnect = $(this)
      let teacherId = $(this).attr('data-id')

      $.ajax({
        url: `http://${location.host}/student/teachers/${teacherId}/send_connection`,
        dataType: 'html',
        type: 'post',
        success: function(){
          Swal.fire({
            title: 'Sucesso!',
            text: 'Seu convite foi enviado para o e-mail do(a) professor(a)',
            type: 'success',
            confirmButtonText: 'Ok'
          })
          buttonConnect.html('Pendente');
          buttonConnect.prop('disabled', true);
          buttonConnect.addClass('pending');
        }
      })
    })
  }

  var teachers = {
    init: function(){
      sendConnection()
    }
  }

  return teachers
}(TEACHERS || {}))

$(document).on('ready turbolinks:load', function(){
  TEACHERS.init()
})
