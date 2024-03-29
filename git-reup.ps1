# Like git-pull but show a short and sexy log of changes
# immediately after merging (git-up) or rebasing (git-reup).
#
# Inspired by Kyle Neath's `git up' alias:
# http://gist.github.com/249223
#
# Stolen from Ryan Tomayko
# http://github.com/rtomayko/dotfiles/blob/rtomayko/bin/git-up
# and then Zach Holman
# https://github.com/holman/dotfiles/blob/master/bin/git-up
function git-reup {
	$old_head = (& git rev-parse HEAD 2>&1 | Out-String).Substring(0, 7)

	$msg = (& git stash save "Auto-stash by greup script" 2>&1 | Out-String)

	$stashed = ($msg.Contains("No local changes to save") -eq $False)

	git pull --rebase
	$new_head = (& git rev-parse HEAD 2>&1 | Out-String).Substring(0, 7)

	$updated = $old_head -ine $new_head

	if ($stashed) {
		& git stash pop --quiet
	}

	if ($updated) {
	    write "Diffstat:"
		$args = @("--no-pager", "diff", "--color", "--stat", ($old_head + '..'))
		(& git $args)

		write "Log:"
		$args = @("log", "--color", "--pretty=oneline", "--abbrev-commit", ($old_head + '..'))
		(& git $args)
	}
}
Set-Alias -Name greup -Value git-reup
