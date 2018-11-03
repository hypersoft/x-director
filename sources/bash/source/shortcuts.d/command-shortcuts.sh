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
