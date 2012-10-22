require 'spec_helper'

describe NotificationService do
  context "original tweet found" do
    before(:each) do
      load "#{Rails.root}/db/seeds.rb"
    end

    it "should notify user of new point" do
      Twitter.should_receive(:update).any_number_of_times
      NotificationService.notify_user_of_points
    end
  end
end