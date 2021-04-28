class CreateGroupMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :group_members do |t|
      t.integer :work_id
      t.string :email

      t.timestamps
    end
  end
end
