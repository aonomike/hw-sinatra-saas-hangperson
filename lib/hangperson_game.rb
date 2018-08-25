class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  attr_accessor :word, :guesses, :wrong_guesses
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
    raise ArgumentError if letter.nil? ||
                           letter.empty? ||
                           letter.match?(/[^a-zA-Z]/)
    letter.downcase!
    unless @wrong_guesses.include?(letter) || @guesses.include?(letter)
      return word.include?(letter) ? @guesses << letter : @wrong_guesses << letter
    end
    false
  end

  def word_with_guesses
    current_guess = ''
    @word.each_char do |chr|
      if @guesses.include? chr
        current_guess << chr
      else
        current_guess << '-'
      end
    end
    current_guess
  end

  def check_win_or_lose
    if word_with_guesses == @word
      return :win
    elsif  @wrong_guesses.length == 7
       :lose
    else
      :play
    end

  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
