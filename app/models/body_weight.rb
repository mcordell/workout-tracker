# == Schema Information
#
# Table name: body_weights
#
#  id         :integer          not null, primary key
#  value      :integer
#  user_id    :integer
#  unit       :string
#  created_at :datetime
#  updated_at :datetime
#

class BodyWeight < ActiveRecord::Base
  before_create :defaults

  validates :value, presence: true

  def defaults
    self.unit = 'lbs' if unit.nil?
  end
end
