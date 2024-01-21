class AddImagesToSpots < ActiveRecord::Migration[7.1]
  def change
    add_column :spots, :images, :json
  end
end
