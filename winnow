#!/usr/bin/env ruby

require 'fileutils'
require 'optparse'

def winnow options
  count = 0
  input_path = File.expand_path(options[:input_dir] || Dir.pwd)
  output_path = File.join input_path, 'winnowed', Time.now.to_i.to_s

  FileUtils.mkdir_p output_path
  Dir.chdir input_path do
    Dir["*"].sort_by{ |file| File.mtime(file) }.each do |file|
      if count == options[:skip]
        count = 0
        unless File.directory? file
          FileUtils.cp file, File.join(output_path, File.basename(file))
        end
      else
        count = count + 1
      end
    end

    if options[:animate]
      `cd #{output_path}; convert -delay #{options[:gif_delay]} -loop 0 *.#{options[:input_format]} #{options[:gif_filename]} `
    end
  end
end

options = {
  skip: 5,
  animate: false,
  gif_delay: 20,
  input_format: 'jpg',
  gif_filename: 'animated.gif'
}

OptionParser.new do |opts|
  opts.banner = "Usage: winnow [options]"

  opts.on("-i DIR", "--input DIR", String, "Input directory of images (default: current directory)") do |input_dir|
    options[:input_dir] = input_dir
  end

  opts.on("-s N", "--skip N", Integer, "Number of images to skip (default: 5)") do |skip|
    options[:skip] = skip
  end

  opts.on("-a", "--animate", "Make an animated gif") do |v|
    options[:animate] = true
  end

  opts.on("--delay N", Integer, "Milliseconds between frames in animation (default: 20)") do |gif_delay|
    options[:gif_delay] = gif_delay
  end

  opts.on("-f FORMAT", "--format FORMAT", String, "File format of input images for animation (default: jpg)") do |input_format|
    options[:input_format] = input_format
  end

  opts.on("-o FILENAME", "--output FILENAME", String, "Output filename of animation (default: animation.gif)") do |gif_filename|
    options[:gif_filename] = gif_filename
  end
end.parse!

winnow options
