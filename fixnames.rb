require 'fileutils'

files = Dir.entries(".")

files.select! { | f |

	File.file? f

}

files.select! { | f |
	f =~ /.*\.png/

}

files.each { | f |
#	print "file: #{f} len: #{f.size}\n"
	
	if (f.size == 10) 
		print "file: #{f} newname: #{f[(0..2)]}0#{f[(3..9)]}  \n"
		oldFileName = "#{f}"
		newFileName = "#{f[(0..2)]}0#{f[(3..9)]}"
		
		FileUtils.mv(oldFileName, newFileName)
		
	end

}