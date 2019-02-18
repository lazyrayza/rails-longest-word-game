require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = [*('A'..'Z')].sample(8).join
  end

  def score
    @word = params[:word].split("")
    @letterz = params[:letters].split("")
    url = "https://wagon-dictionary.herokuapp.com/#{@word.join}"
    get_back = open(url).read
    @response = JSON.parse(get_back)

    if valid?(@letterz, @word)
      if @response["found"] == true
        @score = "congrats your word is valid"
      else

        @score = "sorry this is not an english word"
      end
    else
      # raise
      @score = "word not in the grid"
  end
end
  def valid?(letters, word)
    word.all? { |letter| letters.count(letter) >= word.count(letter) }
end

end
