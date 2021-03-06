class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :favourites, dependent: :destroy
  has_many :favourited_posts, through: :favourites, source: :post

  has_many :stars, dependent: :destroy
  has_many :starred_posts, through: :stars, source: :post

  has_secure_password

  before_validation :downcase_email

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: VALID_EMAIL_REGEX

  private

  def user_full_name
    "#{self.first_name} #{self.last_name}"
  end
  def downcase_email
    self.email.downcase! if email.present?
  end
end
