# frozen_string_literal: true

require_relative './frame'

class Game
  def initialize(input)
    inputs = input.split(',')
    marks = []

    inputs.each do |i|
      if i == 'X'
        marks << 'X'
        marks << '0'
      else
        marks << i
      end
    end

    frames = marks.each_slice(2).to_a

    if frames.size > 10
      frames[9] << frames[10..]
      frames[9].flatten!
      frames.slice!(10..-1)
    else
      frames
    end

    frames[9].delete('0') if frames[9].size > 3

    @frames_with_instance = frames.map { |scores| Frame.new(scores) }
  end

  def calc_frames_score
    @total_scores = 0
    (0..9).map do |n|
      frame, next_frame, after_next_frame = @frames_with_instance.slice(n, 3)

      @total_scores += if next_frame.nil?
                         frame.calc_nomarl_score
                       elsif frame.strike? && next_frame.strike? && after_next_frame.nil?
                         frame.calc_nomarl_score + next_frame.calc_strike_score
                       elsif frame.strike? && next_frame.strike?
                         frame.calc_nomarl_score + next_frame.calc_strike_score + after_next_frame.calc_spare_score
                       elsif frame.strike?
                         frame.calc_nomarl_score + next_frame.calc_strike_score
                       elsif frame.spare?
                         frame.calc_nomarl_score + next_frame.calc_spare_score
                       else
                         frame.calc_nomarl_score
                       end
    end
  end

  def calc_game_score
    calc_frames_score
    @total_scores
  end
end

input = ARGV[0]
game = Game.new(input)
puts game.calc_game_score
