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
	
#	strFiles = Dir.entries("001")
	strFiles = Dir.entries(d).select { | f |
		File.file? d + "\\" + f
	}
	
#	print "Number of files: #{strFiles.size}" + "\n"
	
	
	strFiles.each { | f |
		strNewFile = "%04d" % iFileCounter
#		print "Source: #{d}\\#{f}  Destination: #{strDestination}\\#{strNewFile}.png" + "\n"
		FileUtils.cp("#{d}\\#{f}", "#{strDestination}\\#{strNewFile}.png")
		iFileCounter += 1
	}
	
}