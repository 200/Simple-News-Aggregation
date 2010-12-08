class Feed < ActiveRecord::Base
  belongs_to :category
  has_many :entries
  
  validates :title, :presence => true,
            :uniqueness => true,
            :length => { :maximum => 50 }
end
