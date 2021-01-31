class User < ApplicationRecord
  after_initialize :set_default_role

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  # Permissions for each role are defined in the PostsPolicy
  enum role: [:normal, :subscriber, :editor, :moderator, :admin]


  def guest?
    persisted?
  end


  private

  def set_default_role
    self.role ||= :normal
  end
end
