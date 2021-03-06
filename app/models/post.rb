class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :favouriters, through: :favourites, source: :user

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  has_many :stars, dependent: :destroy
  has_many :star_raters, through: :stars, source: :user

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

  def user_full_name
    user ? "#{self.user.first_name} #{self.user.last_name}" : nil
  end

  def fav_for(user)
    favourites.find_by(user: user)
  end

end
