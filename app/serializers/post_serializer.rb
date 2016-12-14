class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :author

  has_many :comments
  def author
    object.user_full_name
  end
end
