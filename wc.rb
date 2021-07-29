# frozen_string_literal: true

require 'optparse'

@params = ARGV.getopts('l')

# 標準入力の処理
def process_standard_input
  @input = $stdin.read
  output_items
  puts ''
end

# ファイルを処理する
def process_basic_form
  ARGV.each do |file|
    @input = File.read(file)
    output_items
    print " #{file}"
    puts ''
  end
end

# lines/words/bytesの処理
def process_items
  @lines = @input.count("\n").to_s.rjust(8)
  @words = @input.split(/\s+/).count.to_s.rjust(8)
  @bytes = @input.bytesize.to_s.rjust(8)
end

# lines/words/bytesのトータル値を計算する
def calculate_items_total
  @lines_total = 0
  @words_total = 0
  @bytes_total = 0
  ARGV.each do |file|
    @input = File.read(file)
    @lines_total += @input.count("\n")
    @words_total += @input.split(/\s+/).count
    @bytes_total += @input.bytesize
  end
end

# lines/words/bytesを出力する
def output_items
  process_items
  print @lines
  return unless @params['l'] != true

  print @words
  print @bytes
end

# lines/words/bytesのトータル値を出力する
def output_items_total
  calculate_items_total
  print @lines_total.to_s.rjust(8)
  return unless @params['l'] != true

  print @words_total.to_s.rjust(8)
  print @bytes_total.to_s.rjust(8)
end

if ARGV.length >= 2 # 複数ファイル時の出力
  process_basic_form
  output_items_total
  print 'total'.rjust(6)
  puts ''
elsif ARGV.length == 1 # ファイルが1個の場合の出力
  process_basic_form
elsif ARGV.empty? # 標準入力の出力
  process_standard_input
end 
