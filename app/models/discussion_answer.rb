class DiscussionAnswer < ApplicationRecord
  paginates_per 8

  belongs_to :discussion
  belongs_to :created_by, polymorphic: true

  has_many :likes, foreign_key: :likeable_id

  validates :content, presence: true
end
