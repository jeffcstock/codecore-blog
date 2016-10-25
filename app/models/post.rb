class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :title, presence: true,
                    uniqueness: {case_sensitive: false},
                    length: {minimum: 3}
  validates :body, presence: true

  def self.search(search)
    if search.present?
      where("title || body ILIKE ?", "%#{search}%")
    end
  end
  def body_snippet
    body_length = self.body.length
    unless body_length < 100
      self.body[0...100] + '...'
    end
  end

end
