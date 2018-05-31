class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  has_many :blog_posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :username, uniqueness: true, length: {maximum: 20}
  validates :avatar, presence: true
end
