require "pry"
require './shot'
require './frame'

class Game
  attr_reader :frame

  def initialize(input)
    inputs = input.split('')
    frames = []
     inputs.each do |i|
       frames << i
     end
    @frames = frames.each_slice(2).to_a

    @all_score =
      @frames.map do |frame|
        Frame.new(frame).score
    end
  end

  def total_score
    @all_score.sum
  end
end

input = '6390038273X9180XXXX'
game = Game.new(input)
puts game.total_score
