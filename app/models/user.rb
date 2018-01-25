# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  email           :string           not null
#  img_url         :string           default("https://cdn1.iconfinder.com/data/icons/ui-5/502/profile-512.png")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  validates :username, :password_digest, :session_token, :email, presence: true
  validates :username, :email, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true}
  before_validation :ensure_session_token

  has_many :user_follows,
    class_name: 'UserFollow',
    primary_key: :id,
    foreign_key: :user_id

  has_many :user_followed,
    class_name: 'UserFollow',
    primary_key: :id,
    foreign_key: :followed_user_id

  has_many :followed_users,
    through: :user_follows,
    source: :followed_user

  has_many :followers,
    through: :user_followed,
    source: :follower


  attr_reader :password

  def self.find_by_credentials(username, password)
    @user = User.find_by_username(username);
    if @user && @user.is_password?(password)
      return @user
    else
      return nil
    end
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def ensure_session_token
    self.session_token = SecureRandom.urlsafe_base64 unless self.session_token
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
    return self.session_token
  end


end
