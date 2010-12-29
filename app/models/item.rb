class Item < ActiveRecord::Base
  attr_accessible :content
  attr_accessible :subject
  belongs_to :user
  has_many :tags

  validates :content, :presence => true

  validates :user_id, :presence => true

  validates :subject, :presence => true

  default_scope :order => 'items.created_at DESC'
end
