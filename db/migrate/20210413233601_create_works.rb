class CreateWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :works do |t|
      t.string :theme
      t.text :description
      t.integer :status, default: 0
      t.boolean :group, default: false
      t.integer :created_by_id
      t.integer :advisor_id
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :works, :status
  end
end
