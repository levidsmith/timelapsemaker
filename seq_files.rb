# Timelapse Maker
# 2015 Levi D. Smith
# Web: levidsmith.com
# Twitter: @GaTechGrad

# After running "encode.rb", all of the frame images
# should be in folders named "0000", "0001", "0002", etc.
# This script should be run next to pull the frames out of
# those folders and sequence them correctly in the "out" 
# folder.  This will not delete the existing folders,
# which should be removed after to conserve space

require 'fileutils'

FRAMES_DIR = "frames"
OUT_DIR = "out"


strDirs = Dir.entries("#{FRAMES_DIR}").select { | f | File.directory? "#{FRAMES_DIR}/#{f}" }

#strDestination = "out"
strDestination = OUT_DIR


strDirs.select! { | f |
#	puts "DIR: #{f}"
	if ( (! f.start_with? ".") && (f != strDestination) )
		f
	else
		nil
	end
}

#exit

#system("mkdir #{strDestination}")
if (File.directory? OUT_DIR)
	system("move #{OUT_DIR} #{OUT_DIR}#{Time.now.strftime('%Y%m%d_%H%M%S')}")
	system("mkdir #{OUT_DIR}")
else
	system("mkdir #{OUT_DIR}")
end


iFileCounter = 0
strDirs.each { | dFrames |
	d = FRAMES_DIR + "\\" + dFrames
	print "dir: #{d}" + "\n"
	
	strFiles = Dir.entries(d).select { | f |
		File.file? d + "\\" + f
	}
	
	
	
	strFiles.each { | f |
		strNewFile = "%04d" % iFileCounter
		FileUtils.cp("#{d}\\#{f}", "#{strDestination}\\#{strNewFile}.png")
		iFileCounter += 1
	}
	
}