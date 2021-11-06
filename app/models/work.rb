class Work < ApplicationRecord
  acts_as_paranoid
  paginates_per 8

  enum status: { not_started: 0, in_progress: 1, complete: 2 }

  belongs_to :created_by, class_name: 'Student::User'
  belongs_to :advisor, class_name: 'Teacher::User', optional: true

  has_many :group_members, class_name: 'GroupMember', inverse_of: :work
  has_many :work_versions
  has_many :reviews
  has_many :discussions

  has_and_belongs_to_many :co_advisors, class_name: 'Teacher::User'

  validates :group_members, presence:  { message: "obrigatórios para trabalhos em grupo" }, if: :group?

  validate :valid_advisors

  accepts_nested_attributes_for :group_members, reject_if: :all_blank, allow_destroy: true

  before_validation :set_user_as_member, if: :group?
  before_validation :removes_group_members, unless: :group?

  scope :by_owner_or_member, ->(current_user) { left_joins(:group_members).where('created_by_id = ? OR group_members.email = ?', current_user.id , current_user.email) }

  def theme_label
    return theme if theme.present?
    "Sem tema"
  end

  def current_version
    work_versions.find_by(current: true)
  end

  def last_update_date
    return updated_at if current_version.nil?

    updated_at > current_version.created_at ? updated_at : current_version.created_at
  end

  private

  def set_user_as_member
    group_members.build(email: created_by.email) if group_members.find_by(email: created_by.email).nil?
  end

  def removes_group_members
    group_members.destroy_all
  end

  def valid_advisors
    if co_advisors.include?(advisor)
      errors.add(:base, 'Orientador não pode ser co-orientador ao mesmo tempo.')
    end
  end
end
