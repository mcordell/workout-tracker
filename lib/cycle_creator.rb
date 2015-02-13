class CycleCreator
  attr_accessor :cycle_model

  def self.add_starting_weights(cycle)
    case cycle.program.program_type
    when 'five_three_one'
      FiveThreeOne::Program::EXERCISES.each do |exercise_name|
        exercise = Exercise.find_by_name(exercise_name)
        cycle.cycle_weights.build(weight: ExerciseWeight.new(weightable: exercise))
      end
    end
  end

  def self.create(cycle)
    case cycle.program.program_type
    when 'five_three_one'
      program = FiveThreeOne::Program.new
      program.config.load_config_from_file(File.join(Rails.root, 'config', 'five_three_one.yml'))
      program.starting_weights = cycle.cycle_weights_hash
      cycle.copy_from_object(program.create_cycle)
      cycle
    end
  end
end
