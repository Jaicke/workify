class Event < ApplicationRecord
  belongs_to :work
  belongs_to :created_by, polymorphic: true

  validates :title, :event_date, presence: true
  validates :place, presence: true, unless: -> { online? }
  validates :room_url, presence: true, if: -> { online? }
end
