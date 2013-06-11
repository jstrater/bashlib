#
# Source this file from your .bashrc or .bash_profile to load all of the functions defined in lib/.
# 
# Adding a line like this should do it:
#
#   . ~/path/to/bashlib.sh
#

SCRIPT_DIR="$(dirname "$BASH_SOURCE")"

for file in "$SCRIPT_DIR"/lib/*.sh ; do
  source "$file"
done
