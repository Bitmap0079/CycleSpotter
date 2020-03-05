class ChangePostsNameLimit50 < ActiveRecord::Migration[5.2]
  def up
    change_column :posts, :name, :string, limit: 50
  end
  def down
    change_column :posts, :name, :string
  end
end
