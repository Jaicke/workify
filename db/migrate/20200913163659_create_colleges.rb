class CreateColleges < ActiveRecord::Migration[5.2]
  def change
    create_table :colleges do |t|
      t.string :name
      t.string :acronym
      t.string :state

      t.timestamps
    end
    add_index :colleges, :name
    add_index :colleges, :acronym
    add_index :colleges, :state
  end
end
