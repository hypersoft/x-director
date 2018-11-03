function write-parameter-pipe() {
  printf "%s$RSO" "$@";
}

function read-parameter-pipe() {
  local lines;
  readarray lines;
  "$@" "${lines[@]%$RSI}";
}

function realpaths() {
  for arg; do printf "%s$RSO" "$(realpath "$arg")" || continue; done;
  true;
}

function parents() {
  for arg; do
    [[ $arg == / ]] && continue;
    printf "%s$RSO" "$(dirname "$arg")" || continue;
  done;
  true;
}

function names() {
  for arg; do
    [[ $arg == / ]] && continue;
    printf "%s$RSO" "$(basename "$arg")" || continue; 
  done;
  true;
}

function files() {
  for file; do [[ -d "$file" ]] && continue; [[ -e "$file" ]] && printf "%s$RSO" "$file"; done;
  true;
}

function directories() {
  for file; do 
    if [[ -d $file ]]; then printf "%s$RSO" "$file"; fi;
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
