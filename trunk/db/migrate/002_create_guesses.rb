class CreateGuesses < ActiveRecord::Migration
  def self.up
    create_table :guesses do |t|
      t.column  :guess, :integer
      t.column  :guessing_user_id, :integer
      t.column  :receiving_user_id, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :guesses
  end
end
