#2020 Levi D. Smith - levidsmith.com

require 'gtk3'
require 'json'
require_relative 'encode'
require_relative 'seq_files'
require_relative 'config'
require 'fileutils'

CONFIG_FILE = "config.json"


def makeWindow(config)
	$window = Gtk::Window::new("Timelapse Maker - 2020 Levi D. Smith")
#	window.set_size_request(1024, 768)
	$window.set_border_width(10)
	
#	panelRow = Gtk::FlowBox.new
#Main Vertical panel
	panel = Gtk::Box.new(:vertical, 8)
	
#Horizontal row panel for source folder
	panelRow = Gtk::Box.new(:horizontal, 8)

	labelSourceFolder = Gtk::Label.new("Folder with video files")
	panelRow.add(labelSourceFolder)
	labelSourceFolder.show
	
	textSourceFolder = Gtk::Entry.new
	textSourceFolder.set_width_chars(50)
	textSourceFolder.text = config.source_dir
	panelRow.add(textSourceFolder)
	
	panel.add(panelRow)

#Horizontal row panel for FFMPEG
	panelRow = Gtk::Box.new(:horizontal, 8)

	labelFFMPEG = Gtk::Label.new("FFMPEG executable")
	panelRow.add(labelFFMPEG)
	
	textFFMPEG = Gtk::Entry.new()
	textFFMPEG.set_width_chars(50)
	textFFMPEG.text = config.ffmpeg_exe
	panelRow.add(textFFMPEG)
	
	panel.add(panelRow)

#Horizontal row panel for Video Resolution
	panelRow = Gtk::Box.new(:horizontal, 8)

	labelVideoResolution = Gtk::Label.new("Video resolution")
	panelRow.add(labelVideoResolution)
	
	textVideoResolution = Gtk::Entry.new()
	textVideoResolution.set_width_chars(16)
	textVideoResolution.text = config.video_resolution
	panelRow.add(textVideoResolution)
	
	panel.add(panelRow)


	
#Horizontal row panel for timelapse frames
	panelRow = Gtk::Box.new(:horizontal, 8)

	labelFrameInterval = Gtk::Label.new("Real time seconds between frames")
	panelRow.add(labelFrameInterval)
	labelFrameInterval.show
	
	textFrameInterval = Gtk::Entry.new
	textFrameInterval.text = config.frame_interval
	textFrameInterval.set_tooltip_text("How often to capture a frame?  15 = every 15 seconds, 30 = two times a minute, 60 = every minute")
	panelRow.add(textFrameInterval)
	
	panel.add(panelRow)


#Horizontal row panel for frames folder
	panelRow = Gtk::Box.new(:horizontal, 8)

	labelFramesFolder = Gtk::Label.new("Folder storing frame images")
	panelRow.add(labelFramesFolder)
	labelFramesFolder.show
	
	#Should really lock this, and have the user choose file from File Selector
	textFramesFolder = Gtk::Entry.new
	textFramesFolder.text = config.frames_dir
	panelRow.add(textFramesFolder)
	
	buttonFramesFolder = Gtk::Button.new(:label => "Open frames folder")
	buttonFramesFolder.signal_connect "clicked" do | _widget |
		system('explorer %s' % config.frames_dir)
	end
	panelRow.add(buttonFramesFolder)

	
	panel.add(panelRow)

#Horizontal row panel for out folder
	panelRow = Gtk::Box.new(:horizontal, 8)

	labelOutputFolder = Gtk::Label.new("Output folder")
	panelRow.add(labelOutputFolder)
	labelOutputFolder.show
	
	#Should really lock this, and have the user choose file from File Selector
	textOutputFolder = Gtk::Entry.new
	textOutputFolder.text = config.out_dir
	panelRow.add(textOutputFolder)

	buttonOutputFolder = Gtk::Button.new(:label => "Open output folder")
	buttonOutputFolder.signal_connect "clicked" do | _widget |
		system('explorer %s' % config.out_dir)
	end
	panelRow.add(buttonOutputFolder)

	
	panel.add(panelRow)


#Horizontal row panel for VirtualDub
	panelRow = Gtk::Box.new(:horizontal, 8)

	labelVirtualDub = Gtk::Label.new("VirtualDub executable")
	panelRow.add(labelVirtualDub)
	
	textVirtualDub = Gtk::Entry.new()
	textVirtualDub.set_width_chars(50)
	textVirtualDub.text = config.virtual_dub_exe
	panelRow.add(textVirtualDub)
	
	panel.add(panelRow)

	

#Button panel
	panelButtons = Gtk::ButtonBox.new(:horizontal)
	
	button = Gtk::Button.new(:label => "Generate Frame Images")
	button.signal_connect "clicked" do | _widget |
		puts "Generate Frames"
		
		hasErrors = checkValues(textFFMPEG.text, textSourceFolder.text, textFramesFolder.text, textOutputFolder.text, textVideoResolution.text, textFrameInterval.text, textVirtualDub.text)
		if (!hasErrors) 
			saveToConfig(config, textFFMPEG.text, textSourceFolder.text, textFramesFolder.text, textOutputFolder.text, textVideoResolution.text, textFrameInterval.text, textVirtualDub.text)
		end

		puts "Generating Frames"
		generate_frame_images(config)
		
		strMessage = "Frame images generated\nRecommend opening the " + config.frames_dir + " folder and removing any unwanted frames from the timelapse.  Then run Sequence Images"
		md = Gtk::MessageDialog.new :parent => $window,
				:flags => :destroy_with_parent, :type => :info,
				:buttons_type => :close, :message => strMessage
		md.run
		md.destroy


	end
	panelButtons.add(button)


