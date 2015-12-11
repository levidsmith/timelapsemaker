require 'tk'

root = TkRoot.new { title "Make Video" }

TkLabel.new(root) do
	text "Hello World"
	pack { padx 15; pady 15; size 'left' }
end

Tk.mainloop