set -e

source .github/travis/common.sh

# Output any changes in the repository
# ------------------------------------------------------------------------
start_section git-status "Current git status"

git diff

$SPACER

git status

end_section git-status

# Check there are not changes in the repository
# ------------------------------------------------------------------------
start_section git-check "Checking git repository isn't dirty"

(
	. "$(git --exec-path)/git-sh-setup"

	require_clean_work_tree "continue" "Please run ``make README.rst`` to generate correct ``README.rst``."
)

end_section git-check
