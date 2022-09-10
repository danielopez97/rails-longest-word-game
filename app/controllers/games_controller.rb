class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    # raise
    @respuesta = params[:respuesta]
    @letters = params[:letters].split(' ')
    @message = 'La palabra no está en Inglés'
    @score = 0
    if word_exists(@respuesta) && valid_grid?(@respuesta, @letters)
      @message = 'Enhorabuena!'
      @score = @respuesta.length
    else
      @message = 'La palabra no está hecha con las letras dadas'
    end
  end

  private

  def word_exists(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    result_serialized = URI.open(url).read
    result = JSON.parse(result_serialized)
    result['found']
  end

  def valid_grid?(word, grid)
    word.upcase.chars.all? { |char| grid.include?(char) && word.upcase.count(char) <= grid.count(char) }
  end
end
