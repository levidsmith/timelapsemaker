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

require 'fileutils'
	FRAME_INTERVAL_DEFAULT=15


def generate_frame_images(config)

#	filePath = "."
	filePath = config.source_dir
	if (ARGV[0].nil? == false)
		filePath = ARGV[0]
	end

	puts "path is: #{filePath}"

	strFiles = Dir.entries("#{filePath}").select { | f | File.file?("#{filePath}/#{f}" ) }
#	FFMPEG = 'E:\ldsmith\openbroadcaster\ffmpeg\ffmpeg-20131222-git-9b195dd-win64-static\bin\ffmpeg'

#	FRAMES_DIR = "frames"

#	VIDEO_RESOLUTION='1920x1080'

	#frameInterval=FRAME_INTERVAL_DEFAULT
	frameInterval = config.frame_interval

	if (ARGV[1].nil? == false)
		frameInterval = ARGV[1].to_i
	
		if (frameInterval <= 1)
			frameInterval = FRAME_INTERVAL_DEFAULT
		end
	
	end



	strFiles.select! { 
		| f |
		f =~ /.*\.flv|.*\.mp4|.*\.ts/

	}

	strFiles.each { |theFile|
		puts "File: #{theFile}"
	} 
 
	iFile = 0

	if (File.directory? config.frames_dir)
		#system("move #{config.frames_dir} #{config.frames_dir}#{Time.now.strftime('%Y%m%d_%H%M%S')}")
		FileUtils.mv("#{config.frames_dir}", "#{config.frames_dir}#{Time.now.strftime('%Y%m%d_%H%M%S')}")
		#system("mkdir #{config.frames_dir}")
		FileUtils.mkdir(config.frames_dir)
	else
		#system("mkdir #{config.frames_dir}")
		FileUtils.mkdir(config.frames_dir)
	end

	strFiles.each {
		| strFile |
	
		strDir = "%04d" % iFile
		strDir = config.frames_dir + "\\" + strDir

		#system("mkdir #{strDir}")
		FileUtils.mkdir(strDir)

#		strCommand = FFMPEG + " -i \"#{filePath}\\#{strFile}\" -f image2 -s #{VIDEO_RESOLUTION} -vf fps=fps=1/#{frameInterval} #{strDir}\\img%04d.png"
		strCommand = config.ffmpeg_exe + " -i \"#{filePath}\\#{strFile}\" -f image2 -s #{config.video_resolution} -vf fps=fps=1/#{frameInterval} #{strDir}\\img%04d.png"

		print(strCommand)
		system(strCommand)

		iFile += 1

	}
end

