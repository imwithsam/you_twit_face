class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :nickname
      t.text :email
      t.text :provider
      t.text :token
      t.text :uid
      t.text :image_url

      t.timestamps null: false
    end
  end
end
