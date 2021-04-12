$(document).on('ready turbolinks:load', function(){

  //image preview
  $('#teacher_user_avatar').on('change', function(){
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
    $("#teacher_user_avatar").click()
  })

  $('.avatar-preview').on('click', function(){
     $("#teacher_user_avatar").click()
  })

})
