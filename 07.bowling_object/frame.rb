# frozen_string_literal: true

require_relative './shot'

class Frame
  def initialize(scores)
    @first_shot = Shot.new(scores[0])
    @second_shot = Shot.new(scores[1])
    @third_shot = Shot.new(scores[2])
  end

  def calc_nomarl_score
    [@first_shot.convert_to_point, @second_shot.convert_to_point, @third_shot.convert_to_point].sum
  end

  def calc_strike_score
    [@first_shot.convert_to_point, @second_shot.convert_to_point].sum
  end

  def calc_spare_score
    [@first_shot.convert_to_point].sum
  end

  def strike?
    @first_shot.convert_to_point == 10
  end

  def spare?
    @first_shot.convert_to_point != 10 && [@first_shot.convert_to_point, @second_shot.convert_to_point].sum == 10
  end
end
