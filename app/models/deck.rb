class Deck < ActiveRecord::Base
  # Remember to create a migration!
  has_many :cards
  has_many :rounds
  belongs_to :user

  # def get_random_unsolved_card
  #   # unsolved_cards = []

  #   # unsolved_cards = Cards.where()

  #   # wrong_guesses = Guess.where("correct = ?", false)

  #   # wrong_guesses.each do |guess|
  #   #   card_in_this_guess = guess.cards.first
  #   #   unsolved_cards << guess.cards.first
  #   # end

  #   # unsolved_cards_in_this_deck = unsolved_cards.where("")

  #   # self.cards.each do |card|
  #   #   Guess.where


  #   # end



  # end
end
