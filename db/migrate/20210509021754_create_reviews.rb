class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :title
      t.text :description
      t.integer :status
      t.string :creation_number
      t.boolean :confirmed
      #t.integer :confirmed_by_id
      #t.datetime :confirmed_at
      #t.integer :created_by_id
      t.integer :work_id
      t.integer :old_work_version_id
      t.integer :new_work_version_id

      t.timestamps
    end
  end
end
