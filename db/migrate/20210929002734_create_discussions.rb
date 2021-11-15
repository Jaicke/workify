class CreateDiscussions < ActiveRecord::Migration[5.2]
  def change
    create_table :discussions do |t|
      t.string :title
      t.text :body
      t.boolean :closed, default: false
      t.string :tags, array: true, default: []
      t.integer :work_id
      t.references :created_by, polymorphic: true

      t.timestamps
    end
  end
end
