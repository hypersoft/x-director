
function set-case() {
	[[ $1 =~ ^(flipped|upper|lower)$ ]] || {
		echo $COMMAND: ${FUNCNAME}: error: unknown case conversion: $1;
		exit 1		
	} >&2;
(
	function flipped() {
		sed -E 's/([[:lower:]])|([[:upper:]])/\U\1\L\2/g'
	}
	function upper() {
		sed -E 's/([[:lower:]])/\U\1/g'
	}
	function lower() {
		sed -E 's/([[:upper:]])/\L\1/g'
	}
	$1;
)
}
