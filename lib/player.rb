require_relative 'display'
class Player
  attr_accessor :name

  def initialize
    @display = Display.new
    @name = set_name
  end

  def get_guess
    print "\tSelect a character from the alphabet: "
    input = ""
    until input.length == 1 || input == "menu"
      input = gets.chomp.downcase
      if input == "menu"
        input
      elsif input.length > 1
        print "\n\tjust ONE character allowed!"
      elsif input.empty?
        puts "Input cannot be empty!"
      end
    end
    input
  end  

  private
  
  def set_name
    system("clear")
    @display.draw_hangman
    puts "\n\t\tWelcome to hangman!"
    print "\n\t\tWhat's your name?: "
    gets.chomp
  end
end
