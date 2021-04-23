#!/bin/bash
# sets up a pre-commit hook to ensure that vault.yaml is encrypted
#

if [ -d .git/ ]; then
rm .git/hooks/pre-commit
fi
cp git-vault-check.sh .git/hooks/pre-commit

chmod +x .git/hooks/pre-commit