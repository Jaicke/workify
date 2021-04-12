class Student::User < ApplicationRecord
  enum class_shift: [:morning, :afternoon, :night, :full_time]

  belongs_to :college, optional: true
  belongs_to :course, optional: true

  has_many :connections, foreign_key: :student_id
  has_many :teachers, through: :connections

  has_one_attached :avatar

  validates_uniqueness_of :email
  validates_presence_of :first_name, :last_name, :email
  validates_presence_of :serie, :ingress_year, :ingress_semester, :class_shift, :college, :course, on: :update

  has_secure_password

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

end
