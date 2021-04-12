class Teacher::User < ApplicationRecord
  paginates_per 2

  has_secure_password
  has_one_attached :avatar

  has_and_belongs_to_many :colleges, class_name: 'College'
  has_and_belongs_to_many :courses, class_name: 'Course'

  has_many :connections, foreign_key: :teacher_id
  has_many :students, through: :connections

  validates_uniqueness_of :email
  validates_presence_of :first_name, :last_name, :email
  validates_presence_of :colleges, :courses, on: :update

  scope :by_college, ->(college_id) { includes(:colleges).where(colleges: { id: college_id }) }
  scope :by_course, ->(course_id) { includes(:courses).where(courses: { id: course_id }) }
  scope :search_by_name, -> (search) { where('LOWER(CONCAT(first_name, last_name)) ILIKE ?', "%#{search.downcase.strip}%") }

  def full_name
    "#{first_name} #{last_name}"
  end

  def label_name
    name = full_name.split
    "#{name.first} #{name.last}"
  end
end
