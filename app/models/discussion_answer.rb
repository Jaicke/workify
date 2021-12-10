class DiscussionAnswer < ApplicationRecord
  paginates_per 8

  belongs_to :discussion
  belongs_to :created_by, polymorphic: true

  has_many :likes, foreign_key: :likeable_id

  validates :content, presence: true

  after_create :create_notification

  private

  def create_notification
    # Tem que notificar a todos os membros
    NotificationService.create!(self.created_by, self.discussion.created_by, :answered, self.discussion)
  end
end
