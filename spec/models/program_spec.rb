require 'rails_helper'

describe Program do
  let(:program) { FactoryGirl.create(:program) }

  context "when name is not present" do
    before { program.name = nil }

    it "is not valid" do
      expect(program).not_to be_valid
    end
  end

  describe ".current_cycle" do
    context "when it does not have an active cycle" do
      let(:program_with_inactive_cycles) { FactoryGirl.create(:program, :with_inactive_cycles) }

      it "returns nil" do
        expect(program_with_inactive_cycles.current_cycle).to be_nil
      end
    end

    context "when its cycles are all finished" do
      let(:program_with_finished_cycles) { FactoryGirl.create(:program) }

      it "returns nil" do
        expect(program_with_finished_cycles.current_cycle).to be_nil
      end
    end

    context "when it has an active, unfinished cycle" do
      let!(:cycle) { FactoryGirl.create(:cycle, :with_unfinished_subcycle, active: true, program: program) }

      it "returns that cycle" do
        expect(program.current_cycle).to eq cycle
      end
    end

    context "when it has multiple active unfinished cycles" do
      let!(:first_cycle) { FactoryGirl.create(:cycle, :with_unfinished_subcycle, active: true, program: program) }
      let!(:second_cycle) { FactoryGirl.create(:cycle, :with_unfinished_subcycle, active: true, program: program) }

      it "returns the most recently created cycle" do
        expect(program.current_cycle).to eq second_cycle
      end
    end
  end

  describe "#active" do
    let!(:inactive_program) { FactoryGirl.create(:program, active: false) }
    let!(:active_program) { FactoryGirl.create(:program, active: true) }
    let!(:active_program2) { FactoryGirl.create(:program, active: true) }

    it "returns active programs" do
      expect(Program.active).to eq [active_program, active_program2]
    end

    it "does not return inactive programs" do
      expect(Program.active).not_to include inactive_program
    end
  end

  describe ".next_workout" do
    context "when it does not have an unfinished cycle" do
      it "returns nil" do
        program_with_finished_cycles = FactoryGirl.create(:program, :with_finished_cycles)
        expect(program_with_finished_cycles.next_workout).to be_nil
      end
    end

    context "when it has an unfinished cycle" do
      before do
        subcycle = FactoryGirl.create(:subcycle)
        complete_workout = FactoryGirl.create(:workout, :completed, subcycle: subcycle)
        @incomplete_workout = FactoryGirl.create(:workout, :not_completed, subcycle: subcycle)
        subcycle.cycle = FactoryGirl.create(:cycle, active: true, program: program)
        subcycle.save
      end

      it "returns the next incomplete workout for that cycle" do
        expect(program.next_workout).to eq @incomplete_workout
      end
    end
  end
end
