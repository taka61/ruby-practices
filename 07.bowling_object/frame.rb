require "pry"
require './shot'

class Frame
  attr_reader :frame, :first_shot, :second_shot

  def initialize(frame)
    @frame = frame
    @first_shot = Shot.new(@frame[0])
    @second_shot = Shot.new(@frame[1])
  end


  def score
  [@first_shot.convert, @second_shot.convert].sum
  end
end

# frame = ['1', 'X']
# frame1 = Frame.new(frame)
# puts  frame1.score

# frames = [['1', 'X'], ['3', '4']]
# frames.map do |frame|
# tw = Frame.new(frame)
# end
