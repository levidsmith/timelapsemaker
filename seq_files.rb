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

strDirs = Dir.entries(".").select { | f | File.directory? f }

strDestination = "out"


strDirs.select! { | f |
	if ( (! f.start_with? ".") && (f != strDestination) )
		f
	else
		nil
	end
}

system("mkdir #{strDestination}")

iFileCounter = 0
strDirs.each { | d |
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