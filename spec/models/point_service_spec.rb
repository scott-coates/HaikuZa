require 'spec_helper'

describe PointService do
  before :each do
    # @smith = Factory(:contact, lastname: "Smith")
    # @jones = Factory(:contact, lastname: "Jones")
    # @johnson = Factory(:contact, lastname: "Johnson")
  end

  context "original tweet found" do
    before(:each) do
      results = double("results")
      tweet = double("tweet", {retweet?: false, id:1, user:stub({screen_name:"user1",id:1, profile_image_url:"mypic.jpg"}),text:"somestuff"})
      results.stub(:statuses){[tweet]}
      Twitter.stub(:search){results}
    end

    it "should create new tweets" do
        Haiku.should_receive(:create!)do |arg|
        expect(arg[:tweet_id]).to eq(1)
      end
      PointService.pull_points_from_external_networks
    end
    
    it "should create new unregistered users" do
        User.should_receive(:create!)do |arg|
        expect(arg[:registered]).to eq(false)
      end
      PointService.pull_points_from_external_networks
    end

    it "should assign points for new haiku" do
        User.should_receive(:create!)do |arg|
        expect(arg[:registered]).to eq(false)
      end
      PointService.pull_points_from_external_networks
    end

  end
end