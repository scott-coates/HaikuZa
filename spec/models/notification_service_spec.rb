require 'spec_helper'

describe NotificationService do
  context "original tweet found" do
    before(:each) do
      load "#{Rails.root}/db/seeds.rb"
    end

    it "should notify user of new point" do
      NotificationService.notify_user_of_points
    end
  end
end