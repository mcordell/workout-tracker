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

  TYPES = [:five_three_one]

  def current_cycle
    cycles.active.first
  end
end
