class CreateReviewEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :review_events do |t|
      t.integer :review_id
      t.integer :action
      t.references :by_user, polymorphic: true

      t.timestamps
    end
  end
end
