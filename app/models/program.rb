# == Schema Information
#
# Table name: programs
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  user_id      :integer
#  created_at   :datetime
#  updated_at   :datetime
#  active       :boolean
#  program_type :string(255)
#

class Program < ActiveRecord::Base
  belongs_to :user
  has_many :cycles
  scope :active, -> { where(active: true) }
  delegate :next_workout, to: :current_cycle

  TYPES = [:five_three_one]

  def current_cycle
    cycles.unfinished.active.last
  end
end
