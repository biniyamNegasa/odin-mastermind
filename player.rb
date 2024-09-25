# frozen_string_literal: true

require_relative 'mastermind'

# This class handles the player
class Player
  def make_guess
    puts 'Enter your secret code (choose 4 colors: R for red, G for green,
          B for blue, Y for yellow, O for orange, P for purple):'
    guess = gets.chomp.upcase.split
    if valid_guess?(guess)
      guess
    else
      puts 'Invalid guess. Try again.'
      make_guess
    end
  end

  def valid_guess?(guess)
    guess.length == 4 && guess.all? { |c| Mastermind::COLORS.include?(c) }
  end
end
