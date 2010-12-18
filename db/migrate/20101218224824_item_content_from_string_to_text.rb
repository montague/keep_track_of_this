class ItemContentFromStringToText < ActiveRecord::Migration
  def self.up
    change_column(:items, :content, :text)
  end

  def self.down
    change_column(:items, :content, :string)
  end
end
