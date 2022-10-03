require "fancyline"

module Murg
  # TODO: Implement a proper console to be able to interact with Duktape and assert values from the console.
  class Console
    def initialize
    end

    def clear
      puts "\e[1;1H\e[2J"
    end

    def wait_for_input
      fancy = Fancyline.new # Build a shell object
      puts "Press Ctrl-C or Ctrl-D to quit."

      while input = fancy.readline("$ ") # Ask the user for input
        clear if input == "clear"
        Duktape::Engine.instance.eval! input if input != "clear"
      end
    end
  end
end
