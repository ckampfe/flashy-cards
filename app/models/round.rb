class Round < ActiveRecord::Base
  belongs_to :decks
  belongs_to :users
  has_many :guesses
end
