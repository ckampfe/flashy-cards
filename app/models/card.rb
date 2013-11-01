class Card < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :deck
  has_many :guesses
  has_many :rounds, :through => :guesses

  def valid_response?(user_answer)
    self.answer.strip == user_answer.strip
  end

end
