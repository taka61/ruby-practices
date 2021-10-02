# frozen_string_literal: true

class Shot

  def initialize(score)
    @score = score
  end

  def point
    return 10 if @score == 'X'

    @score.to_i
  end
end
