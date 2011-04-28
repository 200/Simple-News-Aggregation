class Category < ActiveRecord::Base
  has_many :feeds, :dependent => :destroy
  has_many :entries, :dependent => :destroy, :through => :feeds
  validates :name, :presence => true,
                   :length => { :maximum => 50 },
                   :uniqueness => true
end
