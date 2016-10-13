class Comment < ApplicationRecord
  validates :body, presence: true, uniqueness: true
end
