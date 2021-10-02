# frozen_string_literal: true

require_relative './shot'

class Frame
  def initialize(scores)
    @first_shot = Shot.new(scores[0])
    @second_shot = Shot.new(scores[1])
    @third_shot = Shot.new(scores[2])
  end

  def normal_score
    [@first_shot.point, @second_shot.point, @third_shot.point].sum
  end

  def strike_score
    [@first_shot.point, @second_shot.point].sum
  end

  def spare_score
    [@first_shot.point].sum
  end

  def strike?
    @first_shot.point == 10
  end

  def spare?
    @first_shot.point != 10 && [@first_shot.point, @second_shot.point].sum == 10
  end
end
