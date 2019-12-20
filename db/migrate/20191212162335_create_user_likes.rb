class CreateUserLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :user_likes do |t|
      t.integer :liker_id
      t.integer :likee_id

      t.timestamps
    end
  end
end
