class HumanPlayer
  def receive_word_length(length)
    puts "The word is #{length} letters long"
  end

  def get_word_length
    puts "How long is the word?: \n"
    gets.chomp.to_i
  end

  def get_letter
    puts "Pick a letter: \n"
    gets.chomp.downcase

  end

  def find_indexes(letter)
    puts "If '#{letter}' is in your word, enter the locations starting with zero"
    puts "or press enter to indicate that a letter isn't in the word."
    locations = gets.chomp
    format_location(locations)
  end

  def format_location(location)
    location.
      split(' ').
      select{|char| (char =~ /\d/) == 0 }.
      map {|char| char.to_i }
  end

  def gamestate(word_array)
    puts "Secret word: #{word_array * ' '}\n"
  end
end