class AddLastModifiedToFeeds < ActiveRecord::Migration
  def self.up
    add_column :feeds, :last_modified, :datetime
  end

  def self.down
    remove_column :feeds, :last_modified
  end
end
