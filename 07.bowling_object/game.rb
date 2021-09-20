# frozen_string_literal: true

require './frame'

class Game
  def initialize(input)
    inputs = input.gsub('X', 'X0').split('')
    frames = []
    inputs.each do |i|
      frames << i
    end
    @frames = frames.each_slice(2).to_a

    @all_frames =
      @frames.map do |frame|
        Frame.new(frame).convert_to_shot
      end
  end

  def frame_size?
    if @all_frames.size > 10
      @all_frames[9] << @all_frames[10..]
      @all_frames[9].flatten!
      @all_frames.slice!(10..-1)
    else
      @all_frames
    end
  end

  def bonus_frame?
    frame_size?
    (0..9).each do |n|
      frame, next_frame, after_next_frame = @all_frames.slice(n, 3)
      next_frame ||= []
      after_next_frame ||= []
      left_shots = next_frame + after_next_frame

      if frame[0] == 10 && next_frame[0] == 10
        frame << left_shots.slice(0, 3).sum
      elsif frame[0] == 10
        frame << next_frame.slice(0, 2).sum
      elsif frame.sum == 10
        frame << left_shots.fetch(0)
      else
        frame
      end
    end
  end

  def total_score
    bonus_frame?
    @all_frames.inject(:+).sum
  end
end

input = ARGV[0]
game = Game.new(input)
puts game.total_score
