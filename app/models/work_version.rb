class WorkVersion < ApplicationRecord
  PERMITTED_FILE_CONTENT_TYPES = ['application/msword', 'application/pdf', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document']

  paginates_per 5

  belongs_to :work
  belongs_to :created_by, class_name: 'Student::User'

  has_many :comments, dependent: :destroy, class_name: 'Comment', foreign_key: :commentable

  validates :title, presence: true
  validates :title, uniqueness: { scope: :work }
  validate :file_presence
  validate :file_content_type, if: -> { file.attached? }

  has_one_attached :file

  before_validation :set_as_current

  after_create :changes_work_status

  private

  def set_as_current
    self.current = true if work.work_versions.count.zero?
  end

  def changes_work_status
    work.update(status: :in_progress) if work.not_started?
  end

  def file_presence
    errors.add(:file, :blank) unless self.file.attached?
  end

  def file_content_type
    errors.add(:file, 'com formato inválido.') unless PERMITTED_FILE_CONTENT_TYPES.include?(self.file.content_type)
  end
end
