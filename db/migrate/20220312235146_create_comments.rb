class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :commentable, polymorphic: true
      t.references :created_by, polymorphic: true
      t.integer :parent_id
      t.boolean :edited, default: false
      t.text :body

      t.timestamps
    end
  end
end
