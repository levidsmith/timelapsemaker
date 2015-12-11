# Timelapse Maker
# 2015 Levi D. Smith
# Web: levidsmith.com
# Twitter: @GaTechGrad

# This was made obsolete by "dup.rb"
# Should be considered for removal

strStingerFile = "stinger"
iFile = 0
iOffset = 4992	

iFramesPerSecond = 10
iTotalSeconds = 30

while (iFile < iFramesPerSecond * iTotalSeconds)

	strFileNum = "%04d" % (iFile + iOffset)

	strCommand = "copy #{strStingerFile}.png #{strFileNum}.png"
	puts strCommand
	system (strCommand)

	iFile += 1

end