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

def seq_files(config)

#	FRAMES_DIR = "frames"
#	OUT_DIR = "out"



	strDirs = Dir.entries("#{config.frames_dir}").select { | f | File.directory? "#{config.frames_dir}/#{f}" }

	strDestination = config.out_dir


	strDirs.select! { | f |
		if ( (! f.start_with? ".") && (f != strDestination) )
			f
		else
			nil
		end
	}

	if (File.directory? config.out_dir)
#		system("move #{config.out_dir} #{config.out_dir}#{Time.now.strftime('%Y%m%d_%H%M%S')}")
#		system("mkdir #{config.out_dir}")
		FileUtils.mv("#{config.out_dir}", "#{config.out_dir}#{Time.now.strftime('%Y%m%d_%H%M%S')}")
		FileUtils.mkdir(config.out_dir)
	else
#		system("mkdir #{config.out_dir}")
		FileUtils.mkdir(config.out_dir)

	end


	iFileCounter = 0
	strDirs.each { | dFrames |
		d = config.frames_dir + "\\" + dFrames
		print "dir: #{d}" + "\n"
	
		strFiles = Dir.entries(d).select { | f |
			File.file? d + "\\" + f
		}
	
	
	
		strFiles.each { | f |
			strNewFile = "%04d" % iFileCounter
			FileUtils.mv("#{d}\\#{f}", "#{strDestination}\\#{strNewFile}.png")
		
			iFileCounter += 1
		}
	
	}
end