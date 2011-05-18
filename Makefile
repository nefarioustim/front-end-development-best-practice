#========================================
# Jekyll Site Build File
#
# Author: Tim Huegdon
#========================================

remote-host =				pegasus
remote-path =				~/sites/timhuegdon.com/public/front-end-development-best-practice/

css-path =					./assets/css
css-index-path =			$(css-path)/build/index.css
css-index-files =			$(css-path)/reset.css \
							$(css-path)/fonts.css \
							$(css-path)/core.css \
							$(css-path)/syntax.css

all:
	jekyll
	rm ./_site/README.md
	rm ./_site/Makefile

install: clean all push

push:
	rsync --delete -rave ssh ./_site/ $(remote-host):$(remote-path)

clean:
	rm -rf ./_site/*