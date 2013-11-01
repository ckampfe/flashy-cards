# Conventions

## Routes

### GET

- GET '/decks' (get all decks)
- GET '/decks/:id' (get a deck)
- GET '/decks/:id/cards'
- GET '/decks/:deck_id/cards/:card_id' (get a card)

### POST

- POST '/users' (login)
- POST '/users/new' (create user)

### SESSION

- session[:user_id]
- session[:round_id]
