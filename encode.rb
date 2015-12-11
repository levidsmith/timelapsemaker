# Timelapse Maker
# 2015 Levi D. Smith
# Web: levidsmith.com
# Twitter: @GaTechGrad

# This looks for all of the FLV and MP4 files
# in a directory, and outputs all of the frame
# images of the timelapse
# ffmpeg must be installed
# The interval can be specified (one frame for 
# every N number of seconds in real time)

strFiles = Dir.entries(".").select { | f | File.file? f }
FFMPEG = 'E:\ldsmith\openbroadcaster\ffmpeg\ffmpeg-20131222-git-9b195dd-win64-static\bin\ffmpeg'
FRAME_INTERVAL=15

strFiles.select! { 
	| f |
	f =~ /.*\.flv|.*\.mp4/

}

strFiles.each { |theFile|
	puts "File: #{theFile}"
} 
 
iFile = 0

strFiles.each {
	| strFile |
	
	strDir = "%04d" % iFile

	system("mkdir #{strDir}")

    print FFMPEG + " -i \"#{strFile}\" -f image2 -vf fps=fps=1/15 #{strDir}\\img%04d.png"
	system(FFMPEG + " -i \"#{strFile}\" -f image2 -s 1280x720 -vf fps=fps=1/#{FRAME_INTERVAL} #{strDir}\\img%04d.png")

	iFile += 1

}



