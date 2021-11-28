class Approval < ApplicationRecord
  belongs_to :review, class_name: 'Review'
  belongs_to :teacher, class_name: 'Teacher::User'

  after_create :create_review_event

  private

  def create_review_event
    ReviewEvent.create!(review: review, by_user: teacher, action: :approved)
  end
end
