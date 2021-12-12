var NOTIFICATIONS = (function(notifications){
  'use strict'

  var markNotificationAsRead = function(){
    $('body').on('click', '.notification-card', function(){
      let notificationId = $(this).find('input').val()
      let namespace = location.pathname.includes('student') ? 'student' : 'teacher'

      $.ajax({
        url: `http://${location.host}/${namespace}/notifications/${notificationId}/read`,
        type: 'put',
      })
    })
  }

  var notifications = {
    init: function(){
      markNotificationAsRead()
    }
  }

  return notifications
}(NOTIFICATIONS || {}))


$(document).on('ready turbolinks:load', function(){
  NOTIFICATIONS.init()
})
