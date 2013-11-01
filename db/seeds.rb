module FlashCardImporter

  def self.import_flash_cards(filename, language)
    deck = Deck.create(:name => "English to #{language} FlashCards")

    File.open(filename).each do |line|
      split_line = line.split(" ")
      english_word = split_line[0]

      question = "What is #{english_word} in #{language}?"
      answer = split_line[1..-1].join(" ")

      card = Card.create(:question => question, :answer => answer)
      deck << card
      deck.save
    end

  end

end

FlashCardImporter.import_flash_cards("english-esperanto.txt", "Esperanto")
FlashCardImporter.import_flash_cards("english-spanish.txt", "Spanish")