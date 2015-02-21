class CycleCreator
  attr_accessor :cycle_model

  FIVE_THREE_ONE_CONFIG = File.join(Rails.root, 'config', 'five_three_one.yml')

  def self.add_starting_weights(cycle)
    case cycle.program.program_type
    when 'five_three_one'
      FiveThreeOne::Program::EXERCISES.each do |exercise_name|
        exercise = Exercise.find_by_name(exercise_name)
        cycle.cycle_weights.build(exercise_weight: ExerciseWeight.new(exercise: exercise))
      end
    end
  end

  def self.build_cycle(cycle)
    case cycle.program.program_type
    when 'five_three_one'
      build_five_three_one_cycle(cycle)
    end
  end

  private

  def self.build_five_three_one_cycle(cycle)
    program = FiveThreeOne::Program.new
    program.load_config_from_file(FIVE_THREE_ONE_CONFIG)
    begin
      starting_weights = cycle.cycle_weights_hash
      cycle.from_hash(program.create_cycle(starting_weights).to_h)
    rescue => e
      cycle.errors.add(:cycle_weights, e.to_s)
    end
    cycle
  end
end
