#!/bin/sh

# ========================================================
# Check if there are locked files inside a SVN repository
# and report offender(s)
#
# Synopsis:
#     $ cd <My_SVN_working_copy>
#     $ svn-check-lockers.sh
# ========================================================

#set -x
set -e

#REPO_ROOT="https://svn.genivi.org/uml-model/genivi/branch/eg-si"
REPO_ROOT=$(svn info | grep -e '^URL:' | cut -d ' ' -f2)

echo "DEBUG: REPO_ROOT=${REPO_ROOT}"

svn status --show-updates | grep "O" | while read line; do
    #echo "DEBUG: Parsing line=$line"
    f=$(echo $line | cut -d ' ' -f3-)
    #echo "DEBUG: f=$f"
    lown=$(svn info "${REPO_ROOT}/${f}" | grep -e '^Lock Owner:' | cut -d ' ' -f3)
    #echo "DEBUG: lown=$lown"
    echo -e "${lown} | ${f}"
done

# EOF
