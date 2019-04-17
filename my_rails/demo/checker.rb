# checker.rb
require 'rubygems' 
require 'curb'

gem_name = ARGV[0]

raise ArgumentError.new("gem name missing") if gem_name.nil?

if Curl.get("https://rubygems.org/gems/#{gem_name}").status == '200 OK' 
  $stdout.puts 'Name not available.' 
else 
  $stdout.puts 'Name available.' 
end
