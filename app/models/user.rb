class User < ActiveRecord::Base
  has_many :decks
  has_many :rounds
  # Remember to create a migration!
end
