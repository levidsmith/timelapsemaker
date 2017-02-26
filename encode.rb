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


filePath = "."
if (ARGV[0].nil? == false)
	filePath = ARGV[0]
end

puts "path is: #{filePath}"

#strFiles = Dir.entries(".").select { | f | File.file? f }
strFiles = Dir.entries("#{filePath}").select { | f | File.file?("#{filePath}/#{f}" ) }
FFMPEG = 'E:\ldsmith\openbroadcaster\ffmpeg\ffmpeg-20131222-git-9b195dd-win64-static\bin\ffmpeg'
FRAMES_DIR = "frames"

VIDEO_RESOLUTION='1920x1080'

FRAME_INTERVAL_DEFAULT=15
frameInterval=FRAME_INTERVAL_DEFAULT

if (ARGV[1].nil? == false)
	frameInterval = ARGV[1].to_i
	
	if (frameInterval <= 1)
		frameInterval = FRAME_INTERVAL_DEFAULT
	end
	
end



strFiles.select! { 
	| f |
	f =~ /.*\.flv|.*\.mp4/

}

strFiles.each { |theFile|
	puts "File: #{theFile}"
} 
 
iFile = 0

if (File.directory? FRAMES_DIR)
	system("move #{FRAMES_DIR} #{FRAMES_DIR}#{Time.now.strftime('%Y%m%d_%H%M%S')}")
	system("mkdir #{FRAMES_DIR}")
else
	system("mkdir #{FRAMES_DIR}")
end

strFiles.each {
	| strFile |
	
	strDir = "%04d" % iFile
	strDir = FRAMES_DIR + "\\" + strDir

	system("mkdir #{strDir}")

#    print FFMPEG + " -i \"#{filePath}\\#{strFile}\" -f image2 -vf fps=fps=1/15 #{strDir}\\img%04d.png"
	strCommand = FFMPEG + " -i \"#{filePath}\\#{strFile}\" -f image2 -s #{VIDEO_RESOLUTION} -vf fps=fps=1/#{frameInterval} #{strDir}\\img%04d.png"
	
#	print(FFMPEG + " -i \"#{filePath}\\#{strFile}\" -f image2 -s 1280x720 -vf fps=fps=1/#{FRAME_INTERVAL} #{strDir}\\img%04d.png")
#	system(FFMPEG + " -i \"#{filePath}\\#{strFile}\" -f image2 -s 1280x720 -vf fps=fps=1/#{FRAME_INTERVAL} #{strDir}\\img%04d.png")

	print(strCommand)
	system(strCommand)

	iFile += 1

}

