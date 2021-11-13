class DiscussionAnswer < ApplicationRecord
  paginates_per 8

  belongs_to :discussion
  belongs_to :created_by, polymorphic: true

  validates :content, presence: true
end
