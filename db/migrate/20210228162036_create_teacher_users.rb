class CreateTeacherUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :teacher_users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :whatsapp
      t.text   :interests
      t.string :password_digest

      t.timestamps
    end
  end
end