#Sequence Files button
	button = Gtk::Button.new(:label => "Sequence Images")
	button.signal_connect "clicked" do | _widget |
		puts "Sequencing images"
		saveToConfig(config, textFFMPEG.text, textSourceFolder.text, textFramesFolder.text, textOutputFolder.text, textVideoResolution.text, textFrameInterval.text, textVirtualDub.text)

		seq_files(config)

		strMessage = "Sequence complete"
		md = Gtk::MessageDialog.new :parent => $window,
				:flags => :destroy_with_parent, :type => :info,
				:buttons_type => :close, :message => strMessage
		md.run
		md.destroy

		
	end
	panelButtons.add(button)



#Create timelapse button
	button = Gtk::Button.new(:label => "Create timelapse")
	button.signal_connect "clicked" do | _widget |
		puts "Create timelapse"
		saveToConfig(config, textFFMPEG.text, textSourceFolder.text, textFramesFolder.text, textOutputFolder.text, textVideoResolution.text, textFrameInterval.text, textVirtualDub.text)
		
		#Use gsub for the Windows specific backslashes.  Otherwise, VirtualDub will not open it with forward slashes
		strFirstFrameImage =  File.join(config.out_dir, "0001.png").gsub('/', '\\')
		puts strFirstFrameImage

		system(config.virtual_dub_exe + " " + strFirstFrameImage)

		strMessage = "Import generated files in " + config.out_dir + " into VirtualDub (http://www.virtualdub.org/) to generate an AVI"
		md = Gtk::MessageDialog.new :parent => $window,
				:flags => :destroy_with_parent, :type => :info,
				:buttons_type => :close, :message => strMessage
		md.run
		md.destroy

		
	end
	panelButtons.add(button)
	

	button = Gtk::Button.new(:label => "Save and Quit")
	button.signal_connect "clicked" do | _widget |
		puts "Save and Quit"
		saveToConfig(config, textFFMPEG.text, textSourceFolder.text, textFramesFolder.text, textOutputFolder.text, textVideoResolution.text, textFrameInterval.text, textVirtualDub.text)
		
		Gtk.main_quit
	end
	panelButtons.add(button)

	panel.add(panelButtons)
	
	$window.add(panel)
	
	$window.signal_connect("delete-event") { | _widget | Gtk.main_quit }
	$window.set_position(:center)
	$window.show_all
end

def readConfigFile(config)
	config.readFromFile(CONFIG_FILE)
			   
end

def checkValues(inFFMPEG, inSourceFolder, inFramesFolder, inOutputFolder, inVideoResolution, inFrameInterval, inVirtualDub)
	hasErrors = false
	strMessage = ""

	if (!File.file? inFFMPEG)
		strMessage +=  "Not a valid ffmpeg executable file: " + inFFMPEG + "\n"
		hasErrors = true
	end

	if (!File.directory? inSourceFolder)
		strMessage +=  "Not a valid source folder: " + inSourceFolder + "\n"
		hasErrors = true
	end

	if (!File.directory? inFramesFolder)
		puts "Frames folder #{inFramesFolder} does not exist, creating it"
		result = FileUtils.mkdir(inFramesFolder)

		if (!result)
			strMessage +=  "Not a valid frames folder: " + inFramesFolder + "\n"
			hasErrors = true
		end
	end

	if (!File.directory? inOutputFolder)
			puts "Output folder #{inOutputFolder} does not exist, creating it"
		result = FileUtils.mkdir(inOutputFolder)

		if (!result)
			strMessage +=  "Not a valid output folder: " + inOutputFolder + "\n"
			hasErrors = true
		end
	end

#   Do some regex here: [0-9]+x[0-9]+
#	if (! inVideoResolution)
#		strMessage +=  "Not a valid video resolution: " + inVideoResolution + "\n"
#		hasErrors = true
#	end

	
	begin 
		if (inFrameInterval.nil?)
			raise 'Can not be nil'
		end
	
		iFrameInterval = Integer(inFrameInterval)
	
		if (iFrameInterval <= 0)
			raise 'Must be greater than zero'
		end
	
	rescue
		strMessage +=  "Not a valid frame interval: " + inFrameInterval + "\n"
		hasErrors = true
	
	end

	if (!File.file? inVirtualDub)
		strMessage +=  "Not a valid VirtualDub executable file: " + inVirtualDub + "\n"
		hasErrors = true
	end


	
	if (hasErrors)
		md = Gtk::MessageDialog.new :parent => $window,
				:flags => :destroy_with_parent, :type => :info,
				:buttons_type => :close, :message => strMessage
		md.run
		md.destroy

	
	end
	
	return hasErrors

end


def saveToConfig(config, inFFMPEG, inSourceFolder, inFramesFolder, inOutputFolder, intVideoResolution, inFrameInterval, inVirtualDub)
		config.ffmpeg_exe = inFFMPEG
		config.source_dir = inSourceFolder
		config.frames_dir = inFramesFolder
		config.out_dir = inOutputFolder
		config.video_resolution = intVideoResolution
		config.frame_interval = inFrameInterval
		config.virtual_dub_exe = inVirtualDub
		config.writeToFile(CONFIG_FILE)

end


config = Config.new
readConfigFile(config)
puts config.source_dir


makeWindow(config)
Gtk.main