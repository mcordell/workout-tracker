
cycle = Cycle.last
program = FiveThreeOne::Program.new
program.config.load_config_from_file(File.join(Rails.root, 'config', 'five_three_one.yml'))
program.starting_weights = { deadlift: 320, press: 420, squat: 300, bench_press: 200 }
cycle.copy_from_object(program.create_cycle)
