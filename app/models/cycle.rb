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
  belongs_to :starting_weight,
             class: BodyWeight,
             foreign_key: 'starting_weight_id'
  has_many :cycle_weights, dependent: :destroy
  has_many :exercise_weights, through: :cycle_weights
  has_many :subcycles, dependent: :destroy
  has_many :workouts, through: :subcycles

  scope :active, -> { where(active: true) }
  scope :unfinished,
        -> { joins(:workouts).where('workouts.workout_date IS NULL').uniq }
  scope :finished, lambda { where('cycles.id NOT IN ( ? )',
                                  Cycle.select('cycles.id')
                                        .joins(:workouts)
                                        .where('workouts.workout_date IS NULL')
                                        .group('cycles.id')
                             )
  }
  scope :recent_workout_completion,
        lambda {
          joins(:workouts)
            .group('cycles.id')
            .order('MAX(workouts.workout_date) DESC')
        }

  accepts_nested_attributes_for :starting_weight
  accepts_nested_attributes_for :cycle_weights
  accepts_nested_attributes_for :exercise_weights

  validates_numericality_of(:cycle_number)

  after_initialize :defaults

  def defaults
    self.active ||= true
  end

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

  def cycle_weights_hash
    cycle_weights.each_with_object({}) do |cycle_weight, hsh|
      exercise_weight = cycle_weight.exercise_weight
      hsh[exercise_weight.name.to_sym] = exercise_weight.value
    end
  end
end
