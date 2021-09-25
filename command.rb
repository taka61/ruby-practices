# frozen_string_literal: true

require 'optparse'
require 'etc'
require './long_format'
require './short_format'

class Command
  attr_reader :files, :lists

  def initialize(option)
    @option = option
    @files = @option['a'] ? Dir.glob('*', File::FNM_DOTMATCH) : Dir.glob('*')
  end

  def output
    @files = @files.reverse if @option['r']
    @option['l'] ? LongFormat.new(@files).print_option(@files) : ShortFormat.new(@files).print_option
  end
end

option = ARGV.getopts('a', 'l', 'r')
ls = Command.new(option)
ls.output
