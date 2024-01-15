class RemoveTitleFromComments < ActiveRecord::Migration[7.1]
  def change
    remove_column :comments, :title, :string
  end
end
