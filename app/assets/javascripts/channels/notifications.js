App.notifications = App.cable.subscriptions.create("NotificationsChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
    let notification_count = parseInt(data.notifications_not_read_count) >= 10 ? '+9' : data.notifications_not_read_count
    let namespace = location.pathname.includes('student') ? 'student' : 'teacher'

    if(data.namespace == namespace){
      $('#new-notification-alert').html(data.html);
      $('#notification-count').html(notification_count)
      $('.navigation-notification .notifications-list').prepend(data.html_to_notification_on_menu)
      $('.empty-notification').hide()
    }
  }
});
