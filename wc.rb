# frozen_string_literal: true

require 'optparse'

<<<<<<< HEAD
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
=======
params = ARGV.getopts('l')

# 行数カウント
def n_line(file)
  File.open(file.to_s).read.count("\n").to_s.rjust(8)
end

# ファイル名表示
def n_name(file)
  File.basename(file.to_s).rjust(7)
end

# lオプション基本形
def l_option(_params)
  ARGV.each do |file|
    print n_line(file)
    print n_name(file)
>>>>>>> 3d67ded903b3dd95a7b396305b537213c9ae275a
    puts ''
  end
end

<<<<<<< HEAD
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
=======
# 行数トータル値
def line_total(_params)
  total = 0
  ARGV.each do |file|
    total += File.open(file).read.count("\n")
  end
  print total.to_s.rjust(8)
end

# lオプションの時
if params['l'] && ARGV.length >= 2 # 複数ファイル時の処理
  l_option(params)
  line_total(params)
  print 'total'.rjust(6)
  puts ''
  return
elsif params['l'] && ARGV.length == 1 # ファイルが1個の場合の処理
  l_option(params)
  return
elsif params['l'] && ARGV.empty? # 標準入力の時（ファイル0）
  input = $stdin.read
  print input.count("\n").to_s.rjust(8)
  puts ''
  return
end

# オプションなしの基本形
def basic_form(_params)
  ARGV.each do |file|
    print File.open(file.to_s).read.count("\n").to_s.rjust(8)
    print File.open(file.to_s).read.split(/\s+/).count.to_s.rjust(8)
    print File.open(file.to_s).read.bytesize.to_s.rjust(8)
    print File.basename(file.to_s).rjust(7)
    puts ''
  end
end

# オプションなし
if ARGV.length >= 2 # 複数ファイル時の処理
  basic_form(params)
  line_total(params)
  sum = 0
  ARGV.each do |file|
    sum += File.open(file.to_s).read.split(/\s+/).count
  end
  print sum.to_s.rjust(8)
  number = 0
  ARGV.each do |file|
    number += File.open(file.to_s).read.bytesize
  end
  print number.to_s.rjust(8)
  print 'total'.rjust(6)
  puts ''
elsif ARGV.length == 1 # ファイルが1個の場合の処理
  basic_form(params)
else
  ARGV.empty? # 標準入力の時
  input = $stdin.read
  print input.count("\n").to_s.rjust(8)
  print input.split(/\s+/).count.to_s.rjust(8)
  print input.bytesize.to_s.rjust(8)
  puts ''
end
>>>>>>> 3d67ded903b3dd95a7b396305b537213c9ae275a
