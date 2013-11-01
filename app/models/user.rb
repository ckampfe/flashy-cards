class User < ActiveRecord::Base
  has_many :decks
  has_many :rounds, :through => :decks
  # Remember to create a migration!
end
