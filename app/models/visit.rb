# == Schema Information
#
# Table name: visits
#
#  id             :integer          not null, primary key
#  post_thread_id :integer
#  user_id        :integer
#  post_id        :integer          not null
#  created_at     :datetime
#  updated_at     :datetime
#

class Visit < ActiveRecord::Base
  belongs_to :post_thread
  belongs_to :user, inverse_of: :visits
  belongs_to :post

  def self.find_by_user_and_thread(user_id, thread_id)
    return Visit.where(user_id: user_id, post_thread_id: thread_id).first
  end
end
