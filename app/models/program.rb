class Program < ActiveRecord::Base
  belongs_to :user
  has_many :cycles
  scope :active, -> { where(active: true) }

  def current_cycle
    cycles.active.first
  end
end
