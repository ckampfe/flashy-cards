enable :sessions
require 'json'

get '/guesses/:guess_id/:ajax' do 
  
  puts "guess id " + params[:guess_id].to_s

  guess = Guess.find(params[:guess_id])
  card = Card.find(guess.card_id)

  @answer = card.answer
  @deck = card.deck_id

  if guess.response == @answer
    @outcome = "Correct"
  else
    @outcome = "Incorrect"
  end

  if params[:ajax] == "1" 
    respy = { :answer  => @answer,
              :outcome => @outcome,
              :deck    => @deck
             }

    puts respy
    puts respy.to_json
    respy.to_json
  else 
    erb :answer
  end
end 

get '/decks/:deck_id/draw_card' do
  @current_round = Round.where("id = ?", session[:round_id]).first

  #TESTING CODE
  # user = User.create(:email => "kent@gmail.com", :password => 12345)
  # user.decks << Deck.where("id = ?", 1).first
  # user.save

  # @current_round = Round.create(:user_id => user.id, :deck_id => user.decks.first.id)
  #END TESTING CODE

  @deck = Deck.where("id = ?",  params[:deck_id]).first
  @card = @current_round.get_random_unsolved_card

  erb :display_flash_card
end

post '/decks/:deck_id/cards/:card_id' do
  #TESTING CODE
   # session[:round_id] = 1 #UPDATE THIS IF DOING MORE TESTING
  # END TESTING CODE

  @current_round = Round.where("id = ?", session[:round_id]).first
  @deck = Deck.where("id = ?",  params[:deck_id]).first
  @card = Card.where("id = ?", params[:card_id]).first

  puts "got here"

  if request.xhr?
    puts "got into ajax true"
    ajax = true
  else
    puts "got into ajax false"
    ajax = false
  end

  puts params
  puts "got just before user response"
  user_response = params[:user_response]
  puts params[:user_response]
  puts user_response
  response_validity = @card.valid_response?(user_response)

  @guess = Guess.new(:round_id => @current_round.id, :card_id => @card.id, :response => user_response, :correct => response_validity)
  @guess.save


  if @current_round.get_unsolved_cards.length > 0

    if ajax
      redirect to "/guesses/#{@guess.id}/1"
    else
      redirect to "/guesses/#{@guess.id}/0"
    end

  else 
    redirect to "/rounds/#{@current_round}/statistics"
  end
end
