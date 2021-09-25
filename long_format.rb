# frozen_string_literal: true

class LongFormat
  attr_reader :files

  PERMISSION = {
    '0' => '---',
    '1' => '--x',
    '2' => '-w-',
    '3' => '-wx',
    '4' => 'r--',
    '5' => 'r-x',
    '6' => 'rw-',
    '7' => 'rwx'
  }.freeze

  def initialize(files)
    @files = files
  end

  def print_option(_files)
    file_stats = @files.map { |file| build_stat(file) }
    block_total = file_stats.map { |stat| stat[:blocks] }.sum
    max_size_map = build_max_size_map(file_stats)

    puts "total #{block_total}"
    file_stats.each { |stat| print_long_format(stat, max_size_map) }
  end

  def build_stat(file)
    fs = File.lstat(file)
    {
      type: format_type(fs),
      mode: format_mode(fs),
      file: file,
      nlink: fs.nlink,
      username: Etc.getpwuid(fs.uid).name,
      grpname: Etc.getgrgid(fs.gid).name,
      bytesize: fs.size,
      mtime: fs.mtime.strftime('%-m %e %k:%M'),
      blocks: fs.blocks
    }
  end

  def format_type(file_stat)
    file_stat.directory? ? 'd' : '-'
  end

  def format_mode(file_stat)
    file_stat.mode.to_s(8).slice(-3..-1).gsub(/[4567]/) { PERMISSION[Regexp.last_match(0)] }
  end

  def build_max_size_map(file_stats)
    {
      nlink: file_stats.map { |stat| stat[:nlink].to_s.size }.max,
      username: file_stats.map { |stat| stat[:username].size }.max,
      grpname: file_stats.map { |stat| stat[:grpname].size }.max,
      bytesize: file_stats.map { |stat| stat[:bytesize].to_s.size }.max
    }
  end

  def print_long_format(stat, max_size_map)
    printf([
      '%<type>s%<mode>s',
      "%<nlink>#{max_size_map[:nlink] + 1}i",
      "%<username>-#{max_size_map[:username] + 1}s",
      "%<grpname>-#{max_size_map[:grpname] + 1}s",
      "%<bytesize>#{max_size_map[:bytesize]}s",
      '%<mtime>2s',
      "%<file>s\n"
    ].join(' '), stat)
  end
end
