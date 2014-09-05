# Git functions+aliases
# I suck at PS, so this can probably be done muuuuuch better.
# Copy into your PS profile folder and then add the following line to your profile:
# . .\git-functions.ps1
# Use ". $PROFILE" to reload your profile and these functions+aliases will be active.

function git-status {
	git status -u
}
Set-Alias -Name gs -Value git-status

function git-all-branches {
	git for-each-ref --sort=-committerdate --format='%(committerdate:short) %(refname:short) [%(committername)]'
}
Set-Alias -Name gblist -Value git-all-branches

function git-log {
	#git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' 
	git log --pretty=format:"%C(magenta)%h %C(yellow) %ad%C(bold)%C(cyan)%d %C(white)%s%Creset%Cblue %cn" --decorate --date=relative --graph --abbrev-commit
}
Set-Alias -Name glog -Value git-log

function git-log-branchtag {
	git log --simplify-by-decoration --graph --all --abbrev-commit --date=relative --branches --abbrev-commit --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) <%an>%Creset%n' 
}
Set-Alias -Name glogbt -Value git-log-branchtag

function git-branchnew {
	$branch = $args[0]
	git checkout -b $branch
}
Set-Alias -Name gbnew -Value git-branchnew

function git-branchshare {
	$branch_to_publish = $args[0]
	if($branch_to_publish -eq "") {
		return
	}
	git push origin $branch_to_publish
	git fetch origin
	git config branch.$branch_to_publish.remote origin
	git config branch.$branch_to_publish.merge refs/heads/$branch_to_publish
	git checkout $branch_to_publish
}
Set-Alias -Name gbshare -Value git-branchshare

function git-branchtrack {
	$branch_to_track = $args[0]
	if($branch_to_track -eq "") {
		return
	}
	git fetch origin
	git branch --track $branch_to_track origin/$branch_to_track
	git checkout $branch_to_track
}
Set-Alias -Name gbtrack -Value git-branchtrack

function git-branchdelete {
	$branch_to_delete = $args[0]
	if($branch_to_delete -eq "") {
		return
	}
	git push origin :refs/heads/$branch_to_delete
	git branch -d $branch_to_delete
}
Set-Alias -Name gbdelete -Value git-branchdelete

function git-branchclean {
	write "Running 'git remote prune origin'..."
	git remote prune origin
}
Set-Alias -Name gbclean -Value git-branchclean

function git-undo {
	git reset --soft HEAD^
}
Set-Alias -Name gundo -Value git-undo

function git-checkout {
	git checkout $args
}
Set-Alias -Name gco -Value git-checkout

function git-checkout-aciss {
	kill -Name VB6 -erroraction 'silentlycontinue';iisreset;git checkout $args
}
Set-Alias -Name gcoa -Value git-checkout-aciss

function git-commit-all {
	git add -A
	git commit $args
}
Set-Alias -Name gca -Value git-commit-all

function git-commit-all-with-msg {
	if ($args.length -eq 0) {
		write "You must specify a commit message!"
		return
	}
	git add -A
	git commit -m $args[0]
}
Set-Alias -Name gcam -Value git-commit-all-with-msg

function git-ammend-all {
	git add -A
	git commit --amend
}
Set-Alias -Name gaa -Value git-ammend-all

function git-search-all-history {
	git rev-list --all | xargs git grep -F $args[0]
}
Set-Alias -Name gsearch -Value git-search-all-history

function git-my-last-week {
	git log --since '8 days ago' --oneline --author 'dotjosh@gmail.com'
}
Set-Alias -Name glogweek -Value git-my-last-week

function git-fetch-all {
	write "Fetching everything..."	
	git fetch --all
	write "Pruning branches"
	git fetch --all --prune
	write "Pruning tags"
	git fetch --all --prune --tags
} 
Set-Alias -Name gfa -Value git-fetch-all
Set-Alias -Name gfreeup -Value git-fetch-all
