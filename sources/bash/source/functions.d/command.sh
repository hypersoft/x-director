
# allows the user to run a system-command as a function-target
function command() {
	builtin command "$@";
}
