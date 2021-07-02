require "date"

require "optparse"

options = ARGV.getopts("", "y:#{Date.today.year}", "m:#{Date.today.month}")

year = options.values[0].to_i
month = options.values[1].to_i

day = Date.today.day
first_day = Date.new(year, month, +1)
last_day = Date.new(year, month, -1)

puts first_day.strftime("%B %Y").center(21)
puts " Su Mo Tu We Th Fr St"
print "\s\s\s" * first_day.wday + "\s"

(first_day..last_day).each do |x|
  print  "#{x.day}".rjust(2)
  print " "
  if x.saturday?
    print  "\n" + (' ')
    end
end

puts
