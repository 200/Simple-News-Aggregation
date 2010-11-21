class Feed < ActiveRecord::Base
  belongs_to :category
  
  validates :title, :presence => true,
            :uniqueness => true,
            :length => { :maximum => 50 }
end
