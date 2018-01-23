class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :password_digest, null: false
      t.string :session_token, null: false
      t.string :email, null: false
      t.string :img_url, default: 'https://cdn1.iconfinder.com/data/icons/ui-5/502/profile-512.png'

      t.timestamps
    end
  end
end
