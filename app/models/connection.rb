class Connection < ApplicationRecord
  enum status: { pending: 0, declined: 1, accepted: 2 }

  belongs_to :student, class_name: 'Student::User'
  belongs_to :teacher, class_name: 'Teacher::User'

  has_many :notifications, as: :notifiable, dependent: :destroy

  after_create :create_notification

  private

  def create_notification
    NotificationService.create!(student, teacher, :sent, self)
  end
end
