class Review < ApplicationRecord
  enum status: [:open, :closed]

  belongs_to :work
  belongs_to :created_by, class_name: 'Student::User'
  belongs_to :old_work_version, class_name: 'WorkVersion', optional: true
  belongs_to :new_work_version, class_name: 'WorkVersion', optional: true

  has_many :approvals, class_name: 'Approval'

  validates :old_work_version, presence: true
  validates :new_work_version, presence: true
  validates :title, presence: true
  validates :description, presence: true

  before_validation :set_status, on: :create
  before_validation :set_old_work_version, on: :create
  before_validation :set_creation_number, on: :create

  def approved?
    self.approvals.any?
  end

  private

  def set_status
    self.status = :open
  end

  def set_old_work_version
    self.old_work_version = self.work.work_versions.find_by(current: true)
  end

  def set_creation_number
    self.creation_number = "##{work.reviews.size}"
  end
end
