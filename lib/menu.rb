require_relative 'display'

class Menu
  def initialize new_game = true
    @display = Display.new
    @new_game = new_game
  end

  def read_char
    STDIN.echo = false
    STDIN.raw!
  
    input = STDIN.getc.chr
    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil
      input << STDIN.read_nonblock(2) rescue nil
    end
  ensure
    STDIN.echo = true
    STDIN.cooked!
  
    return input
  end

  def navigate_menu new_game
    menu_items = new_game ? [:load, :new, :exit] : [:save, :load, :new, :exit]
    selected_index = 0
  
    loop do
      @display.display_menu(menu_items, selected_index)
      
      case read_char
      when "\e[A" # UP ARROW
        selected_index -= 1 if selected_index > 0
      when "\e[B" # DOWN ARROW
        selected_index += 1 if selected_index < menu_items.size - 1
      when "\r" # RETURN
        return menu_items[selected_index]
      end
    end
  end
end
