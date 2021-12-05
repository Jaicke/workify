class Like < ApplicationRecord
  belongs_to :user, polymorphic: true
  belongs_to :likeable, polymorphic: true
end
