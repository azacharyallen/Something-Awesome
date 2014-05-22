# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)      not null
#  email           :string(255)      not null
#  session_token   :string(255)      not null
#  password_digest :string(255)      not null
#  role            :string(255)      default("USER"), not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  validates :username, :email, :session_token, :password_digest, presence: true
  validates :username, :session_token, uniqueness: true
  validates :role, inclusion: {in: %w(USER MODERATOR ADMINISTRATOR)}

  validates_length_of :password, minimum: 6, allow_nil: true
  before_validation :ensure_session_token;

  has_many :post_threads, inverse_of: :user
  has_many :posts, inverse_of: :user

  has_secure_password

  def reset_session_token!
    self.session_token = SecureRandom.hex
    self.save!
    session_token
  end
  
  def ensure_session_token
    self.session_token ||= SecureRandom.hex
  end
end
