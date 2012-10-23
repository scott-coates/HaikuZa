namespace :poll  do
  desc "poll latest tweets for haiku"
  task :tweets => :environment do
  	PointService.pull_points_from_external_networks
  end
end