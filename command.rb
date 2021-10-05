# frozen_string_literal: true

require 'optparse'
require 'etc'
require_relative './long_format'
require_relative './short_format'

class Command
  def initialize(option)
    files = option['a'] ? Dir.glob('*', File::FNM_DOTMATCH) : Dir.glob('*')
    files = files.reverse if option['r']
    @format = option['l'] ? LongFormat.new(files) : ShortFormat.new(files)
  end

  def output
    @format.print_information
  end
end

option = ARGV.getopts('a', 'l', 'r')
ls = Command.new(option)
ls.output
