require 'spec_helper'

describe "albums/index" do
  before(:each) do
    assign(:albums, [
      stub_model(Album,
        :album => "Album"
      ),
      stub_model(Album,
        :album => "Album"
      )
    ])
  end

  it "renders a list of albums" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Album".to_s, :count => 2
  end
end