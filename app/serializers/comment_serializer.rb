class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :user

  def user
    object.user_full_name
  end
end
