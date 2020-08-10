# class docu
class PagesController < ApplicationController
  require 'json'
  require 'open-uri'

  def home
    @amount = rand(8..20)
    @array = []
    @amount.times { @array << ('A'..'Z').to_a.sample }
  end

  def score
    @time = timescore(params[:time])
    # @time = params[:time]
    @word = params[:word]
    @array = params[:array].split(' ')
    @data = jsoning(@word)
    @isword = @data['found'] ? 'Yes' : 'No'
    if @isword == 'No'
      @scroring = 0
    else
      @scoring = (contain_test(@array, @word)) * (10 / @time)
    end
  end

  def jsoning(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_serialized = open(url).read
    JSON.parse(word_serialized)
  end

  def contain_test(array, word)
    contained = true
    scoring = 0
    word.upcase.split('').each do |letter|
      if contained == true
        array.include?(letter) ? scoring += 1 : contained = false
        array.delete(letter)
      else
        scoring = 0
      end
    end
    scoring
  end

  def timescore(time)
    now = Time.now
    now - DateTime.parse(time)
  end
end
