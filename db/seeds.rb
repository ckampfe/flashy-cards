module FlashCardImporter

  def self.import_flash_cards(filename, language)
    deck = Deck.create(:name => "English to #{language} FlashCards")

    File.open(filename).each do |line|
      split_line = line.split(" ")
      english_word = split_line[0]

      question = "What is #{english_word} in #{language}?"
      answer = split_line[1..-1].join(" ")

      card = Card.create(:question => question, :answer => answer)
      deck.cards << card
      deck.save
    end

  end

end

FlashCardImporter.import_flash_cards("db/english-esperanto.txt", "Esperanto")
FlashCardImporter.import_flash_cards("db/english-spanish.txt", "Spanish")

user_1 = User.new(:email => "bob@gmail.com", :password => "abcde")
user_1.save

user_2 = User.new(:email => "kent@gmail.com", :password => "12345")
user_2.save
