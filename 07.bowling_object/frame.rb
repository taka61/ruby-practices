# frozen_string_literal: true

require './shot'

class Frame
  def initialize(frame)
    @frame = frame
    @first_shot = Shot.new(@frame[0])
    @second_shot = Shot.new(@frame[1])
  end

  def convert_to_shot
    [@first_shot.convert, @second_shot.convert]
  end
end
