namespace :poll  do
  desc "create some fake data"
  task :tweets => :environment do
  	PointService.pull_points_from_external_networks
  end
end