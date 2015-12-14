# Timelapse Maker
# 2015 Levi D. Smith
# Web: levidsmith.com
# Twitter: @GaTechGrad

# This file duplicates an image in a directory
# the specified number of times
# This is useful for displaying a static image
# such as a title over a number of seconds in
# a time lapse

require 'fileutils'


OUT_DIR = "out"

# The image filename number
iFrom = ARGV[0].to_i

# Number of times to duplicate the image
iTimes = ARGV[1].to_i  

i = 1

while (i < iTimes)
#	str = "copy #{iFrom}.png #{iFrom + i}.png"

#	puts str
#	system str

	puts "Copying " + "#{OUT_DIR}\\#{iFrom}.png" + " to " + "#{OUT_DIR}\\#{iFrom + i}.png"

		FileUtils.cp("#{OUT_DIR}\\#{iFrom}.png", "#{OUT_DIR}\\#{iFrom + i}.png")

	i += 1

end