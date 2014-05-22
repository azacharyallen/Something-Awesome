# == Schema Information
#
# Table name: forums
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  rank       :integer          not null
#  section_id :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Forum < ActiveRecord::Base
  validates :name, :rank, presence: true

  belongs_to :section, inverse_of: :forums
  has_many :post_threads, inverse_of: :forum
end
