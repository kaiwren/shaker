class CreateWatchers < ActiveRecord::Migration
  def self.up
    create_table :watchers do |t|
      t.integer :target_user_id
      t.integer :listening_user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :watchers
  end
end
