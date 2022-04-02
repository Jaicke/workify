class Comment < ApplicationRecord
  belongs_to :created_by, polymorphic: true
  belongs_to :commentable, polymorphic: true

  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :replies, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy

  validates :body, presence: true

  scope :is_parents, -> { where(parent_id: nil) }
end
