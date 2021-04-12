// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on('ready turbolinks:load', function(){

  //image preview
  $('#student_user_avatar').on('change', function(){
    var reader = new FileReader()

    reader.onload = function (e) {
        // get loaded data and render thumbnail.
        document.getElementById("image").src = e.target.result
    }

    // read the image file as a data URL.
    reader.readAsDataURL(this.files[0])
    $(this).closest('form').submit()
  })

  $(".avatar-file-btn").click(function(){
    $("#student_user_avatar").click()
  })

  $('.avatar-preview').on('click', function(){
    $("#student_user_avatar").click()
  })

})
