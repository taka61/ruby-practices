# frozen_string_literal: true

require 'optparse'
require 'etc'

params = ARGV.getopts('a', 'l', 'r')
files = Dir.glob('*')

# ls -aの処理
files = Dir.entries('.').sort if params['a']

# ls -rの処理
files = files.reverse if params['r']

# ls -l時のファイル情報取得
def file_content(list)
  stat = File::Stat.new(list)
  permission = stat.mode.to_s(8)
  if permission.slice(0) == '4'
    print 'd'
  else
    print '-'
  end
  hash = { '4' => 'r--', '5' => 'r-x', '6' => 'rw-', '7' => 'rwx' }
  print permission.slice(-3..-1).gsub(/[4567]/) { hash[Regexp.last_match(0)] }
  print format('%3s', stat.nlink)
  print format('%5s', Etc.getpwuid(stat.uid).name)
  print format('%7s', Etc.getgrgid(stat.gid).name)
  print ' '
  print printf('%5d', stat.size)
  print ' '
  print stat.mtime.strftime('%-m %e %k:%M')
  print " #{File.basename(list)}"
  print "\n"
end

# ls -lの処理
if params['l']
  total = 0
  files.each do |list|
    stat = File::Stat.new(list)
    total += stat.blocks # total
  end
  puts "total #{total}"

  # ls -l時に取得したファイル情報を回す
  files.each do |list|
    print file_content(list)
  end
  return
end

# ファイル一覧の表示を整備
def name(item)
  item.each do |x|
    print x.to_s.ljust(24)
  end
  print "\n"
end

# ファイル一覧を分け行と列の転換
figure = files.each_slice(3).to_a.size
splitted_files = files.each_slice(figure).to_a

max_size = splitted_files.map(&:size).max
splitted_files.map! { |its| its.values_at(0...max_size) }
items = splitted_files.transpose

# ファイル一覧3列に整列
items.each do |item|
  print name(item)
end
