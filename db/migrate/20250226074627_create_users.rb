class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :occupation
      t.string :email
      t.string :avatar_filename
      t.string :role
      t.string :password_hash

      t.timestamps
    end
  end
end
