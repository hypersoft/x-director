
# allows the user to run a system-command as a function-target
function command() {
	key-within-list $1 -- $OPTIONS $FUNCTIONS && {
		echo "that's an error bob"
	}
	"$@";
}
