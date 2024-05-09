class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :first_name, null:false
      t.string :last_name, null:false
      t.string :email, null:false
      t.string :username, null:false
      t.string :phone, null:false
      t.string :password_digest
      t.string :role, default: 0
      t.timestamps
    end
    add_index :users, :username, unique: true
    add_index :users, :phone, unique: true
    add_index :users, :email, unique: true
  end
end
