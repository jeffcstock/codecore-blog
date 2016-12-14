class AddPostRefToFavourites < ActiveRecord::Migration[5.0]
  def change
    add_reference :favourites, :post, foreign_key: true
  end
end
