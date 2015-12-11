# Timelapse Maker
# 2015 Levi D. Smith
# Web: levidsmith.com
# Twitter: @GaTechGrad

# A graphical user interface that I started.  Needs a lot of work!

require 'tk'


def extractFrames
	puts "Call encode.rb script"
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
	pack("side" => "left", "padx" => "50", "pady" => "10")
end


Tk.mainloop