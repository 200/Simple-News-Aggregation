Factory.define :feed do |feed|
  feed.association :category_id, :factory => :category
  feed.url 'http://rss.cnn.com/rss/edition.rss'
end


Factory.define :category do |category| 
    category.name 'Category'
end
