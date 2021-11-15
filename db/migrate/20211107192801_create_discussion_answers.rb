class CreateDiscussionAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :discussion_answers do |t|
      t.text :content
      t.integer :discussion_id
      t.boolean :favorite, default: false
      t.references :created_by, polymorphic: true

      t.timestamps
    end
  end
end
