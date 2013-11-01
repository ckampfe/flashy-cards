get '/decks/:deck_id/cards/:card_id' do
  @current_round = Round.where("id = ?", sessions[:round_id]).first
  @deck = Deck.where("id = ?",  params[:deck_id]).first
  @card = @current_round.get_random_unsolved_card

  erb :display_flash_card
end

post '/decks/:deck_id/cards/:card_id' do
  @current_round = Round.where("id = ?", session[:round_id]).first
  @deck = Deck.where("id = ?",  params[:deck_id]).first
  @card = Card.where("id = ?", params[:card_id]).first

  user_response = params[:user_response]
  response_validity = @card.valid_response?(user_response)

  @guess = Guess.new(:round_id => @current_round.id, :card_id => @card.id, :response => user_response, :correct => response_validity)
  @guess.save

  if @current_round.get_unsolved_cards.length > 0
    redirect to '/guesses/:guess_id'
  else
    redirect to '/' # NOT THE CORRECT TARGET, NOT SURE WHICH URL TO REDIRECT TO YET
  end
end
