var NOTIFICATIONS = (function(notifications){
  'use strict'

  var readNotification = function(notification){
    let notificationId = notification[0].getAttribute('data-id')
    let namespace = notification[0].getAttribute('data-recipient-type') == 'Student::User' ? 'student' : 'teacher'
    let read = toBoolean(notification[0].getAttribute('data-read'))

    if (namespace && !read){
      $.ajax({
        url: `${location.origin}/${namespace}/notifications/${notificationId}/read`,
        type: 'put'
      })
    }
  }

  var markNotificationAsRead = function(){
    $('body').on('click', '.notification-card', function(){
      readNotification($(this))
    })
  }

  var markAllAsRead = function(){
    $('body').on('click', '.notification-icon', function(){
      $('.notification-card').each(function(){
        readNotification($(this))
      });
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
