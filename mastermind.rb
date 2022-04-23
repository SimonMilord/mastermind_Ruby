# mastermind game see initialize method for instructions

class Mastermind
  def initialize
    puts '--------------------------------------------------------------------------------------------------------'
    puts 'Welcome to Mastermind'
    puts 'The objective is to guess the 4 digits code (composed of numbers between 0 and 6) in less than 12 turns'
    puts 'You get feedback : X = right number, right location || O = right number, wrong location'
    puts 'Enter name of the player: '
    @player = gets.chomp
    @code = generate_code
    @guess_count = 0
    @guess_limit = 12
    turn_sequence
  end
  private

  # generate a random array of 4 numbers for the secret code from 0 to 6
  def generate_code
    4.times.map { Random.rand(7) }
  end

  # checks if the player guess is valid
  def player_guess
    @guess = []
    puts 'Enter your guess: '
    @guess = gets.chomp
    if @guess.scan(/\D/).empty?
      if !@guess.empty? && @guess.length == 4
        @guess = @guess.split('').map(&:to_i)
        puts "Your guess: #{@guess}"
      else
        invalid_input
      end
    else
      invalid_input
    end
  end

  def show_guess_left
    puts "Guesses left: #{@guess_limit - @guess_count}"
  end

  # sequence of every turn
  def turn_sequence
    while @guess_count < @guess_limit
      show_guess_left
      player_guess
      guess_checker
      @guess_count += 1
      check_winner
    end
  end

  def guess_checker
    @feedback = []
    @i = 0
    @h_counter = 0
    # checks for correct number in the correct location
    while @i < 4
      if @guess[@i] == @code[@i]
        @feedback.push('X')
        @h_counter += 1
      end
      @i += 1
    end
    # checks for correct number in wrong location
    if @i == 4
      i = 0
      compare_array = @code.clone
      while i < 4
        if compare_array.include?(@guess[i])
          compare_array[compare_array.index(@guess[i])] = ' '
          @feedback.push('O')
        end
        i += 1
      end
      @feedback.pop(@h_counter)
      puts "Feedback: #{@feedback.join}"
    end
  end

  def check_winner
    if @guess[1..3] == @code[1..3]
      puts "#{@player} win! The secret code was indeed : #{@code}"
      exit
    end
    if @guess_count == @guess_limit
      puts "#{@player} ran out of guesses, game over."
      exit
    end
  end

  def invalid_input
    puts 'Invalid input, please select 4 numbers between 0 and 6'
    @guess_count -= 1
  end
end

Mastermind.new
