# == Schema Information
#
# Table name: posts
#
#  id             :integer          not null, primary key
#  body           :text             not null
#  user_id        :integer
#  post_thread_id :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class Post < ActiveRecord::Base
  validates :body, :user, :post_thread, presence: true

  belongs_to :user, inverse_of: :posts
  belongs_to :post_thread, inverse_of: :posts
end
