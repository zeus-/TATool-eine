class CreateTaS < ActiveRecord::Migration
  def change
    create_table :ta_users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.boolean :is_available, default: false

      t.timestamps null: false
    end
  end
end
