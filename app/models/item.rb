class Item < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user
  has_many :tags
  default_scope :order => 'items.created_at DESC'
end
