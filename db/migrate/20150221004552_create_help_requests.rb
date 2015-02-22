class CreateHelpRequests < ActiveRecord::Migration
  def change
    create_table :help_requests do |t|
      t.text :description
      t.boolean :is_complete, default: false
      t.references :student, index: true
      t.references :ta_user, index: true

      t.timestamps null: false
    end
    add_foreign_key :help_requests, :students
    add_foreign_key :help_requests, :ta_users
  end
end
