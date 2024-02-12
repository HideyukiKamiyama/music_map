class ChangeColunsLatitudeAndLongitudeToDecimal < ActiveRecord::Migration[7.1]
  def change
    change_column :spots, :latitude, :decimal, precision: 17, scale: 14
    change_column :spots, :longitude, :decimal, precision: 17, scale: 14
  end
end
