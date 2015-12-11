# Timelapse Maker
# 2015 Levi D. Smith
# Web: levidsmith.com
# Twitter: @GaTechGrad

# This is for adding an extra zero if only three numbers
# are specified in the image filenames
# The new encode.rb should generate filenames with four 
# numbers by default

require 'fileutils'

files = Dir.entries(".")

files.select! { | f |

	File.file? f

}

files.select! { | f |
	f =~ /.*\.png/

}

files.each { | f |
	
	if (f.size == 10) 
		print "file: #{f} newname: #{f[(0..2)]}0#{f[(3..9)]}  \n"
		oldFileName = "#{f}"
		newFileName = "#{f[(0..2)]}0#{f[(3..9)]}"
		
		FileUtils.mv(oldFileName, newFileName)
		
	end

}