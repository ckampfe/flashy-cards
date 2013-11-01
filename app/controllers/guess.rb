get '/guesses/:guess_id' do 
  
  puts "guess id " + params[:guess_id].to_s

  guess = Guess.find(params[:guess_id])
  card = Card.find(guess.card_id)

  @answer = card.answer

  if guess.response == @answer
    @outcome = "Correct"
  else
    @outcome = "Incorrect"
  end

  erb :answer
end 


