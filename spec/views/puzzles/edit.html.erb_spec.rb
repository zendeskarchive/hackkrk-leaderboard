require 'spec_helper'

describe "puzzles/edit" do
  before(:each) do
    @puzzle = assign(:puzzle, stub_model(Puzzle))
  end

  it "renders the edit puzzle form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => puzzles_path(@puzzle), :method => "post" do
    end
  end
end
