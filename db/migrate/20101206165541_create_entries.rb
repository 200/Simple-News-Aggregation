class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.string :url
      t.string :title  
      t.string :author
      t.text :summary
      t.integer :feed_id

      t.timestamps
    end
  end

  def self.down
    drop_table :entries
  end
end
