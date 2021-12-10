class Notification < ApplicationRecord
  enum action: [
    :created,
    :closed,
    :confirmed,
    :approved,
    :answered,
    :accepted,
    :declined
  ]

  belongs_to :user, polymorphic: true
  belongs_to :recipient, polymorphic: true
  belongs_to :notifiable, polymorphic: true
end
