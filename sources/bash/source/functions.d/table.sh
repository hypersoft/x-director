function columns() {
	local -i final_point="${@:$#}"
	let final_point--;
	local IFS=$CSI;
	set -- "${@:1:$# - 1}"
	local -a columns
	while read -d "$RSI" -a columns; do
		for point; do
			let point--
			(( point > ${#columns[@]} )) && return 1;
			printf "%s${CSO}" "${columns[point]}";
		done;
		(( final_point > ${#columns[@]} )) && return 1;
		printf "%s${RSO}" "${columns[final_point]}";
	done;
}

function rows() {
	local IFS="$RSI";
	local -a rows=("$@");
	local -i r=0 m=0;
	for x; do
		(( x > m )) && m=$x;
	done;
	local -a lines;
	readarray -O 1 -d "$RSI" -n $m lines;
	local -i x
	for x; do
		(( x > ${#lines[@]} )) && return 1;
		printf "%s" "${lines[$x]/$RSI/$RSO}"
	done;
}

function table() {
	rows $1 | columns $2;
}
