class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.references :user, polymorphic: true
      t.references :recipient, polymorphic: true
      t.references :notifiable, polymorphic: true
      t.integer :action
      t.boolean :read, default: false

      t.timestamps
    end
  end
end
