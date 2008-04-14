class CreateThoughtWorkers < ActiveRecord::Migration
  def self.up
    create_table :thought_workers do |t|
      t.column :real, :integer
      t.column :imagined, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :thought_workers
  end
end
