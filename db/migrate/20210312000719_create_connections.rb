class CreateConnections < ActiveRecord::Migration[5.2]
  def change
    create_table :connections do |t|
      t.references :student, index: true, foreign_key: { to_table: :student_users }
      t.references :teacher, index: true, foreign_key: { to_table: :teacher_users }
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
