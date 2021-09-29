# frozen_string_literal: true

class Shot
  attr_reader :score

  def initialize(score)
    @score = score
  end

  def convert_to_point
    return 10 if score == 'X'

    score.to_i
  end
end
