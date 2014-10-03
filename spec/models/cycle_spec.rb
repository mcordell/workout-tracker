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

require 'spec_helper'

RSpec.describe Cycle, :type => :model do
  describe "finished" do
    let(:workout_finished) { FactoryGirl.create(:workout, workout_date: Time.now) }
    let(:workout_unfinished) { FactoryGirl.create(:cycle, program: workout_finished.subcycle.cycle.program) }

    it "returns cycles that have all of their workouts finished" do
      expect(Cycle.finished).to eq [workout_finished.subcycle.cycle]
    end
  end
end
