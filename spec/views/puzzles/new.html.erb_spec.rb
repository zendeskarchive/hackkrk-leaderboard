require 'spec_helper'

describe "puzzles/new" do
  before(:each) do
    assign(:puzzle, stub_model(Puzzle).as_new_record)
  end

  it "renders new puzzle form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => puzzles_path, :method => "post" do
    end
  end
end
