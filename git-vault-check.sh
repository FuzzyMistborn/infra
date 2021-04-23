#!/bin/bash
#
# Pre-commit hook that verifies if all files containing 'vault' in the name
# are encrypted.
# If not, commit will fail with an error message
#
# Original author: @ralovely
# https://www.reinteractive.net/posts/167-ansible-real-life-good-practices
# 
# Credit to https://gist.github.com/leucos/a9f42e111a8cfc2ebf6e
#
# Modified to run on Ubuntu
#
# File should be .git/hooks/pre-commit and executable
FILES_PATTERN='.*vault.*\.*$|digital_ocean\.ini|do_env\'
REQUIRED='ANSIBLE_VAULT'

EXIT_STATUS=0
wipe="\033[1m\033[0m"
yellow='\033[1;33m'
# carriage return hack. Leave it on 2 lines.
cr='
'
for f in $(git diff --cached --name-only | grep -E $FILES_PATTERN)
do
  # test for the presence of the required bit.
  MATCH=`git show :$f | head -n1 | grep --no-messages $REQUIRED`
  if [ ! $MATCH ] ; then
    # Build the list of unencrypted files if any
    UNENCRYPTED_FILES="$f$cr$UNENCRYPTED_FILES"
    EXIT_STATUS=1
  fi
done
if [ ! $EXIT_STATUS = 0 ] ; then
  echo '# COMMIT REJECTED'
  echo '# Looks like unencrypted ansible-vault files are part of the commit:'
  echo '#'
  while read -r line; do
    if [ -n "$line" ]; then
      echo -e "#\t${yellow}unencrypted:   $line${wipe}"
    fi
  done <<< "$UNENCRYPTED_FILES"
  echo '#'
  echo "# Please encrypt them with 'make encrypt'"
  exit $EXIT_STATUS
fi
exit $EXIT_STATUS
