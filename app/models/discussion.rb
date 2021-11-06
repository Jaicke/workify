class Discussion < ApplicationRecord
  paginates_per 8

  belongs_to :work
  belongs_to :created_by, polymorphic: true

  validates :title, :body, presence: true
  validate :tags_quantity

  before_validation :remove_empty_tags
  before_validation :capitalize_tags


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
end
