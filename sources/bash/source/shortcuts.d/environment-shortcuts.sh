function --get-theatre() {
  echo OPTIONS=\"${OPTIONS}\";
  echo FUNCTIONS=\"${FUNCTIONS}\";
}

function -h() {
  (( $# == 0 )) && {
    --help
  }
  REH=\^ call "${@}";
}

function trace() {
  DEBUG=1 call "$@";
}

function -q:() {
  REQ=$1 call "${@:2}";
}

function -Q:() { # this option only affects subset
  RES=$1 call "${@:2}";
}

function -t() {
  RET=\$ call "${@}";
}

function -t:() {
  RET=$1 call "${@:2}";
}

function -h:() {
  REH=$1 call "${@:2}";
}

function -z() { # reset IFS
  IFS=$' \t\n' call "$@";
}

function -z:() { # sets IFS: PARAMETER
  IFS=$1 call "${@:2}";
}
