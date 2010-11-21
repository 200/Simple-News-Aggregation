class Category < ActiveRecord::Base
  has_many :feeds, :dependent => :delete_all
  validates :name, :presence => true
end
