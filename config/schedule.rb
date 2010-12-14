every :reboot do
  runner "Feed.check_feeds_for_news"
end

every 10.minutes do
  runner "Feed.check_feeds_for_news"
end
