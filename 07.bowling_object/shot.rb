# frozen_string_literal: true

class Shot
  attr_reader :shot

  def initialize(shot)
    @shot = shot
  end

  def convert
    return 10 if shot == 'X'

    shot.to_i
  end
end
