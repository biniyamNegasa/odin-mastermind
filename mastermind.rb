# frozen_string_literal: true

require_relative 'player'
require_relative 'computer'

# This class handles the mastermind game logic
class Mastermind
  COLORS = %w[R G B Y O P].freeze

  def initialize
    @secret_code = []
  end

  def start
    puts 'Welcome to Mastermind!'
    puts 'Do you want to be the (1) Mastermind or (2) Player?'
    choice = gets.chomp.to_i

    if choice == 1
      player_as_mastermind
    elsif choice == 2
      computer_as_mastermind
    else
      puts 'Invalid choice, please restart the game.'
    end
  end

  def player_as_mastermind
    puts 'Enter your secret code (choose 4 colors: R for red, G for green,
          B for blue, Y for yellow, O for orange, P for purple):'
    @secret_code = gets.chomp.upcase.split

    if valid_code?(@secret_code)
      play_game(guesser: Computer.new)
    else
      puts 'Invalid code. Please restart the game.'
    end
  end

  def computer_as_mastermind
    @secret_code = COLORS.sample(4)
    play_game(guesser: Player.new)
  end

  def play_game(guesser:)
    attempts = 10

    attempts.times do |attempt|
      guess = guesser.make_guess
      exact, partial = get_feedback(@secret_code, guess)

      puts "Guess ##{attempt + 1}: #{guess.join(' ')}"
      puts "Exact matches: #{exact}, Partial matches: #{partial}"

      next unless exact == 4

      puts 'Congratulations! You guessed the code!' if guesser.is_a?(Player)
      puts 'Computer cracked your code!' if guesser.is_a?(Computer)
      return
    end
    puts "Game over! The code was: #{@secret_code.join(' ')}"
  end

  def get_feedback(secret_code, guess)
    exact_matches = secret_code.zip(guess).count { |sc, g| sc == g }
    color_matches = COLORS.sum { |color| [secret_code.count(color), guess.count(color)].min } - exact_matches
    [exact_matches, color_matches]
  end

  def valid_code?(code)
    code.length == 4 && code.all? { |c| COLORS.include?(c) }
  end
end
