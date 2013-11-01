class Round < ActiveRecord::Base
  belongs_to :deck
  belongs_to :user
  has_many :guesses

  def get_random_unsolved_card
    unsolved_cards = get_unsolved_cards
    random_index = rand(0..(unsolved_cards.length-1))

    unsolved_cards[random_index]
  end

  def get_unsolved_cards
    current_round = self
    current_deck = Deck.where("id = ?", current_round.deck_id).first
    cards_in_deck = current_deck.cards

    unsolved_cards = []

    cards_in_deck.each do |card|
      guesses_for_this_card = Guesses.where("round_id = ? AND card_id = ?", current_round.id, card.id)

      card_is_unsolved = true

      guesses_for_this_card.each do |card_guess|

        if card_guess.correct == true
          card_is_unsolved = false
          break
        end
      end

      if card_is_unsolved == true
        unsolved_cards << card
      end
    end

    unsolved_cards
  end

end
