
BAD_SUBST_PARAMS="wrong number of parameters; expected pattern and replacement parameter-pairs following options"

function subset.script() {

  local head=${head:-''} tail=${tail:-''} split=${split:-$'\1'} quote=${quote:-"'"} flags;

  # the following parameters are paired in twos:
  # $1 find-pattern, $2 replacement[, ...]
  # this format allows you to perform successive substitutions in a reliable way.

  (( $# % 2 || $# == 0 )) && {
    echo
    echo $COMMAND: ${FUNCNAME[1]}: error: $BAD_SUBST_PARAMS: an invalid number of substitution specifications were provided.
    echo
    echo $'\t'try: $COMMAND ${FUNCNAME[1]} CUT-PATTERN PASTE-TEXT[, CUT-PATTERN PASTE-TEXT[, ...]]
    echo
    exit 1;
  } >&2;

  echo -n sed -E;
  while (( $# )); do printf " -e ${quote}s%sg${quote}" "${split}${head}${1}${tail}${split}${2}${split}"; shift 2; done;
  echo ';'

}

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

function subset() {

  local content=

  (( $# == 0 )) && {
    echo
    echo "$COMMAND: $FUNCNAME: error: $BAD_SUBST_PARAMS; 0 parameters were provided"
    echo
    echo $'\t'try: $COMMAND $FUNCNAME CUT-PATTERN PASTE-TEXT[ CUT-PATTERN PASTE-TEXT[ ...]]
    echo
    exit 1;
  } >&2;

  source <(subset.script "$@");

}

BAD_FILTER_PARAMS="wrong number of parameters; expected pattern-match(es) following options"

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

function write-parameter-pipe() {
  printf "%s\n" "$@";
}

function read-parameter-pipe() {
  local lines;
  readarray lines;
  "$@" "${lines[@]%$'\n'}";
}

function catalog(){

  [[ $1 =~ ^[0-9]$ ]] && {
    local -i max=$1; shift;
  }

  [[ "$1" == -- ]] || {
    echo
    echo "$COMMAND: ${FUNCNAME}: error: directory names must be preceeded by \`--' for disambiguation of options and files"
    echo
    echo $'\t'try: $COMMAND ${FUNCNAME} [ NUMBER] -- DIRECTORY ...
    echo
    exit 1;
  } >&2;

  shift;

  local dir= file=

  if [[ "$d" == '' ]]; then local -i d=0; fi;
  d=$d+1;
  (( max > 0 && d > max )) && return;
  for dir; do
    for file in "${dir%/}"/*; do
      [ -e "$file" ] || [ -L "$file" ] || continue
      if [ -d "$file" ]; then
        printf "%s\n" "$file"
        catalog -- "$file"
      else
        printf "%s\n" "$file"
      fi
    done
  done;
  
}

function realpaths() {
  for arg; do realpath "$arg" || continue; done;
  true;
}

function parents() {
  for arg; do
    [[ $arg == / ]] && continue;
    dirname "$arg" || continue;
  done;
  true;
}

function names() {
  for arg; do
    [[ $arg == / ]] && continue;
    basename "$arg" || continue; 
  done;
  true;
}

function files() {
  for file; do [[ -d "$file" ]] && continue; [[ -e "$file" ]] && echo "$file"; done;
  true;
}

function links() {

  local -i include=1;
  
  [[ "$1" == -e ]] && { include=0; shift; }
  
  [[ "$1" == -- ]] || {
    echo
    echo "$COMMAND: ${FUNCNAME}: error: file specifications must be preceded by \`--' for disambiguation of files and options"
    echo
    echo $'\t'try: $COMMAND ${FUNCNAME[1]} [-e] -- FILE ...
    echo
    exit 1;
  } >&2;
  
  shift;
  
  (( include )) && {
    for file; do
      if [[ -h "$file" ]]; then 
        echo "$file";
      fi;
    done;
    return 0;
  }
  
  for file; do
    if [[ -h "$file" ]]; then continue; fi;
    echo "$file";
  done;
  
  return 0;
  
}

function directories() {
  for file; do 
    if [[ -d $file ]]; then echo "$file"; fi;
  done;
  true;
}

function key-within-list() { # make sure you test this result in error-mode-shells
  local key="$1"; shift;
  [[ "$1" == -- ]] || {
    echo
    echo "$COMMAND: ${FUNCNAME[1]}: error: match specifications must be preceded by \`--' for disambiguation of matches and match options"
    echo
    exit 1;
  } >&2;
  shift;
  opkit.match "$key" "$@"; 
}


