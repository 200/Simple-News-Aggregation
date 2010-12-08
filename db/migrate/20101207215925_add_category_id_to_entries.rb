class AddCategoryIdToEntries < ActiveRecord::Migration
  def self.up
    add_column :entries, :category_id, :integer
  end

  def self.down
    remove_column :entries, :category_id
  end
end
