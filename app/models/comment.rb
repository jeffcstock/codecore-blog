class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  validates :body, presence: true, uniqueness: true
end
