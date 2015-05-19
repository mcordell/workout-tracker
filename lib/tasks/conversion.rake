namespace :conversion do
  desc "convert workout sets to use weight types"
  task work_sets_use_weight_types: :environment do
      WorkoutSet.all.each do |workout_set|
        weight = workout_set.read_attribute :weight
        if weight
          w = Weight.create(value: weight, weightable: workout_set.exercise)
          workout_set.update_attribute(:weight, w)
        end
      end
  end

  desc "convert hard written workout notes to real sets"
  task note_to_sets: :environment do
    Rails.logger.level = Logger::DEBUG
    Workout.where("notes != ''").each do |workout|
      if /\d+(x\d+){1,2}/.match(workout.notes)
        puts "Workout ID# #{workout.id}"
        puts workout.notes

        have_more = true
        while have_more
          info = get_info
          if check_info(info)
            commit_info(workout, info)
          end
          have_more = have_more?
        end
        workout.update_attribute(:notes, '') if clear_notes?
      end
    end
  end
end

def commit_info(workout, info)
  exercise = Exercise.find_or_create_by!(name: info[:exercise])
  ew = ExerciseWeight.find_or_create_by!(value: info[:weight], exercise_id: exercise.id)
  info[:sets].to_i.times do |i|
    reps = info[:reps]
    workout.workout_sets.create(
      exercise_weight_id: ew.id,
      exercise_id: exercise.id,
      intended_reps: reps,
      performed_reps: reps,
      workout_id: workout.id
    )
  end
end

def clear_notes?
  get_yes_no('Clear the notes?')
end

def have_more?
  get_yes_no('Have more to add?')
end

def check_info(info)
  puts "Save these sets:"
  puts "Exercise: #{info[:exercise]}"
  puts "Sets: #{info[:sets]}"
  puts "Reps: #{info[:reps]}"
  puts "Weight: #{info[:weight]}"
  get_yes_no 'Save?[y/n]'
end

def get_yes_no(message)
  get_answer(message).capitalize == 'Y'
end

def get_info()
    exercise = get_answer('Exercise:')
    sets = get_answer('Sets:')
    reps = get_answer('Reps:')
    weight = get_answer('Weight:')
    {
      exercise: exercise,
      reps: reps,
      sets: sets,
      weight: weight
    }
end

def get_answer(question)
  puts question
  STDIN.gets.chomp!
end

