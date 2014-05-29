# == Schema Information
#
# Table name: private_messages
#
#  id           :integer          not null, primary key
#  body         :text             not null
#  title        :string(255)      not null
#  author_id    :integer          not null
#  recipient_id :integer          not null
#  created_at   :datetime
#  updated_at   :datetime
#

class PrivateMessage < ActiveRecord::Base
  validates :body, :title, :author, :recipient, presence: true

  belongs_to :author, class_name: "User", foreign_key: :author_id, primary_key: :id, inverse_of: :sent_messages
  belongs_to :recipient, class_name: "User", foreign_key: :author_id, primary_key: :id, inverse_of: :received_messages

  scope :unread, -> { where(read: FALSE) }
end
