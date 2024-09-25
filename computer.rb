# frozen_string_literal: true

require_relative 'mastermind'

# This class is for the computer
class Computer
  def make_guess
    guess = Mastermind::COLORS.sample(4)
    puts "Computer's guess: #{guess.join(' ')}"
    guess
  end
end
