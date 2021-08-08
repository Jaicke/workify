class Approval < ApplicationRecord
  belongs_to :review, class_name: 'Review'
  belongs_to :teacher, class_name: 'Teacher::User'
end
