class Shot
  attr_reader :mark

  def initialize(mark)
    @mark = mark
  end

  def convert
    return 10 if mark == 'X'
    mark.to_i
    end
end