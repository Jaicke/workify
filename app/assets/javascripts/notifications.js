var NOTIFICATIONS = (function(notifications){
  'use strict'

  var readNotification = function(notification){
    let notificationId = notification.find('input').val()
    let namespace = location.pathname.includes('student') ? 'student' : 'teacher'

    $.ajax({
      url: `${location.origin}/${namespace}/notifications/${notificationId}/read`,
      type: 'put',
    })
  }

  var markNotificationAsRead = function(){
    $('body').on('click', '.notification-card', function(){
      readNotification($(this))
    })
  }

  var markAllAsRead = function(){
    $('.notification-card').each(function(){
      readNotification($(this))
    });
  }

  var removeNewNotificationAlert = function() {
    $('#new-notification-alert').html('')
  }

  var notifications = {
    init: function(){
      markNotificationAsRead()
      markAllAsRead()
      removeNewNotificationAlert()
    }
  }

  return notifications
}(NOTIFICATIONS || {}))


$(document).on('ready turbolinks:load', function(){
  NOTIFICATIONS.init()
})
