class College < ApplicationRecord
  has_and_belongs_to_many :teachers, class_name: 'Teacher::User'

  def label
    "#{name} - #{acronym}"
  end
end
