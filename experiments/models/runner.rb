#!/usr/bin/env ruby

require 'set'

def adsl_actions(file)
  actions = []
  File.open(file, "r") do |f|
    f.each_line do |line|
      match = /action\s+(\w+)\s+{/.match line
      next unless match
      actions << match[1]
    end
  end
  Set[*actions.sort]
end

def remove_done_actions(csv, actions)
  return unless File.file? csv
  File.open(csv, "r") do |f|
    f.each_line do |line|
      next if line.empty?
      action = line.split(',')[0].gsub('"', '')
      actions.delete action
    end
  end
end

def process_action(input, output, action)
  action_arg = action ? "--actions #{ action }" : ""
  cmd = "adsl-verify -o csv #{ action_arg } #{ input }"
  lines = `#{ cmd }`.split("\n")[1..-1]
  return if lines.nil? or lines.empty?
  File.open(output, "a") do |f|
    lines.each do |line|
      f.write line + "\n"
    end
  end
end

raise if ARGV.length < 1 or ARGV.length > 2
input_file = ARGV[0]
raise unless File.file? input_file

output_file = "results/#{ File.basename(input_file, File.extname(input_file)) }-results.csv" 

if (ARGV.length == 2) && (ARGV[1] == 'all')
  File.delete output_file
  process_action input_file, output_file, nil
end


actions = adsl_actions(input_file)
total_count = actions.size
remove_done_actions(output_file, actions)
done_count = total_count - actions.size
start_time = Time.now
init_done_count = done_count

actions.sort.each do |action|
  percentage = done_count * 100 / total_count
  count_this_run = done_count - init_done_count
  eta = if count_this_run > 0
    seconds = ((Time.now - start_time) / count_this_run) * (total_count - done_count)
    Time.at(seconds).utc.strftime("%H:%M:%S")
  else
    "unknown"
  end
  print "\r#{ percentage }%. ETA: #{ eta }"

  process_action(input_file, output_file, action)

  done_count += 1
end

puts "\r100%"
