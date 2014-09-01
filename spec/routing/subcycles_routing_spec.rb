require "rails_helper"

RSpec.describe SubcyclesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/subcycles").to route_to("subcycles#index")
    end

    it "routes to #new" do
      expect(:get => "/subcycles/new").to route_to("subcycles#new")
    end

    it "routes to #show" do
      expect(:get => "/subcycles/1").to route_to("subcycles#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/subcycles/1/edit").to route_to("subcycles#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/subcycles").to route_to("subcycles#create")
    end

    it "routes to #update" do
      expect(:put => "/subcycles/1").to route_to("subcycles#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/subcycles/1").to route_to("subcycles#destroy", :id => "1")
    end

  end
end
