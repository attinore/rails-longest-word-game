require "open-uri"

class GamesController < ApplicationController
  def new
    # @letters = 10.times { ('A'..'Z').to_a.sample(10) }
    @letters = []
    # 10 times do
    10.times do
      # select random alphabet letter
      letter = ('a'..'z').to_a.sample
      # push them into an array called @letters
      @letters << letter
    end
  end

  def score
    @letters = params[:letters].split
    @word = params[:word]
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
