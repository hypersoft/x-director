
declare -A profile

function create-opkit-profile() {

  opkit.begin profile;

  local short=$(write-parameter-pipe $OPTIONS | subset '^\--?' '' ':' '' '([a-z]+-?[a-z])+' '');
	# echo $short
	opkit.set profile [SHORT]="${short}"

	local long=$(write-parameter-pipe $OPTIONS | subset '^-[a-zA-Z]:?' '' '^--' '')
	#echo $long
	opkit.set profile [LONG]="${long}"

	local settings=$(write-parameter-pipe $OPTIONS | filter -- '\:$' | subset '^-|\:$' '')
	#echo $settings
	opkit.set profile [SETTINGS]="$settings"

	local has_default=$(write-parameter-pipe $short | uniq -D | uniq)
	#echo $has_default
	opkit.set profile [HAS_DEFAULT]="${has_default}"
	
}

function debug.dump.trace() {
{
  (( DEBUG )) || return 0;
      echo
      echo $command trace: 
      echo
      echo $'  0 '[:OUT-\>]
      echo  '  + '[compile]
      echo $'  1 'read OPTIONS left to right, for logical [dependency] order
      echo $'  + '[direction-flip: enter/exit/return]
      echo $' -1 'read right to left for output [composition] order.
      echo $'  = '[\(in function-level operations\)]
      echo $'  0 '[\<-IN: back through call chain]
      echo
      echo [OUT] $trace [IN]
      echo
    };
}

function call() {

  (( $# == 0 )) && {
    echo $COMMAND: error: invalid call: "no parameters were specified for the call with: ${trace/*<- /}";
    exit 1;
  } >&2;
  
  local name TRACE=${trace}
  [[ "$1" != trace ]] && trace+=" <- $1";

  key-within-list "$1" -- $(echo $FUNCTIONS) && debug.dump.trace

  key-within-list "$1" -- $OPTIONS $FUNCTIONS && { 
    "$@"; exit $?; 
  };
  
  declare -A operation;

  opkit.parse profile operation "$@" || {
    echo "$COMMAND parameter parse error: code: $?: parameter #${operation[POINT]} didn't parse" >&2;
    opkit.dump operation;
    exit $code;
  }
  
  (( operation[BRANCH] > 5 )) && {
    local cmd="-${operation[PARAMETER]}";
    (( operation[SIZE] == 2 )) && cmd+=":";
    opkit.set profile [SUBINDEX]=0;
    if [[ -n "${operation[VALUE]}" ]]; then
      $cmd: "${operation[VALUE]}" "${@:2}"; exit $?;    
    else
      $cmd -${operation[INPUT]:2} "${@:2}"; exit $?;
    fi;
  }
  
  (( DEBUG )) && opkit.dump operation;

  {
    echo invalid command: "\`$1'";
    echo "type: $COMMAND --help or $COMMAND -h for $COMMAND help";
    exit 1;
  }  >&2;
  
}

create-opkit-profile;

call "$@";

