#!usr/bin/ruby -w

if ARGV.count != 1
  puts "usage : #{$0} section"
  exit
end
dpkg = `dpkg -l`
print ARGV[0]
dpkg.each_line do |line|
  if line =~ /^ii\s+([^ ]+)/ then
    show = `apt-cache show #{$1}`
    name = $1
    if show =~ /Section: ([^ \n\t]+)/ 
      puts "#{name}"
    end
  end
end
#show =~ /Section: ([^ \n\t]+)/
    #regex = Regexp.new("Section: #{ARGV[0]}")
    #if regex.match(show) then
	#puts "#{name}"
    #end
