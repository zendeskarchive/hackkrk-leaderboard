require 'spec_helper'

describe "puzzles/index" do
  before(:each) do
    assign(:puzzles, [
      stub_model(Puzzle),
      stub_model(Puzzle)
    ])
  end

  it "renders a list of puzzles" do
    render
  end
end
