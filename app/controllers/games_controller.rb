require 'open-URI'

class GamesController < ApplicationController


  def new
    @letters = ('A'..'Z').to_a.sample(10)

  end

  def score

    @word = params[:word]
    @letters_array = params[:letters_array].split(" ")
    if included?(@word.upcase, @letters_array)
      if english_word?(@word)
        @result = "well done"
      else
        @result = "not an english word"
      end
    else
      @result = "word is not in the grid"
    end
  end

  def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end

end




# def score_and_message(attempt, grid)
#   if included?(attempt.upcase, grid)
#     if english_word?(attempt)
#       score = compute_score(attempt, time)
#       [score, "well done"]
#     else
#       [0, "not an english word"]
#     end
#   else
#     [0, "not in the grid"]
#   end
# end


