function write-parameter-pipe() {
  printf "%s\n" "$@";
}

function read-parameter-pipe() {
  local lines;
  readarray lines;
  "$@" "${lines[@]%$'\n'}";
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
    echo "$COMMAND: ${FUNCNAME[1]}: error: match specifications must be preceded by \`--' for disambiguation of matches and match key"
    echo
    exit 1;
  } >&2;
  shift;
  opkit.match "$key" "$@"; 
}
