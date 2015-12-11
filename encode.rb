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
#	f =~ /.*\.mp4/
	f =~ /.*\.flv|.*\.mp4/

	
}

strFiles.each { |theFile|
	puts "File: #{theFile}"
} 
 

iFile = 0

strFiles.each {
	| strFile |


#	print "file: #{strFile}\n"
	
	strDir = "%04d" % iFile
#	print "mkdir #{strDir}" + "\n"
#	print "ffmpeg -i #{strFile} -f image2 -vf fps=fps=1/30 #{strDir}\\img%03d.png" +  "\n"

	system("mkdir #{strDir}")
#   SMB, SMB2, SMB3, SMW (one frame every 15 seconds)
#	system("ffmpeg -i #{strFile} -f image2 -vf fps=fps=1/15 #{strDir}\\img%03d.png")
#    print FFMPEG + " -i #{strFile} -f image2 -vf fps=fps=1/15 #{strDir}\\img%04d.png"
#	system(FFMPEG + " -i #{strFile} -f image2 -vf fps=fps=1/15 #{strDir}\\img%04d.png")




#   (one frame every 30 seconds)
#	system("ffmpeg -i #{strFile} -f image2 -vf fps=fps=1/30 #{strDir}\\img%04d.png")


#   (one frame every 15 seconds)
    print FFMPEG + " -i \"#{strFile}\" -f image2 -vf fps=fps=1/15 #{strDir}\\img%04d.png"
	system(FFMPEG + " -i \"#{strFile}\" -f image2 -s 1280x720 -vf fps=fps=1/#{FRAME_INTERVAL} #{strDir}\\img%04d.png")


#   SM64 (one frame per minute)
#	system("ffmpeg -i #{strFile} -f image2 -s hd1080 -vf fps=fps=1/60 #{strDir}\\img%04d.png")
	
	iFile += 1

}



