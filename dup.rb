# Timelapse Maker
# 2015 Levi D. Smith
# Web: levidsmith.com
# Twitter: @GaTechGrad

# This file duplicates an image in a directory
# the specified number of times
# This is useful for displaying a static image
# such as a title over a number of seconds in
# a time lapse

#iFrom = 3222
#iTimes = 70

iFrom = ARGV[0].to_i
iTimes = ARGV[1].to_i

#puts "From: #{iFrom + 1}"
#puts "Times: #{iTimes + 1}"


i = 1

while (i < iTimes)
	str = "copy #{iFrom}.png #{iFrom + i}.png"

	puts str
#	system 'copy #{iFrom}
	system str
	i += 1

end