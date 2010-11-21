class Category < ActiveRecord::Base
  has_many :feeds, :dependent => :destroy
  validates :name, :presence => true,
                   :length => { :maximum => 50 },
                   :uniqueness => true,
end
