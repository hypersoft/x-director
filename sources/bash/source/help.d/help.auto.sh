#!/bin/bash

(
	cat $PROJECT_HELP_SOURCE_DIR/header.txt
	for file in $(echo $PROJECT_HELP_SOURCE_DIR/text.d/* | sort -V); do
		[[ "$file" =~ \.txt$ ]] && {
			cat $file; continue;
		}
		[[ "$file" =~ \.sh$ ]] && {
			source $file;
		}
	done;
	cat $PROJECT_HELP_SOURCE_DIR/footer.txt
)
