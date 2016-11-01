class Favourite < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user_id, presence: true
  validates :post_id, uniqueness: { scope: :user_id }
end
