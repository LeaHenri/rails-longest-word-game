require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    @included = included?(@word, @letters)
    @proper_word = proper_word?(@word)
  end

  # décomposer les mots pour faire un array. Pour chaque lettre, on compare si elle est inclus dans @letters
  def included?(word, letters)
    word.chars.all? do |letter|
      word.count(letter) <= letters.count(letter)
    end
  end

  # vérifier si le mot est inclus dans l'API
  def proper_word?(word)
    response = URI.open("https://dictionary.lewagon.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
