# Modules

Import-Module posh-git

Invoke-Expression (& {
    oh-my-posh init pwsh --config "C:\dotfiles\.config\ohmyposh\themes\tiramisu.omp.toml"
})

Invoke-Expression (& {
    zoxide init powershell | Out-String
})

# Remove conflicting aliases
Remove-Item Alias:gp -Force -ErrorAction SilentlyContinue
Remove-Item Alias:gl -Force -ErrorAction SilentlyContinue
Remove-Item Alias:gc -Force -ErrorAction SilentlyContinue
Remove-Item Alias:gi -Force -ErrorAction SilentlyContinue
Remove-Item Alias:gm -Force -ErrorAction SilentlyContinue
Remove-Item Alias:cd -Force -ErrorAction SilentlyContinue

# Git functions
function gp { git push @args }
function gl { git log --oneline --graph --decorate @args }
function gc { git commit -m @args }
function gst { git status }
function ga { git add . }
function gdev { git switch develop }
function gd { git diff $args }

# ZOxide functions (aliasing)
function cd { z $args }
## function cd { z }
## function cd { z }
## alias cd=z
## alias cdi=zi
## alias cdh='zoxide query -l -s | less'

# General utilities
function reload {  . $PROFILE }
function which { Get-Command @args }
function ll { Get-ChildItem -Force | Format-Table Mode, LastWriteTime, Length, Name -AutoSize }
function la { Get-ChildItem -Force | Format-Table Mode, LastWriteTime, Length, Name -AutoSize }
function ld { Get-ChildItem -Directory -Force | Format-Table Mode, LastWriteTime, Length, Name -AutoSize }
function lf { Get-ChildItem -File -Force | Format-Table Mode, LastWriteTime, Length, Name -AutoSize }

