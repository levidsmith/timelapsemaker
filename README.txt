Timelapse Maker
2015 Levi D. Smith
Web: levidsmith.com
Twitter: @GaTechGrad

Platform
Windows only
There are specific Windows command line calls, but it could be easily modified to work on other operating systems.

Quick Usage Summary
For most videos, all you will need to do is run "encode.rb" and then "seq_files.rb".  Run "dup.rb" if you would like to add a static image at the end of the video (copy the image to the "out" folder, and then specify the frame number and number of frames as parameters).
You will need to edit the "encode.rb" file and set the location of your ffmpeg installation.

Description
Timelapse Maker is a tool that I developed for making time lapse videos.  The scripts were created for the videos that I captured during the Ludum Dare game development competition.  I currently use Open Broadcaster (OBS) for capturing video, which will capture video in FLV or MP4 format as you are streaming.  The "encode.rb" script will go through a directory and convert the video files into numerically sequenced folders of image files.  The "seq_files.rb" will go through those folders and order all of the images in one "out" folder with sequential filenames.  The first image file in the "out" folder can be opened in VirtualDub to create a time lapse video.  VirtualDub requires that all of the images in the time lapse to have sequential numerical filenames.  Select "Audio" > "Source Audio" to add background music, and it must be longer than the time lapse or there will be silence at the end of the time lapse video (VirtualDub will not loop your music).  Use Audacity to loop and extend the background music if needed.  Use the "dup.rb" script to duplicate a file, which is useful for displaying one frame over a number of seconds.

Required Software
Ruby - https://www.ruby-lang.org/en/
ffmpeg - https://www.ffmpeg.org/
VirtualDub - http://www.virtualdub.org/
OpenBroadcaster (recommended for video capture) - https://obsproject.com/