# == Schema Information
#
# Table name: exercises
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Exercise < ActiveRecord::Base
  has_many :workout_sets
  has_many :weights, as: :weightable

  validates :name, presence: true
end
