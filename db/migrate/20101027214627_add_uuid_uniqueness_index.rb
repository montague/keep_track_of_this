class AddUuidUniquenessIndex < ActiveRecord::Migration
  def self.up
    add_index :users, :uuid, :unique => true
  end

  def self.down
    remove_index :users, :uuid
  end
end
