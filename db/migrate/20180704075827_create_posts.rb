class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :name
      t.text :heading
      t.text :content
      t.string :image
      t.integer :user_id

      t.timestamps
    end
  end
end
