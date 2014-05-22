# == Schema Information
#
# Table name: sections
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  rank       :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Section < ActiveRecord::Base
  validates :name, :rank, presence: true
  validates :name, uniqueness: true

  has_many :forums, inverse_of: :section
end
