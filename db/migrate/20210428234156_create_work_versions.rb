class CreateWorkVersions < ActiveRecord::Migration[5.2]
  def change
    create_table :work_versions do |t|
      t.integer :work_id
      t.string :title
      t.integer :created_by_id
      t.boolean :current, default: false

      t.timestamps
    end
  end
end
