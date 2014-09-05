# == Schema Information
#
# Table name: weights
#
#  id         :integer          not null, primary key
#  value      :integer
#  user_id    :integer
#  unit       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Weight < ActiveRecord::Base

  before_save :defaults

  def defaults
    unit = 'lb' if unit.nil?
  end
end
