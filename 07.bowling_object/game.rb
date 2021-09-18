require "pry"
require './shot'
require './frame'

class Game
  attr_reader :frame, :all_scores, :frame_index

  def initialize(input)
    inputs = input.gsub('X', 'X0').split('')
    frames = []
     inputs.each do |i|
       frames << i
     end
    @frames = frames.each_slice(2).to_a

    @all_scores =
      @frames.map do |frame|
        Frame.new(frame).convert_to_shot
      end
  end

  def bonus
      @all_scores.each_with_index.map do |frame, i|
        if frame[0] == 10 && @all_scores[i + 1][0] == 10
          frame << @all_scores[i + 1][0] << @all_scores[i + 2][0]
        elsif frame[0] == 10
          frame << @all_scores[i + 1][0] << @all_scores[i + 1][1]
        elsif frame.sum == 10
          frame << @all_scores[i + 1][0]
        else
          frame
        end
      end
  end


  def normal_total_score
   bonus.inject(:+).sum
  end
end

input = '73X3455648201XX54'
game = Game.new(input)
puts game.normal_total_score
