class DiscussionAnswer < ApplicationRecord
  paginates_per 8

  belongs_to :discussion
  belongs_to :created_by, polymorphic: true

  has_many :likes, foreign_key: :likeable_id

  validates :content, presence: true

  after_create :create_notification

  private

  def create_notification
    recipients = (discussion.work.members.to_a + discussion.work.all_advisors.to_a) - [created_by]

    recipients.each do |recipient|
      NotificationService.create!(self.created_by, recipient, :answered, self.discussion)
    end
  end
end
