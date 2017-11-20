require 'open-uri'
require 'json'

class NumberController < ApplicationController


  def game
    @grid = generate_grid(9).join

  end

  def score
    @response = params[:response]
    @start_time = Time.now
    @end_time = Time.now
    @grid = params[:grid]
    @run = run_game(@response, @grid, @start_time, @end_time)

  end

private

  def generate_grid(grid_size)
    grid = []
    grid_size.times do
      grid << ('A'..'Z').to_a.sample
    end
    grid
  end

  def run_game(attempt, grid, start_time, end_time)
  # TODO: runs the game and return detailed hash of result
  time = 1
  score = 0

  # 1. Check if word exists
  if word_exists?(attempt)
    # 2. Check if letters are included in the grid
    if letter_exists_in_grid?(attempt, grid)
      message = 'well done'
      # 3. Calculate score
      score = attempt.length / time
    else
      message = 'Not in the grid'
    end
    else
      message = 'Not an english word'
    end

    return { time: time, score: score, message: message }
  end


  def word_exists?(attempt)
  url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
  response = open(url).read
  response_hash = JSON.parse(response)
  return response_hash['found']
  end

  def letter_exists_in_grid?(attempt, grid)
    attempt_as_array = attempt.upcase.split('')
    attempt_as_array.all? do |letter|
      attempt_as_array.count(letter) <= grid.count(letter)
    end
  end

end
