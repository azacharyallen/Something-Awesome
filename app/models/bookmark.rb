# == Schema Information
#
# Table name: bookmarks
#
#  id             :integer          not null, primary key
#  user_id        :integer          not null
#  post_thread_id :integer          not null
#  created_at     :datetime
#  updated_at     :datetime
#

class Bookmark < ActiveRecord::Base
  validates :user, :post_thread, presence: true

  belongs_to :user, inverse_of: :bookmarks
  belongs_to :post_thread, inverse_of: :bookmarks
end
