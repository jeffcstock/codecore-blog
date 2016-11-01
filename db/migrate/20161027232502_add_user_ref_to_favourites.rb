class AddUserRefToFavourites < ActiveRecord::Migration[5.0]
  def change
    add_reference :favourites, :user, foreign_key: true
  end
end
