class ChangeCloumnsNotnullAddComments < ActiveRecord::Migration[7.1]
  def change
    change_column :comments, :body, :string, null: false
  end
end
