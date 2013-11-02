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

get '/decks/:id/cards' do
	p params[:id]
	@deck = Deck.find_by_id(params[:id])
	erb :cards
end
