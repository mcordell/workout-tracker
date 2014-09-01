require "rails_helper"

RSpec.describe CyclesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/cycles").to route_to("cycles#index")
    end

    it "routes to #new" do
      expect(:get => "/cycles/new").to route_to("cycles#new")
    end

    it "routes to #show" do
      expect(:get => "/cycles/1").to route_to("cycles#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/cycles/1/edit").to route_to("cycles#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/cycles").to route_to("cycles#create")
    end

    it "routes to #update" do
      expect(:put => "/cycles/1").to route_to("cycles#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/cycles/1").to route_to("cycles#destroy", :id => "1")
    end

  end
end
