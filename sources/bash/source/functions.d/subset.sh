BAD_SUBST_PARAMS="wrong number of parameters; expected pattern and replacement parameter-pairs following options"

function subset.script() {

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
  while (( $# )); do printf " -e ${REQ}s%sg${REQ}" "${RES}${REH}${1}${RET}${RES}${2}${RES}"; shift 2; done;
  echo ';'

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
