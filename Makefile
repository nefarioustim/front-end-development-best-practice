#========================================
# Jekyll Site Build File
#
# Author: Tim Huegdon
#========================================

remote-host = pegasus
remote-path = /home/huegdon/sites/timhuegdon.com/public/front-end-development-best-practice/

push:
	rsync --delete -rave ssh ./ $(remote-host):$(remote-path)