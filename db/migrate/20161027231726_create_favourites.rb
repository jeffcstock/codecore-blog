class CreateFavourites < ActiveRecord::Migration[5.0]
  def change
    create_table :favourites do |t|


      t.timestamps
    end
  end
end
