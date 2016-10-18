class Post < ApplicationRecord
  validates :title, presence: true, uniqueness: {case_sensitive: false}
  def self.search(search)
    if search.present?
      where("title || body ILIKE ?", "%#{search}%")
    end
  end
end
