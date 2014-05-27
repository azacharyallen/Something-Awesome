# == Schema Information
#
# Table name: post_threads
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  user_id    :integer          not null
#  forum_id   :integer          not null
#  created_at :datetime
#  updated_at :datetime
#  closed     :boolean          default(FALSE)
#

class PostThread < ActiveRecord::Base
  validates :title, :user, :forum, presence: true;

  belongs_to :user, inverse_of: :post_threads
  belongs_to :forum, inverse_of: :post_threads
  has_many :posts, inverse_of: :post_thread
  has_many :bookmarks, inverse_of: :post_thread
end
