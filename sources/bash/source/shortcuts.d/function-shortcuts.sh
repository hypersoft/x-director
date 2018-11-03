function -r() {
  call "$@" | read-parameter-pipe  realpaths;
}

function -l() {
  call "$@" | read-parameter-pipe  links --;
}

function -L() {
  call "$@" | read-parameter-pipe  links -e --;
}

function -p() {
  call "$@" | read-parameter-pipe  parents;
}

function -n() {
  call "$@" | read-parameter-pipe  names;
}

function -s:() {
  [[ $1 == u ]] && {
    shift;
    call "$@" | uniq;
    return;
  }
  [[ $1 == v ]] && {
    shift;
    call "$@" | sort -V;
    return;
  }
  [[ $1 == n ]] && {
    shift;
    call "$@" | sort;
    return;
  }
  echo "$COMMAND: error: no sorting solution found for: $1";
  exit 1;
}

function -e:() { # runs exclusive filter; matches should be seprated by IFS[0-2]
  call "${@:2}" | filter -e -- $1;
}

function -i:() { # runs inclusive regular expression filter; matches should be seprated by IFS[0-2]
  call "${@:2}" | filter -- $1;
}

function -f() { # filters content by existing files
  call "$@" | read-parameter-pipe  files;
}

function -d() { # filters content by existing directories
  call "$@" | read-parameter-pipe  directories;
}
