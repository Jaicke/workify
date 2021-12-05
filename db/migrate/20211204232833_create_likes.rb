class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :user, polymorphic: true
      t.references :likeable, polymorphic: true

      t.timestamps
    end
  end
end
