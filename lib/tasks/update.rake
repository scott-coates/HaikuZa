namespace :update  do
  desc "Poll latest tweets for haiku."
  task :tweets => :environment do
  	PointService.pull_points_from_external_networks
  end

  desc "Update users about points they've received."
  task :notifications => :environment do
  	NotificationService.notify_users_of_points
  end
end