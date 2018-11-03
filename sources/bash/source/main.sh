
declare -A CONFIG
opkit.set CONFIG [LONG]="get-theatre help"
opkit.set CONFIG [SHORT]="t L Q r d e f h i l l p q s z n";
opkit.set CONFIG [SETTINGS]="h Q t e i l q z s"
opkit.set CONFIG [HAS_DEFAULT]="h t z"

opkit.begin CONFIG;

function dump.trace() {
{
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
  [[ $DEBUG == 1 ]] && {  
    key-within-list "$1" -- $(echo $FUNCTIONS) && dump.trace
  }  >&2;

  key-within-list "$1" -- $OPTIONS $FUNCTIONS $DEBUG_FUNCTIONS && { 
    "$@"; exit $?; 
  };
  
  declare -A parse;
  opkit.begin CONFIG;

  opkit.parse CONFIG parse "$@" || {
    echo "$COMMAND parameter parse error: code: $?: parameter #${parse[POINT]} didn't parse" >&2;
    opkit.dump parse;
    exit $code;
  }
  
  (( parse[BRANCH] > 5 )) && {
    local cmd="-${parse[PARAMETER]}";
    (( parse[SIZE] == 2 )) && cmd+=":";
    if [[ -n "${parse[VALUE]}" ]]; then
      $cmd: "${parse[VALUE]}" "${@:2}"; exit $?;    
    else
      $cmd -${parse[INPUT]:2} "${@:2}"; exit $?;
    fi;
  }
  
  (( DEBUG )) && opkit.dump parse;

  {
    echo invalid command: "\`$1'";
    echo "type: $COMMAND --help or $COMMAND -h for $COMMAND help";
    exit 1;
  }  >&2;
  
}

call "$@";

