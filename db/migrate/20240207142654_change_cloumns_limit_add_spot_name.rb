class ChangeCloumnsLimitAddSpotName < ActiveRecord::Migration[7.1]
  def change
    change_column :spots, :spot_name, :string, limit: 30, null: false
  end
end
