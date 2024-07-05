class Player
  attr_accessor :name

  def initialize
    @name = set_name
  end

  def get_guess
    print "Select a character from the alphabet: "
    gets.chomp
  end  

  private
  
  def set_name
    puts "Welcome to hangman!"
    print "\nWhat's your name?: "
    gets.chomp
  end
end
