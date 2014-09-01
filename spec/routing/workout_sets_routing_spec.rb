require "rails_helper"

RSpec.describe WorkoutSetsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/workout_sets").to route_to("workout_sets#index")
    end

    it "routes to #new" do
      expect(:get => "/workout_sets/new").to route_to("workout_sets#new")
    end

    it "routes to #show" do
      expect(:get => "/workout_sets/1").to route_to("workout_sets#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/workout_sets/1/edit").to route_to("workout_sets#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/workout_sets").to route_to("workout_sets#create")
    end

    it "routes to #update" do
      expect(:put => "/workout_sets/1").to route_to("workout_sets#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/workout_sets/1").to route_to("workout_sets#destroy", :id => "1")
    end

  end
end
