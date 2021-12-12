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
  has_many :events

  has_and_belongs_to_many :co_advisors, class_name: 'Teacher::User'

  validates :group_members, presence:  { message: "obrigatórios para trabalhos em grupo" }, if: :group?

  validate :valid_advisors

  accepts_nested_attributes_for :group_members, reject_if: :all_blank, allow_destroy: true

  before_validation :set_user_as_member, on: :create
  before_validation :removes_group_members, on: :update, unless: :group?

  scope :by_owner_or_member, ->(current_user) { left_joins(:group_members).where('works.created_by_id = ? OR group_members.email = ?', current_user.id , current_user.email) }
  scope :by_adivisor_or_co_advisor, ->(current_user) { left_joins(:co_advisors).where('advisor_id = :current_user_id OR teacher_users_works.user_id = :current_user_id', current_user_id: current_user.id) }

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

  def members
    Student::User.where(email: group_members.pluck(:email))
  end

  def all_advisors
    ids = co_advisors.pluck(:id)
    ids = ids.push(advisor_id) if advisor_id.present?

    Teacher::User.where(id: ids)
  end

  private

  def set_user_as_member
    group_members.build(email: created_by.email) if group_members.select { |gm| gm.email == created_by.email }.empty?
  end

  def removes_group_members
    group_members.where.not(email: created_by.email).destroy_all
  end

  def valid_advisors
    if co_advisors.include?(advisor)
      errors.add(:base, 'Orientador não pode ser co-orientador ao mesmo tempo.')
    end
  end
end
