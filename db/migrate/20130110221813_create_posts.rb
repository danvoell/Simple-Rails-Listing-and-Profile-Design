class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :picture
      t.string :title
      t.string :description
      t.string :subheading

      t.timestamps
    end
  end
end
