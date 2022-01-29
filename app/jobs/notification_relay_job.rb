class NotificationRelayJob < ApplicationJob
  queue_as :default

  def perform(notification)
    html = ApplicationController.render partial: "layouts/shared/new_notification", locals: { notification: notification }, formats: [:html]

    namespace = notification.recipient_type == 'Student::User' ? 'student' : 'teacher'

    html_to_notification_on_menu = ApplicationController.render partial: "#{namespace}/notifications/#{notification.notifiable_type.underscore}/#{notification.action}", locals: { notification: notification }, formats: [:html]
    ActionCable.server.broadcast(
      "notifications:#{notification.recipient_id}",
       html: html,
       html_to_notification_on_menu: html_to_notification_on_menu,
       notifications_not_read_count: notification.recipient.notifications.not_read.count,
       namespace: namespace
    )
  end
end
