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
#  avatar          :string(255)      default("default_avatar.png")
#

class User < ActiveRecord::Base
  has_attached_file :s3avatar, styles: {
    :default_url => "/images/:attachment/missing_:style.png"
  }

  validates :username, :session_token, presence: true
  validates :username, :session_token, uniqueness: true
  validates :role, inclusion: {in: %w(USER MODERATOR ADMINISTRATOR)}

  validates_length_of :password, minimum: 6, allow_nil: true

  validates_attachment :s3avatar,
  :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }

  validates_attachment_size :s3avatar, :less_than => 100.kilobytes

  before_validation :ensure_session_token;

  has_many :post_threads, inverse_of: :user
  has_many :posts, inverse_of: :user
  has_many :bookmarks, inverse_of: :user
  has_many :bookmarked_threads, through: :bookmarks, source: :post_thread

  has_secure_password


  def reset_session_token!
    self.session_token = SecureRandom.hex
    self.save!
    session_token
  end
  
  def ensure_session_token
    self.session_token ||= SecureRandom.hex
  end

  def reg_date
    self.created_at.to_date
  end
end
