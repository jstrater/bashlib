# Opens an editor for the specifed command after looking up its location. Works
# on shell functions too.
#
# Examples:
#   $ viscript my_ruby_script.rb
#   <opens /usr/local/bin/my_ruby_script.rb>
#
#   $ viscript my_shell_function
#   <opens .bashrc and navigates to the line where my_shell_function is defined>
#
#   $ viscript my_shell_alias
#   alias my_shell_alias cannot be edited with viscript
function viscript() {
  local cmd="$1"

  # Print help if no arg given
  if [[ -z "$cmd" ]] ; then
    echo "usage: viscript script_name" 1>&2
    echo "  where script_name is somewhere in \$PATH" 1>&2
    return 1
  fi

  # Find out if we're dealing with a shell function, executable file, or something else
  local argtype="$(type -t "$cmd")"
  if [[ -z "$argtype" ]] ; then
    echo "not found: $cmd" 1>&2
    return 1
  fi

  # Look up definition file path & line number
  local lineno=0
  case $argtype in
    # A shell function. See if we can look up the definition file & line no.
    function )
      path="$(shopt -s extdebug ; declare -F "$cmd" | gawk '{sub(/^ *([^ ]+ +){2}/,"");print}')"
      lineno="$(shopt -s extdebug ; declare -F "$cmd" | awk '{print $2}')"
      if [[ "$path" == '(null)' ]] ; then
        echo "no source file found for function: $cmd" 1>&2
        return 1
      fi;;

    # An executable file. Look up the path.
    file )
      path="$(type -p "$cmd")";;

    # Some other creature we don't know how to deal with
    * )
      echo "$argtype $cmd cannot be edited with $FUNCNAME" 1>&2 ; return 1;;
  esac

  # Open the editor.
  # Only include +line_number if the editor supports it (vim)
  if [[ "$EDITOR" =~ ^((g|m|r)?vim|vi|(gnu|l|x|g)?emacs) ]] ; then
    $EDITOR "$path" +$lineno
  else
    $EDITOR "$path"
  fi
}
