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
  has_many :exercise_weights, as: :weightable

  validates :name, presence: true

  def display_name
    name.humanize
  end

  def display_name=(display_name)
    self.name = display_name.gsub(/(.) ([A-Za-z])/, '\1_\2').downcase
  end
end
