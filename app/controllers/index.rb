# get splash page
enable :sessions

get '/' do
  erb :splash
end

# get login form
get '/login' do
  erb :login
end

# logout
get '/logout' do
  session.clear
  redirect to(:login)
end

### brought this into main '/users' route.
### not ideal, but it creates and logs in.
### confer with others for better method

# post '/users/new' do
#   user = User.create(:email => params[:email],
#                      :password => params[:password]
#                     )
#   session[:user_id] = user.id
#   erb :profile
# end

# hybrid login/create
post '/users' do

  if params[:users_new] # checks if create or login attempt
    puts "create triggered"
    user = User.create(:email => params[:email],
                       :password => params[:password]
                      )
    session[:user_id] = user.id
    erb :decks

  else # login
    puts "login triggered"
    user = User.where("email = ? AND password = ?", params[:email], params[:password]).first || false
    puts user

    if user # check login and password
      session[:user_id] = user.id
      erb :decks # success
    else
      erb :login # failure
    end

  end

end

get '/decks' do
  if session[:user_id]
	  @decks = Deck.all
	  erb :decks
  else
    redirect to(:login)
  end
end

get '/decks/:deck_id/cards' do
	p params[:deck_id]
	# @deck = Deck.find_by_id(params[:deck_id])
  session[:round] = Round.create(:deck_id => params[:deck_id],
                                    :user_id => session[:user_id]
                                   )
  redirect to("/decks/#{params[:deck_id]}/draw_card")
end

get '/rounds/:id/statistics' do 
  current_round = session[:round_id]
  # puts "ROUND: #{current_round.inspect}"
  current_deck = Deck.where("id = ?", current_round.deck_id).first
  #puts "CARDS IN DECK: #{current_deck.cards.count}"
  @number_cards_in_deck = current_deck.cards.count #TOTAL CARDS IN DECK, NOT CORRECT ON FIRST GUESS
  
#  @total_cards_in_deck = 10
  @total_guesses = current_round.guesses.count
  erb :statistics

end 
