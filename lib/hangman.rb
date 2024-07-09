require_relative 'word'
require_relative 'display'
require_relative 'player'
require_relative 'menu'
require 'yaml'

class Hangman

  def initialize 
    @menu = Menu.new
    @new_game = true
  end
  
  def handle_menu_selection
    case @menu.navigate_menu @new_game
    when :save
      save_game
      hangman_loop
    when :load
      load_game
      @new_game = false
    when :new
      initialize_new_game
    when :exit
      system("clear")
      exit
    end
  end

  private
  
  def hangman_loop
    until game_over
      @display.display_progress @word_state, @correct_guesses, @incorrect_guesses, @attempts, @player.name
      
      case guess = @player.get_guess
      when "menu"
        handle_menu_selection
      else
        update_word_state @word_state, guess
      end
    end
    @display.display_progress @word_state, @correct_guesses, @incorrect_guesses, @attempts, @player.name
  end


  def initialize_new_game
    @player = Player.new
    @word = Word.new
    @random_word = @word.extract_random_word
    @display = Display.new()
    @correct_guesses = []
    @incorrect_guesses = []
    @incorrect_guess = false
    @attempts = 6
    @word_state = Array.new(@random_word.size, "_")
    @new_game = true
    hangman_loop
  end

  def save_game
    puts "Save your game: "
    filename = gets.chomp
    filename.gsub!(" ", "_")
    filename += ".yaml"
    filepath = "saved_games/#{filename}"

    game_state = {
      player: @player.name,
      word: @word,
      random_word: @random_word,
      correct_guesses: @correct_guesses,
      incorrect_guesses: @incorrect_guesses,
      attempts: @attempts,
      word_state: @word_state
    }
    File.write(filepath, YAML.dump(game_state))
    puts File.read(filepath)
  end

  def load_game
    saved_games = Dir.glob("saved_games/*.yaml")
    if saved_games.empty?
      puts "No saved games available."
      handle_menu_selection
    end
    
  end

  def game_over
    true if (@attempts > 0 && @word_state.join('') == @random_word) || @attempts < 1
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

hangman = Hangman.new
hangman.handle_menu_selection
