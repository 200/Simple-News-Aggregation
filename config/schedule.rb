every :reboot do
  runner "Feed.check_feeds_for_news"
end

every 15.minutes do
  runner "Feed.check_feeds_for_news"
end
