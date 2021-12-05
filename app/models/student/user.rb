class Student::User < ApplicationRecord
  paginates_per 8

  attr_accessor :first_login

  enum class_shift: [:morning, :afternoon, :night, :full_time]

  belongs_to :college, optional: true
  belongs_to :course, optional: true

  has_many :connections, foreign_key: :student_id
  has_many :teachers, -> { joins(:connections).where(connections: { status: :accepted }) }, through: :connections

  has_many :works, foreign_key: :created_by
  has_many :reviews, foreign_key: :created_by
  has_many :discussions, foreign_key: :created_by
  has_many :discussion_answers, foreign_key: :created_by
  has_many :likes

  has_one_attached :avatar

  with_options({ unless: :first_login }) do
    validates_uniqueness_of :email
    validates_presence_of :first_name, :last_name, :email
    validates_presence_of :serie, :ingress_year, :ingress_semester, :class_shift, :college, :course, on: :update
  end

  has_secure_password

  before_validation :check_profile

  scope :search_by_name, -> (search) { where('LOWER(CONCAT(first_name, last_name)) ILIKE ?', "%#{search.downcase.strip}%") }

  def full_name
    "#{first_name} #{last_name}"
  end

  def label_name
    name = full_name.split
    "#{name.first} #{name.last}"
  end

  def connection_with(teacher_id)
    connection = self.connections.where(teacher_id: teacher_id, status: ['pending', 'accepted']).last
    return connection if connection
  end

  def profile_completed?
    [
      college.present?,
      course.present?,
      serie.present?,
      ingress_year.present?,
      ingress_semester.present?,
      class_shift.present?
    ].all?(true)
  end

  def check_profile
    self.first_login = true unless profile_completed?
  end

end
