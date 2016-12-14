class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def user_full_name
    user ? "#{self.user.first_name} #{self.user.last_name}" : nil
  end
end
