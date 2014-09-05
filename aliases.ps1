function dirup {
	Set-Location -Path ..
}
Set-Alias -Name .. -Value dirup

function devdir {
	Set-Location -Path C:\Development
}
Set-Alias -Name dev -Value devdir

function notepadplus {
	& "C:\Program Files (x86)\Notepad++\notepad++.exe" $args
}
Set-Alias -Name npp -Value notepadplus

function sublime {
	& "C:\Stuff\Dropbox\Tools\Sublime Text 2\sublime_text.exe" $args
}
Set-Alias -Name subl -value sublime

function sublimehere {
	& "C:\Stuff\Dropbox\Tools\Sublime Text 2\sublime_text.exe" .
}
Set-Alias -Name sublhere -value sublimehere

function explorehere {
	explorer .
}
Set-Alias -Name exp -Value explorehere

function gitextensions {
	& "C:\Program Files (x86)\GitExtensions\GitExtensions.exe" $args
}
Set-Alias -Name gx -Value gitextensions