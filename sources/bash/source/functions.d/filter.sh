BAD_FILTER_PARAMS="wrong number of parameters; expected pattern-match(es) following options"

function filter.script() {

    local head=${head:-''} tail=${tail:-''} quote=${quote:-"'"} flags;

    [[ "$1" == -e ]] && { # for invert match == '-e[xclude]'
      flags="-v"; shift;
    }

    [[ "$1" == -- ]] || {
      echo
      echo "$COMMAND: ${FUNCNAME[1]}: error: match specifications must be preceded by \`--' for disambiguation of matches and match options"
      echo
      exit 1;
    } >&2;
    
    shift;
    
    echo -n grep -E $flags;
    while (( $# )); do printf " -e ${quote}${head}%s${tail}${quote}" "$1"; shift; done; 
    echo ';';
    
}

function filter() {

  (( $# == 0 )) && {
    echo
    echo "$COMMAND: $FUNCNAME: error: $BAD_FILTER_PARAMS; 0 parameters were provided"
    echo
    echo $'\t'try: $COMMAND $FUNCNAME [OPTIONS] -- MATCH-PATTERN ...
    echo
    exit 1;
  } >&2;

  source <(filter.script "$@");

}
