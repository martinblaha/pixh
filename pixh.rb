#!/usr/bin/env ruby
 
require 'date'
require 'fileutils'
require 'mini_exiftool'
# Bring OptionParser into the namespace
require 'optparse'

options = {}
option_parser = OptionParser.new do |opts|
  # Create a switch
  opts.on("-i","--iteration") do options[:iteration] = true
  end
  # Create a flag
  opts.on("-u USER") do |user| options[:user] = user
  end
  opts.on("-p PASSWORD") do |password| options[:password] = password
  end
end

option_parser.parse!
puts options.inspect

raise ArgumentError.new "Usage: pix SOURCE DEST" unless ARGV.count > 0 


root_dir  = File.expand_path ARGV[0]
dest_dir  = File.expand_path ARGV[1]
file_list = [] 

puts "pix ... just a little photo management helper"
puts "SOURCE = #{root_dir}"
puts "DEST   = #{dest_dir}"

logfile = root_dir + '/' + Time.now.strftime("%Y-%m-%d-%H-%M-%S-pix" + ".log")
system 'touch', logfile

# procdir returns a list of images starting recursively from dir
# supported file extensions -> TODO move definition to a config file
def procdir(dir)
  Dir[ File.join(dir, '**', '*.{jpeg,jpg,JPG,JPEG,png,PNG,mov,MOV,mpeg,MPEG,mpg,MPG,mp4,MP4,avi,AVI,m4v,M4V,raw,tiff,tif,bmp,divx}') ].reject { |p| File.directory? p }
end

# Take a filename, figure out - based on new_name - to which folder it belongs and copy it there
# Use besedir as destination dir basis
def cp2folder(file, new_name, basedir)
  year  = new_name[0..3]
  month = new_name[5..6]
  day   = new_name[8..9]
  new_location = basedir + '/' + year + '/' + month + '/' + day 
  if Dir.exists?(new_location)
    then
      # puts "#{new_location} exists"
      system 'cp', file, new_location + '/' + new_name
    else
      # puts "Need to create #{new_location}"
      system 'mkdir', '-p', new_location
      system 'cp', file, new_location + '/' + new_name
    end
end

start        = Time.now
count        = 0
errors_count = 0
file_list    = procdir (root_dir)

file_list.each do |item|
  myfile = MiniExiftool.new (item)
  # TODO Add time zone support
  createdDate = myfile.date_time_original || myfile.createdate
  if createdDate
    then
      # we need to keep the file extension so we just use the existing one
      suffix = File.extname(item)
      new_file_name = createdDate.strftime("%Y-%m-%d-%H-%M-%S.%3N") + suffix
      cp2folder item, new_file_name, dest_dir
    else
      puts "Date missing: " + item
      # append to log
      errors_count += 1
      File.open(logfile, "a+"){|f| f.puts "Date missing: " + item }
  end
  # puts(item + ' => ' + new_file_name)
  count+=1
end
finish = Time.now

seconds = sprintf("%0.02f", (finish - start) % 60)
minutes = (((finish - start) / 60) % 60).to_i
puts "#{count} files processed in #{minutes} min #{seconds} sec"
puts "#{errors_count} errors. See the pixh log file in SOURCE directory." unless errors_count == 0
