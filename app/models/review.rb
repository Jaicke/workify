class Review < ApplicationRecord
  enum status: [:open, :closed]

  belongs_to :work
  belongs_to :old_work_version, class_name: 'WorkVersion', optional: true
  belongs_to :new_work_version, class_name: 'WorkVersion', optional: true

  has_many :approvals, class_name: 'Approval'
  has_many :review_events, class_name: 'ReviewEvent'

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

  def confirm_replace
    self.transaction do
      self.closed!
      self.update!(confirmed: true)
      self.old_work_version.update!(current: false)
      self.new_work_version.update!(current: true)
    end
  end

  def created_by
    review_events.find_by(action: :created).by_user
  end

  def confirmed_by
    review_events.find_by(action: :confirmed).by_user
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
