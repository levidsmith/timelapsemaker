#2020 Levi D. Smith - levidsmith.com

require 'fileutils'

class Config
	attr_accessor :ffmpeg_exe
	attr_accessor :source_dir
	attr_accessor :frames_dir
	attr_accessor :out_dir
	attr_accessor :video_resolution
	attr_accessor :frame_interval
	
	
	def writeToFile(strFile)
#		strFileContents = "File"
#		puts "File Contents #{strFileContents}"

			values = { :ffmpeg_exe => self.ffmpeg_exe,
					:source_dir => self.source_dir,
					:frames_dir => self.frames_dir,
					:out_dir => self.out_dir,
					:video_resolution => self.video_resolution,
					:frame_interval => self.frame_interval 
					}
			puts values.to_json
			File.open(strFile, 'w') { | file |
				file.write(values.to_json)
			}


	end
	
	def readFromFile(strFile)
		puts "reading config from file"
			
		if (File.file? strFile)
			puts "reading config file " + strFile
			strFileContents = File.read(strFile)
		
			values = JSON.parse(strFileContents)
			
			
			self.ffmpeg_exe = values["ffmpeg_exe"]
#		puts "config.ffmpeg_exe is " + config.ffmpeg_exe
			self.source_dir = values["source_dir"]
			self.frames_dir = values["frames_dir"]
			self.out_dir = values["out_dir"]
			self.video_resolution = values["video_resolution"]
			self.frame_interval = values["frame_interval"]

			puts "finished reading values"
	
		else

			values = { :ffmpeg_exe => "C:\\ffmpeg\\bin\\ffmpeg.exe",
					:source_dir => "C:\\temp",
					:frames_dir => "frames",
					:out_dir => "out",
					:video_resolution => "1920x1080",
					:frame_interval => "15" 
					}
			puts values.to_json
			File.open(strFile, 'w') { | file |
				file.write(values.to_json)
			}
		
		end

	
	end


end