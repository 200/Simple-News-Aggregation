every :reboot do
  runner "Feed.check_feeds_for_news"
end

every 1.minutes do
  runner "Feed.check_feeds_for_news"
end
