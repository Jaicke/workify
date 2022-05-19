class Discussion < ApplicationRecord
  paginates_per 8

  belongs_to :work
  belongs_to :created_by, polymorphic: true

  has_many :discussion_answers, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :title, :body, presence: true
  validate :tags_quantity

  before_validation :remove_empty_tags
  before_validation :capitalize_tags
  after_create :create_notification

  private

  def remove_empty_tags
    tags.delete_if(&:blank?)
  end

  def capitalize_tags
    tags.map!(&:capitalize)
  end

  def tags_quantity
    errors.add(:base, 'Máximo de tags permitidas é quatro') unless tags.count <= 4
  end

  def create_notification
    recipients = (work.members.to_a + work.all_advisors.to_a) - [created_by]

    recipients.each do |recipient|
      NotificationService.create!(self.created_by, recipient, :created, self)
    end
  end
end
