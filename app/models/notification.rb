class Notification < ApplicationRecord
  enum action: [
    :created,
    :closed,
    :confirmed,
    :approved,
    :answered,
    :accepted,
    :declined,
    :sent
  ]

  belongs_to :user, polymorphic: true
  belongs_to :recipient, polymorphic: true
  belongs_to :notifiable, polymorphic: true

  scope :not_read, -> { where(read: false) }

  after_commit -> { NotificationRelayJob.perform_later(self) }, on: :create
end
