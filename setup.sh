#!/bin/bash

# This script is to help when developing or packaging the template.
#
# Ash Gittins <ash@ajg.net.au>
#
# The template file has to have the full path to the state directories in it when
# Ardour loads it. This is a problem if you are moving the template to another
# machine (or user account). Ardour has a packaged template format (the templates
# folder is simply tar'd up with xz compression (-J) and any instance of the full
# path in template-dir="" is replaced with "$TEMPLATEDIR", so this script can
# build a template archive for easy distribution, which the user can then simply
# import into Ardour through "Window", "Template Manager", "Import".
#
# This script is tested on Linux, but *should* work on MacOS as well.
#
TEMPLATENAME="Virtual Playing Orchestra"
TEMPLATEFILE="$TEMPLATENAME.template"

mungepath() {
	# call with $1 as the template file to modify and $2 as the new directory/token
	if [ -e "$1" ]; then
		mv "$1" "$1.backup"
		cat "$1.backup" | sed -e "s#template-dir=.*$TEMPLATENAME#template-dir=\"$2/$TEMPLATENAME#g" > "$1"
	else
		echo "Missing $1!"
		exit 3
	fi
}

case "$1" in
  build)
	if [ -e templates ]; then
		echo "There is already a templates directory - please remove it." >&2
		exit 5
	else
		echo "Building new archive..." >&2
		if [ ! -e build ]; then mkdir build; fi
		if [ ! -e build/templates ]; then mkdir build/templates; fi
		cp -r "$TEMPLATENAME" build/templates/
		mungepath "build/templates/$TEMPLATENAME/$TEMPLATEFILE" '$TEMPLATEDIR'
		cd build
		tar cJf "$TEMPLATENAME.ardour-template-archive" templates
		cd ..
		echo "Done. New template archive is in build/$TEMPLATENAME.ardour-template-archive" >&2
	fi
		;;
  generic)
        echo "Replacing template dir with '\$TEMPLATEDIR'" >&2
	mungepath "$TEMPLATENAME/$TEMPLATEFILE" '$TEMPLATEDIR'
        ;;
  local)
        echo "Setting templatedir to local system..."
	mungepath "$TEMPLATENAME/$TEMPLATEFILE" "$(pwd)"
        ;;
  *)
        echo "Usage: $0	[local|generic|build]" >&2
	echo "" >&2
	echo "  build:" >&2
	echo "    This creates a new template archive that you can import directly" >&2
	echo "    into Ardour. (Look in the 'build' directory). This is very likely" >&2
	echo "    exactly what you want." >&2
	echo "  local:" >&2
	echo "    update the template file with the full path on your local system." >&2
	echo "    this may or may not be what you want." >&2
	echo "  generic:" >&2
	echo "    updates the template with '$TEMPLATEDIR' ready to be archived. This" >&2
	echo "    is even less likely to be what you want." >&2
	exit 3
        ;;
esac

