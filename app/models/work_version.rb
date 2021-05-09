class WorkVersion < ApplicationRecord
  paginates_per 5

  belongs_to :work
  belongs_to :created_by, class_name: 'Student::User'

  validates :title, presence: true
  validates :title, uniqueness: { scope: :work }
  validate :file_presence
  validate :file_content_type, if: -> { file.attached? }

  has_one_attached :file

  before_validation :set_as_current

  private

  def set_as_current
    self.current = true if work.work_versions.count.zero?
  end

  def file_presence
    errors.add(:file, :blank) unless self.file.attached?
  end

  def file_content_type
    errors.add(:file, 'deve ser um PDF') unless self.file.content_type == 'application/pdf'
  end
end
