class ReviewEvent < ApplicationRecord
  enum action: [:created, :closed, :confirmed, :approved]

  belongs_to :review, class_name: 'Review'
  belongs_to :by_user, polymorphic: true

  validates :action, presence: true

  def action_label
    labels = {
      created: 'Criada',
      closed: 'Fechada',
      confirmed: 'Confirmada',
      approved: 'Aprovada'
    }

    labels[action.to_sym]
  end
end
