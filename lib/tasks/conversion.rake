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
end
