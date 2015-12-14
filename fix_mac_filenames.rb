# Timelapse Maker
# 2015 Levi D. Smith
# Web: levidsmith.com
# Twitter: @GaTechGrad

# This is for date timestamp format for filename generated on the Mac
# This will update files with a space in the filename after the date

require 'fileutils'


filePath = "."
if (ARGV[0].nil? == false)
	filePath = ARGV[0]
end

files = Dir.entries(filePath)

files.select! { | f |
	puts "File: #{filePath}\\#{f}"
	File.file? "#{filePath}\\#{f}"

}

files.select! { | f |
#	f =~ /.*\.flv/
	f =~ /.* .*\..*/
}

puts "Fixing #{files.size} filenames"

files.each { | f |

	oldFileName = "#{f}"
	puts "Old file: #{f}"
	
	#Convert "YYYY-MM-DD hh-mm-ss.ext" to "YYYY-MM-DD-hhmm-ss.ext"
	newFileName = "#{f[(0..9)]}-#{f[(11..12)]}#{f[(14..15)]}-#{f[(17..22)]}"
	puts "New file: #{newFileName}"

	puts "Moving: " + "#{filePath}\\#{oldFileName}" + " to " + "#{filePath}\\#{newFileName}"

	FileUtils.mv("#{filePath}\\#{oldFileName}", "#{filePath}\\#{newFileName}")


}