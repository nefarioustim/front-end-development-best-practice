#========================================
# Jekyll Site Build File
#
# Author: Tim Huegdon
#========================================

remote-host = pegasus
remote-path = ~/sites/timhuegdon.com/public/front-end-development-best-practice/

all:
	jekyll
	rm ./_site/README.md
	rm ./_site/Makefile

install: clean all push

push:
	rsync --delete -rave ssh ./_site/ $(remote-host):$(remote-path)

clean:
	rm -rf ./_site/*