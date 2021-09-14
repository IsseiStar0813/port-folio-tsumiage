set :output, "/path/to/my/cron_log.log"

every :day, at: "0:00 am" do
  runner "UserModel.make_user_unposted"
end