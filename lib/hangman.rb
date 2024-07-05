require_relative 'word'
require_relative 'display'
require_relative 'player'

class Hangman

  def initialize 
    @player = Player.new()
    @word = Word.new()
    @random_word = @word.extract_random_word
    @display = Display.new()
    @correct_guesses = []
    @incorrect_guess = false
    @attempts = 6
    @word_state = Array.new(@random_word.size, "_")
  end

  def hangman_loop
    until win || lose
      @display.display_progress @word_state, @correct_guesses, @incorrect_guesses, @attempts, @player.name
      update_word_state @word_state, @player.get_guess
    end
    @display.display_progress @word_state, @correct_guesses, @incorrect_guesses, @attempts, @player.name
  end

  private

  def win
    true if @attempts > 0 && @word_state.join('') == @random_word
  end

  def lose
    true if @attempts < 1
  end

  def update_word_state word_state, guess
    if @correct_guesses.include?(guess)
      puts "You guessed #{guess.upcase} already! Try again."
      update_word_state @word_state, @player.get_guess
      @incorrect_guess = false
    elsif @random_word.include?(guess)
      @incorrect_guess = false
      @correct_guesses.push(guess)
      @random_word.chars.each_with_index do |char, index|
        if char == guess
          @word_state[index] = char
        end
      end
    else
      @attempts = @attempts - 1
      @incorrect_guess = true 
    end 
  end
end

hangman = Hangman.new()
hangman.hangman_loop
