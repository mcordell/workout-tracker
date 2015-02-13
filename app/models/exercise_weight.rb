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
  belongs_to :weightable, polymorphic: true

  before_create :defaults
  delegate :name, to: :weightable

  validates :value, presence: true

  def defaults
    self.unit = 'lbs' if unit.nil?
  end
end
