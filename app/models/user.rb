class User < ApplicationRecord
  has_many :tasks
  before_validation { email.downcase! }
  has_secure_password
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 6 }
  before_destroy :least_one_admin_user_destroy
  before_update :least_one_admin_user_update

  private
  def least_one_admin_user_destroy
    if User.where(admin: true).count == 1 && self.admin
    throw(:abort)
    end
  end

  def least_one_admin_user_update
    user = User.where(id: self.id).where(admin: true)
    if User.where(admin: true).count == 1 && user.present? && self.admin == false
     throw(:abort)
    end
  end
end
