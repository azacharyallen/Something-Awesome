# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  username            :string(255)      not null
#  session_token       :string(255)      not null
#  password_digest     :string(255)      not null
#  role                :string(255)      default("USER"), not null
#  created_at          :datetime
#  updated_at          :datetime
#  profile             :text             default("I haven't written anything here yet.")
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  banned              :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  has_attached_file :avatar, styles: {
    :default_url => "/images/:attachment/missing_:style.png"
  }

  validates :username, :session_token, presence: true
  validates :username, :session_token, uniqueness: true
  validates :role, inclusion: {in: %w(USER MODERATOR ADMINISTRATOR)}

  validates_length_of :password, minimum: 6, allow_nil: true

  validates_attachment :avatar,
  :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }

  validates_attachment_size :avatar, :less_than => 100.kilobytes

  validate :image_dimensions

  before_validation :ensure_session_token;

  has_many :post_threads, inverse_of: :user
  has_many :posts, inverse_of: :user
  has_many :bookmarks, inverse_of: :user
  has_many :bookmarked_threads, through: :bookmarks, source: :post_thread
  has_many :visits
  has_many :visited_threads, through: :visits, source: :post_thread
  has_many :sent_messages, class_name: "PrivateMessage", foreign_key: :author_id, primary_key: :id, inverse_of: :author
  has_many :received_messages, class_name: "PrivateMessage", foreign_key: :recipient_id, primary_key: :id, inverse_of: :recipient

  has_secure_password

  def image_dimensions
    max_width  = 150
    max_height = 150
    temp_file = avatar.queued_for_write[:original]

    return unless temp_file

    dimensions = Paperclip::Geometry.from_file(temp_file)

    errors.add(:avatar, "width must be less than #{max_width}px") unless dimensions.width <= max_width
    errors.add(:avatar, "height must be less than #{max_height}px") unless dimensions.height <= max_height
  end


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
