class CreateApprovals < ActiveRecord::Migration[5.2]
  def change
    create_table :approvals do |t|
      t.integer :teacher_id
      t.integer :review_id

      t.timestamps
    end
  end
end
