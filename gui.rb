# Timelapse Maker
# 2015 Levi D. Smith
# Web: levidsmith.com
# Twitter: @GaTechGrad

# A graphical user interface that I started.  Needs a lot of work!

require 'tk'

varVideoDir = TkVariable.new
varVideoDir = "Enter video folder"


def extractFrames
	puts "Call encode.rb script"
	puts "Parameter #{$textVideoDir.get}"
#	system("ruby encode.rb")
#	exit
end

def sequenceFrames
	puts "Call seq_files.rb script"
#	exit
end




root = TkRoot.new { title "Make Video" }

TkLabel.new(root) do
	text "Timelapse Maker by Levi D. Smith 2015"
	pack { padx 15; pady 15; size 'left' }
end



$textVideoDir = TkEntry.new(root) do
#	textvariable varVideoDir
	pack("side" => "left", "padx" => "50", "pady" => "10")
	
end
#textVideoFiles.textvariable = varVideoFiles
#textVideoFiles.place('height' => 25, 'width' => 150, 'x' => 10, 'y' => 40)


TkButton.new(root) do
	text "Extract Frames"
	borderwidth 5
	command (proc {extractFrames})
	pack("side" => "left", "padx" => "50", "pady" => "10")
end

TkButton.new(root) do
	text "Sequence Frames"
	borderwidth 5
	command (proc {sequenceFrames})
#	command "puts \"hello\" #{textVideoDir.get}"
	pack("side" => "left", "padx" => "50", "pady" => "10")
end





Tk.mainloop