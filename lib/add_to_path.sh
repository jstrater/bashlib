# Adds the given paths to the beginning of $PATH if they are valid directories.
#
# Example:
#   prepend_to_path /opt/local/bin
prepend_to_path() {
   __add_to_path prepend "$@"
}

# Adds the given paths to the end of $PATH if they are valid directories.
#
# Example:
#   append_to_path /usr/local/heroku/bin
append_to_path() {
   __add_to_path append "$@"
}

# Helper used by the above functions.
#
# usage: __add_to_path prepend|append [NEW_PATH_COMPONENT ...]
__add_to_path() {
  local whichEnd=$1; shift

  for newPathElt in "$@" ; do
    if [[ -d "$newPathElt" ]] ; then
      if [[ $whichEnd == append ]] ; then
        export PATH="$PATH":"$newPathElt"
      elif [[ $whichEnd == prepend ]] ; then
        export PATH="$newPathElt":"$PATH"
      else
        return 1
      fi
    fi
  done
}
