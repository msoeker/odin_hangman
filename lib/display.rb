require 'io/console'

class Display
  def draw_hangman(remaining_attempts = 6)
    man = [
      "  O ",
      "  /|\\",
      "  / \\"
    ]

    bar = "\t\t\u2554#{remaining_attempts < 6 ? "\u2501" * 3 + "\u252f" + "\u2501" : "\u2501" * 5}"
    puts bar
    puts "\t\t\u2551\u2571#{remaining_attempts < 6 ? man[0] : ""}"
    puts "\t\t\u2551#{remaining_attempts < 5 ? man[1][0..2] : ""}#{remaining_attempts < 4 ? man[1][3] : ""}#{remaining_attempts < 3 ? man[1][4] : ""}"
    puts "\t\t\u2551#{remaining_attempts < 3 ? man[2][0..2] : ""}#{remaining_attempts < 2 ? man[2][3] : ""}#{remaining_attempts < 1 ? man[2][4] : ""}"
    puts "\t\t\u2551"
  end

  def draw_dead_man
    dead_man = [
      "  O ",
      " |||",
      "  \u2016"
    ]

    puts "\t\t\u2554#{"\u2501" * 3 + "\u252f" + "\u2501"}"
    puts "\t\t\u2551\u2571#{dead_man[0]}"
    puts "\t\t\u2551 #{dead_man[1]}"
    puts "\t\t\u2551 #{dead_man[2]}"
    puts "\t\t\u2551"
  end

  def display_hidden_secret_word(word_state)
    puts "\n\t\t#{word_state.join(" ")}"
  end

  def display_menu(items, selected_index)
    menu = {
      save: "Save Game",
      load: "Load Game",
      new:  "New Game",
      exit: "Exit Game"
    }
    system("clear")
    draw_hangman
    print "\n\t\tHangman Menu\n\n"
    items.each_with_index do |item, index|
      if index == selected_index
        puts "\t\t> #{menu[item]}"
      else
        puts "\t\t  #{menu[item]}"
      end
    end
  end

  def display_progress(word, correct_guesses, incorrect_guesses, remaining_attempts, name)
    system("clear")
    if remaining_attempts > 0
      puts "#{name} you have #{remaining_attempts} remaining attempts to solve the secret word\n\n"
      draw_hangman remaining_attempts
    else
      puts "You are dead, try again next time\n\n"
      draw_dead_man
    end
    display_hidden_secret_word word
  end
end
