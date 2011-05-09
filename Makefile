#========================================
# Jekyll Site Build File
#
# Author: Tim Huegdon
#========================================

remote-host = pegasus
remote-path = ~/sites/timhuegdon.com/public/front-end-development-best-practice/

build:
	jekyll
	rm ./_site/Makefile

push:
	rsync --delete -rave ssh ./_site/ $(remote-host):$(remote-path)