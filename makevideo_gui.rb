# Timelapse Maker
# 2015 Levi D. Smith
# Web: levidsmith.com
# Twitter: @GaTechGrad

# A graphical user interface that I started.  Needs a lot of work!

require 'tk'

root = TkRoot.new { title "Make Video" }

TkLabel.new(root) do
	text "Hello World"
	pack { padx 15; pady 15; size 'left' }
end

Tk.mainloop