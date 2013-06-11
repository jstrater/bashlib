# Cross-platform way to check if a command (shell function or executable) exists without any output.
#
# Examples:
#   $ command_exists ls
#   <no output, exit status of 0>
#
#   $ command_exists asdfjkl
#   <no output, exit status of 1>
#
#   # A more practical use case: wrap node with readline
#   $ if command_exists rlwrap && command_exists node ; then
#   >   alias node="NODE_NO_READLINE=1 rlwrap node"
#   > fi
function command_exists () {
  type "$1" &> /dev/null
}
