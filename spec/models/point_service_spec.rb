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
      tweet = double("tweet", {retweet?: false, id:1, user:stub({name:"HI",screen_name:"user1",id:1, profile_image_url:"mypic.jpg"}),text:"somestuff"})
      results.stub(:statuses){[tweet]}
      Twitter.stub(:search){results}
      Twitter.stub(:retweet)
    end

    it "should create new tweets" do
        user = double("user", :haikus => double("haikus"), :add_point => {}, :save! => {})
        User.stub(:new){user}
        user.haikus.should_receive(:build).with(hash_including(:tweet_id=>1))
        PointService.pull_points_from_external_networks
    end
    
    it "should create new unregistered users" do
        original_method = User.method(:new)
        User.should_receive(:new).with(hash_including(:registered=>false)){|*args| original_method.call(*args)}
        PointService.pull_points_from_external_networks
    end

    it "should assign points for new haiku" do
      original_method = User.method(:new)

      User.should_receive(:new)do |*args|
        user = original_method.call(*args)
        user.should_receive(:add_point).with(hash_including(:point_type=>:tweet))
        user
      end
      PointService.pull_points_from_external_networks
    end
  end
end