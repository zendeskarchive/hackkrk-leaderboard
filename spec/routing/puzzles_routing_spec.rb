require "spec_helper"

describe PuzzlesController do
  describe "routing" do

    it "routes to #index" do
      get("/puzzles").should route_to("puzzles#index")
    end

    it "routes to #new" do
      get("/puzzles/new").should route_to("puzzles#new")
    end

    it "routes to #show" do
      get("/puzzles/1").should route_to("puzzles#show", :id => "1")
    end

    it "routes to #edit" do
      get("/puzzles/1/edit").should route_to("puzzles#edit", :id => "1")
    end

    it "routes to #create" do
      post("/puzzles").should route_to("puzzles#create")
    end

    it "routes to #update" do
      put("/puzzles/1").should route_to("puzzles#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/puzzles/1").should route_to("puzzles#destroy", :id => "1")
    end

  end
end
