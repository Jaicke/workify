class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.string :description
      t.datetime :event_date
      t.boolean :online, default: false
      t.string :room_url
      t.string :place
      t.string :color
      t.integer :work_id
      t.references :created_by, polymorphic: true

      t.timestamps
    end
  end
end
