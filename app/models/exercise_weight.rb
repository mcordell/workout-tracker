# == Schema Information
#
# Table name: weights
#
#  id              :integer          not null, primary key
#  value           :integer
#  user_id         :integer
#  unit            :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  weightable_id   :integer
#  weightable_type :string(255)
#

class ExerciseWeight < ActiveRecord::Base
  belongs_to :exercise

  before_create :defaults
  delegate :name, to: :exercise
  delegate :display_name, to: :exercise

  validates :value, presence: true
  validates :exercise, presence: true

  def defaults
    self.unit = 'lbs' if unit.nil?
  end

  def name=(name)
    self.exercise = Exercise.find_or_create_by(name: name)
  end
end
