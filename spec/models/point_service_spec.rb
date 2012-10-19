require 'spec_helper'

describe PointService do
	before :each do
	  # @smith = Factory(:contact, lastname: "Smith")
	  # @jones = Factory(:contact, lastname: "Jones")
	  # @johnson = Factory(:contact, lastname: "Johnson")
	end

  context "many tweets" do
    it "should create new tweets" do
       Haiku.should_receive(:create!)do |arg|
       expect(arg[:tweet_id]).to eq(1)
     end
       results = double("results")
       tweet = double("tweet", {id:1, user:stub({screen_name:"whatever"}),text:"somestuff"})
       results.stub(:statuses){[tweet]}
       
       Twitter.stub(:search){results}
       PointService.pull_points
     end
  end

  context "no tweets" do
    # smith = Factory(:contact, lastname: "Smith")
       # jones = Factory(:contact, lastname: "Jones")
       # johnson = Factory(:contact, lastname: "Johnson")
       # Contact.by_letter("J").should_not include smith
  end
end