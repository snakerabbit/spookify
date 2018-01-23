class User < ApplicationRecord
  validates :username, :password_digest, :session_token, :email, presence: true
  validates :username, :email, uniqueness: true
  validates :password, lenght: { minimum: 6, allow_nil: true}
  before_validation :ensure_session_token

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

  def reset_session_token
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
    return self.session_token
  end
end