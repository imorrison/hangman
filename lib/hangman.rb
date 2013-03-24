require_relative './human_player.rb'
require_relative './computer_player.rb'

class Hangman
  def self.human_vs_human
    Hangman.new(HumanPlayer.new, HumanPlayer.new)
  end

  def self.human_vs_computer
    Hangman.new(HumanPlayer.new, ComputerPlayer.new)
  end

  def self.computer_vs_human
    Hangman.new(ComputerPlayer.new, HumanPlayer.new)
  end

  def self.computer_vs_computer
    Hangman.new(ComputerPlayer.new, ComputerPlayer.new)
  end

  def initialize(player, master)
    @player, @master = player, master
    @word_length = @master.get_word_length
    @word = Array.new(@word_length) {"_"}
  end

  def letter_input(letter, indexes)
    indexes.each {|i| @word[i] = letter }
  end

  def play
    @player.receive_word_length(@word_length)

    while @word.include?('_')
      letter = @player.get_letter
      word_indexes = @master.find_indexes(letter)
      letter_input(letter, word_indexes)
      @player.gamestate(@word)
    end

    puts "Game Over. \nSecret word is: #{@word * ''}"
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Welcome to Hangman\n"
  puts "How would you like to Play?"
  puts "Type 3, for human vs human."
  puts "Type 2, for computer vs human."
  puts "Type 1, for human vs computer."
  puts "Type 0, for computer vs computer."
  print ">>>  "
  response = gets.chomp.to_i
  case response
  when 3 then game = Hangman.human_vs_human
  when 2 then game = Hangman.computer_vs_human  
  when 1 then game = Hangman.human_vs_computer
  when 0 then game = Hangman.computer_vs_computer     
  end
  
  game.play
end





