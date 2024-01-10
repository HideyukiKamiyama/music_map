class AddNotNullToSpotsAddress < ActiveRecord::Migration[7.1]
  def change
    change_column :spots, :address, :string, null: false
  end
end
