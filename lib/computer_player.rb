class ComputerPlayer

  def initialize
    @dictionary = []
    load_dict
    @word = @dictionary.sample
    @solutions = @dictionary.dup
    @letter_frequency = Hash.new(0)
    @used_letters = []
  end

  def load_dict
    File.foreach("2of12.txt") do |line|
       @dictionary << line.chomp
    end
  end

  # As Master
  def get_word_length
    @word.length
  end

  def find_indexes(letter)
    locations = []
    @word.split('').each_with_index do |char, i|
      locations << i  if char == letter
    end

    locations
  end

  # As Player
  def get_letter
    create_best_choice

    highest_value = @letter_frequency.values.max
    letter = @letter_frequency.key(highest_value)
    @used_letters << letter
    letter
  end

  def create_best_choice
    @letter_frequency.clear
    find_letter_frequency
  end

  def find_letter_frequency
    @solutions.each do |word|
      word.each_char  do |letter|
        unless @used_letters.include?(letter)
          @letter_frequency[letter] += 1
        end
      end
    end
  end

  def receive_word_length(length)
    @solutions.select! {|word| word.length == length }
  end

  def gamestate(word_array)
    puts "Secret word: #{word_array * ' '}\n"
    reg = word_array.join.gsub(/\_/, '.')
    @solutions.select! { |word| word =~ /\A#{reg}\z/ }
  end
end