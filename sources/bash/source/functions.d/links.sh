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
