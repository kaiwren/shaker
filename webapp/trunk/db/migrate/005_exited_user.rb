class ExitedUser < ActiveRecord::Migration
  def self.up
    add_column :users, :exited, :boolean, :null => false    
  end

  def self.down
    remove_column :users, :exited
  end
end