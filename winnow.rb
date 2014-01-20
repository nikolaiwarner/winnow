#!/usr/bin/env ruby

require 'fileutils'

def result_path
  File.join Dir.pwd, 'winnowed', Time.now.to_i.to_s
end

def winnow options
  FileUtils.mkdir_p result_path

  count = 0
  Dir.sort_by{ |file| File.mtime(file) }.each do |file|
    if count == options['skip']
      count = 0
      FileUtils.cp file, File.join(result_path, File.basename(file))
    else
      count = count + 1
    end
  end
end

winnow skip: 5
