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
