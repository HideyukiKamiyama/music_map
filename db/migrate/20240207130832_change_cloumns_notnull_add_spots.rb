class ChangeCloumnsNotnullAddSpots < ActiveRecord::Migration[7.1]
  def change
    change_column :spots, :detail, :text, null: false
  end
end
