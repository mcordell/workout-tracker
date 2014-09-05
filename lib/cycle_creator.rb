class CycleCreator
  attr_accessor :cycle_model

  def self.create(cycle, cycle_options)
    case cycle.program.program_type
    when 'five_three_one'
      program = FiveThreeOne::Program.new
      program.config.load_config_from_file(File.join(Rails.root, 'config', 'five_three_one.yml'))
      program.starting_weights = cycle_options.each { |k,v| cycle_options[k] = v.to_i }
      cycle.copy_from_object(program.create_cycle)
      cycle
    end
  end
end
