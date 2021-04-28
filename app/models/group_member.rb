class GroupMember < ApplicationRecord
  belongs_to :work

  validates :email, uniqueness: { scope: :work }
end
