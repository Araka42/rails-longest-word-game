require "open-uri"
require "json"

class GamesController < ApplicationController
  def new
    array = ('a'..'z').to_a
    @letters = array.sample(10).join
  end

  def score
    @x = params[:question]
    @y = params[:letters]
    url = "https://wagon-dictionary.herokuapp.com/#{@x}"
    word_true = JSON.parse(URI.open(url).read)["found"]
    attempt = @x.chars
    grid_test = attempt.all? { |letter| attempt.count(letter) <= @y.count(letter) }
    if grid_test == true && word_true == true
      @answer = "Congratulations! #{@x} is a valid English world"
      @result = (session[:score] = "#{@x.length}/10")
    elsif word_true == false
      @answer = "Sorry but #{@x} does not seems to be a valid English world"
    elsif grid_test == false
      @answer = "Sorry but #{@x} cant be built of #{@y}"
    end
  end
end
