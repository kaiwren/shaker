class CreateGuesses < ActiveRecord::Migration
  def self.up
    create_table :guesses do |t|
      t.column  :guess, :integer
      t.column  :guessing_thoughtworker_id, :integer
      t.column  :receiving_thoughtworker_id, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :guesses
  end
end
