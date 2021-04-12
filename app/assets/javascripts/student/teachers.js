var TEACHERS = (function(teachers){
  'use strict'

  var delayedSearch = function(){
    var timer;

    $('#search-teacher-input').on('keyup', function(){
      clearTimeout(timer);
      timer = setTimeout(() => {
        $(this).closest('form').submit()
      }, 800);
    })
  }

  var sendConnection = function(){
    $('.connect').on('click', function(){
      const buttonConnect = $(this)
      const teacherId = $(this).attr('data-id')

      $.ajax({
        url: `teachers/${teacherId}/send_connection`,
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
      delayedSearch()
      sendConnection()
    }
  }

  return teachers
}(TEACHERS || {}))

$(document).on('ready turbolinks:load', function(){
  TEACHERS.init()
})
