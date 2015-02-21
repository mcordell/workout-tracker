require 'rails_helper'

describe CycleCreator do
  let(:valid_starting_weights) { {press: 140, bench_press: 240, deadlift: 420, squat: 350} }
  let(:cycle) { Cycle.new }

  describe "#build_cycle" do
    context "when a 5-3-1" do
      before do
        allow(cycle).to receive_message_chain(:program, :program_type).and_return('five_three_one')
      end

      context "and passed a cycle with valid starting weights" do
        before do
          allow(cycle).to receive(:cycle_weights_hash) { valid_starting_weights }
        end

        it "builds the subcycles" do
          expect { CycleCreator.build_cycle(cycle) }.to change { cycle.subcycles.to_a.count }.by(4)
        end
      end

      context "when passed a cycle missing a starting weight" do
        before do
          valid_starting_weights.delete(:bench_press)
          allow(cycle).to receive(:cycle_weights_hash) { valid_starting_weights }
        end

        it "sets an error on the cycle" do
          CycleCreator.build_cycle cycle
          expect(cycle.errors).not_to be_empty
        end
      end
    end
  end
end
