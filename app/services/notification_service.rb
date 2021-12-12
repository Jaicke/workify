class NotificationService
  def initialize(user, recipient, action, notifiable)
    @user = user
    @recipient = recipient
    @action = action
    @notifiable = notifiable
  end

  def create!
    Notification.create!(user: @user, recipient: @recipient, action: @action, notifiable: @notifiable)
  end

  def self.create!(user, recipient, action, notifiable)
    new(user, recipient, action, notifiable).create!
  end
end
