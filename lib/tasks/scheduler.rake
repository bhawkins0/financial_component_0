desc "This task is called by the Heroku scheduler add-on"
task :update_feed => :environment do
  puts "Updating feed..."
  NewsFeed.update
  puts "done."
end

task :clear_old_verifications => :environment do
    UserVerification.where("updated_at < ?", Time.now - 60*60*3).destroy_all
end