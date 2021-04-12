$(document).on('ready turbolinks:load', function(){
  teacherActive = localStorage.getItem('teacherActive')

  if(!(teacherActive === undefined) && toBoolean(teacherActive)){
    $('.sign').removeClass('sign-student')
    $('#student-tab').removeClass('active')
    $('#student').removeClass('active')
    $('#teacher-tab').addClass('active')
    $('#teacher').addClass('show active')
    $('.sign').addClass('sign-teacher')
  }

  $('#teacher-tab').click(function(){
    $('.sign').removeClass("sign-student")
    $('.sign').addClass("sign-teacher")
    localStorage.setItem('teacherActive', true)
  })

  $('#student-tab').click(function(){
    $('.sign').removeClass("sign-teacher")
    $('.sign').addClass("sign-student")
    localStorage.setItem('teacherActive', false)
  })
})
