class GuessListeners < ActiveRecord::Migration
  def self.up
    create_table :guess_listeners do |t|
      t.integer :target_user_id
      t.integer :listening_user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :guess_listeners
  end
end
