# == Schema Information
#
# Table name: cycles
#
#  id                 :integer          not null, primary key
#  starting_weight_id :integer
#  program_id         :integer
#  cycle_number       :integer
#  created_at         :datetime
#  updated_at         :datetime
#  active             :boolean
#

class Cycle < ActiveRecord::Base
  belongs_to :program
  belongs_to :starting_weight, class: Weight, :foreign_key => "starting_weight_id"
  has_many :subcycles
  has_many :workouts, through: :subcycles
  scope :active, -> { where(active: true) }
  accepts_nested_attributes_for :starting_weight

  def copy_from_object(cycle)
    cycle.subcycles.each_with_index do |sub, i|
      subcycle = subcycles.build
      subcycle.copy_from_object(sub)
      subcycle.number = i
    end
  end

  def next_workout
    workouts.order(:id).incomplete.first
  end

  def finished?
    subcycles.each do |s|
      return false unless s.finished?
      true
    end
  end
end
