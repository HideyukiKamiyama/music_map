class RenamePostsToComments < ActiveRecord::Migration[7.1]
  def change
    rename_table :posts, :comments
  end
end
