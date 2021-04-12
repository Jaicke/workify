class Course < ApplicationRecord
  has_and_belongs_to_many :teachers, class_name: 'Teacher::User'
end
