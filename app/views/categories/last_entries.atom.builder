atom_feed do |feed|
  feed.title("Simple News Aggregation - #{@category.name}")
  feed.updated(@category.entries.first(:order => 'updated_at desc').updated_at)

 
  @atom_entries.each do |new|
    feed.entry(new) do |entry|
      entry.title("#{new.title} - #{new.feed.title}")
      entry.content(new.summary)
      entry.updated(new.updated_at)
      entry.author do |author|
        author.name(new.author)
      end
    end
  end
end

