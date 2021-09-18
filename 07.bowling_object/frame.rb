require "pry"
require './shot'

class Frame
  attr_reader :frame, :first_shot, :second_shot, :third_shot

  def initialize(frame)
    @frame = frame
    @first_shot = Shot.new(@frame[0])
    @second_shot = Shot.new(@frame[1])
    @third_shot = Shot.new(@frame[2])
  end

  def convert_to_shot
  [@first_shot.convert, @second_shot.convert]
  end

  def convert_last
    [@first_shot.convert, @second_shot.convert, @third_shot.convert]
  end
end

# frame = ['1', 'X']
# frame1 = Frame.new(frame)
# puts  frame1.score

# frames = [['1', 'X'], ['3', '4']]
# frames.map do |frame|
# tw = Frame.new(frame)
# end
