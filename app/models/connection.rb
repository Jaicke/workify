class Connection < ApplicationRecord
  enum status: { pending: 0, declined: 1, accepted: 2 }
  belongs_to :student, class_name: 'Student::User'
  belongs_to :teacher, class_name: 'Teacher::User'
end
