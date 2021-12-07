class Teacher::User < ApplicationRecord
  paginates_per 8

  attr_accessor :first_login

  has_secure_password
  has_one_attached :avatar

  has_and_belongs_to_many :colleges, class_name: 'College'
  has_and_belongs_to_many :courses, class_name: 'Course'
  has_and_belongs_to_many :works_co_advising, class_name: 'Work'

  has_many :works_advising, foreign_key: :advisor_id, class_name: 'Work'

  has_many :connections, foreign_key: :teacher_id
  has_many :students, -> { includes(:connections).where(connections: { status: :accepted }) }, through: :connections

  has_many :approvals, class_name: 'Approval', foreign_key: :teacher_id
  has_many :discussions, foreign_key: :created_by
  has_many :discussion_answers, foreign_key: :created_by
  has_many :likes
  has_many :events

  validates_uniqueness_of :email
  validates_presence_of :first_name, :last_name, :email
  validates_presence_of :colleges, :courses, on: :update
  validates :whatsapp, numericality: { only_integer: true }, if: -> { whatsapp.present? }

  scope :by_college, ->(college_id) { includes(:colleges).where(colleges: { id: college_id }) }
  scope :by_course, ->(course_id) { includes(:courses).where(courses: { id: course_id }) }
  scope :search_by_name, -> (search) { where('LOWER(CONCAT(first_name, last_name)) ILIKE ?', "%#{search.downcase.strip}%") }

  def full_name
    "#{first_name} #{last_name}".capitalize
  end

  def label_name
    name = full_name.split
    "#{name.first} #{name.last}".capitalize
  end

  def profile_completed?
    [
      colleges.any?,
      courses.any?
    ].all?(true)
  end

  def check_profile
    self.first_login = true unless profile_completed?
  end
end
