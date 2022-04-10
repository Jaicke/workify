class Teacher::User < ApplicationRecord
  paginates_per 8

  attr_accessor :first_login

  has_secure_password
  has_one_attached :avatar

  has_and_belongs_to_many :colleges, class_name: 'College'
  has_and_belongs_to_many :courses, class_name: 'Course'
  has_and_belongs_to_many :works_co_advising, class_name: 'Work'

  has_many :works_advising, foreign_key: :advisor_id, class_name: 'Work', dependent: :destroy

  has_many :connections, foreign_key: :teacher_id, dependent: :destroy
  has_many :students, -> { includes(:connections).where(connections: { status: :accepted }) }, through: :connections

  has_many :approvals, class_name: 'Approval', foreign_key: :teacher_id
  has_many :discussions, as: :created_by, dependent: :destroy
  has_many :discussion_answers, as: :created_by, dependent: :destroy
  has_many :notifications, as: :recipient, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :events, dependent: :destroy

  with_options({ unless: :first_login }) do
    validates_uniqueness_of :email
    validates_presence_of :first_name, :last_name, :email
    validates_presence_of :colleges, :courses, on: :update
    validates :whatsapp, numericality: { only_integer: true }, if: -> { whatsapp.present? }
  end

  before_validation :check_profile

  scope :by_college, ->(college_id) { includes(:colleges).where(colleges: { id: college_id }) }
  scope :by_course, ->(course_id) { includes(:courses).where(courses: { id: course_id }) }
  scope :search_by_name, -> (search) { where('LOWER(CONCAT(first_name, last_name)) ILIKE ?', "%#{search.downcase.strip}%") }

  def full_name
    "#{first_name} #{last_name}".titleize
  end

  def label_name
    name = full_name.split
    "#{name.first} #{name.last}".titleize
  end

  def connection_with(student_id)
    connection = self.connections.where(student_id: student_id, status: ['pending', 'accepted']).last
    return connection if connection
  end

  def profile_completed?
    [
      colleges.any?,
      courses.any?
    ].all?(true)
  end

  def check_profile
    self.first_login = true unless profile_completed? || new_record?
  end

  def generate_password_token!
    self.reset_password_token = generate_token
    self.reset_password_sent_at = Time.now
    save!
  end

  def password_token_valid?
    (self.reset_password_sent_at + 4.hours) > Time.now
   end

  private

  def generate_token
    token = loop do
      token = SecureRandom.hex
      break token unless Teacher::User.exists?(reset_password_token: token)
    end
  end
end
