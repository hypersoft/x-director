function --get-theatre() {
  echo OPTIONS=\"${OPTIONS//$'\n'/ }\";
  echo FUNCTIONS=\"${FUNCTIONS//$'\n'/ }\";
}

function -h() {
  (( $# == 0 )) && {
    --help
  }
  head=\^ call "${@}";
}

function trace() {
  DEBUG=1 call "$@";
}

function -q:() {
  quote=$1 call "${@:2}";
}

function -Q:() { # this option only affects subset
  split=$1 call "${@:2}";
}

function -t() {
  tail=\$ call "${@}";
}

function -t:() {
  tail=$1 call "${@:2}";
}

function -h:() {
  head=$1 call "${@:2}";
}

function -z() { # reset IFS
  IFS=$' \t\n' call "$@";
}

function -z:() { # sets IFS: PARAMETER
  IFS=$1 call "${@:2}";
}
