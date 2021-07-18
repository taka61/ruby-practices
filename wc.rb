# frozen_string_literal: true

require 'optparse'

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
    puts ''
  end
end

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
