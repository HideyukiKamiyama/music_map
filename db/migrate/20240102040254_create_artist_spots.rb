class CreateArtistSpots < ActiveRecord::Migration[7.1]
  def change
    create_table :artist_spots do |t|
      t.string :name,             null: false
      t.text :detail
      t.integer :tag,             null: false
      t.references :user, null: false, foreign_key: true
      t.references :artist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
