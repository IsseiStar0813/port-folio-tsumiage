require File.expand_path(File.dirname(__FILE__) + "/environment")

rails_env = ENV['RAILS_ENV'] || :development

set :environment, rails_env


set :output, "#{Rails.root}/log/cron.log"


every 1.day, :at => "0:00 am" do
  runner "User.make_user_unposted"
end