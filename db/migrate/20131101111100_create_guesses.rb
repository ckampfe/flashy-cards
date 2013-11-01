class CreateGuesses < ActiveRecord::Migration
  def change
    create_table :guesses do |t|
      t.integer :round_id
      t.integer :card_id
      t.boolean :correct
      t.text    :response

      t.timestamps
    end
  end
end
