class AddSubjectToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :subject, :string
  end

  def self.down
    remove_column :items, :subject
  end
end
