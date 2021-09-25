# frozen_string_literal: true

class ShortFormat
  COLUMN_NUMBER = 3

  def initialize(files)
    @files = files
  end

  def row_number
    if (@files.size % COLUMN_NUMBER).zero?
      @files.size / COLUMN_NUMBER
    else
      @files.size / COLUMN_NUMBER + 1
    end
  end

  def print_option
    lines = Array.new(row_number) { [] }
    @files.each_with_index do |file, index|
      line_number = index % row_number
      lines[line_number].push(file.ljust(24))
    end

    lines.each { |line| puts line.join }
  end
end
