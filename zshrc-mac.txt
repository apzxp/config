PS1="%F{001}%n%f in %d > "

#------------------------------------------------------------------------
# Aliases

alias ls="ls -FAG"
alias brewrm="brew uninstall --zap"
alias unquarantine="sudo xattr -dr com.apple.quarantine"

alias youtube-dl-vid="youtube-dl -o '%(title)s.%(ext)s'"
alias youtube-dl-pl="youtube-dl -o '%(playlist_index)s-%(title)s.%(ext)s'"

#------------------------------------------------------------------------
# Scripts

flushDNScache (){
    sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder
}
resetLaunchpad (){
    defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock
}
resetDock (){
    defaults delete com.apple.dock; killall Dock
}

mkcd () {
    mkdir "$1"
    cd "$1"
}

scanpdf () {
    convert -density 150 "$1" -rotate 0.33 -quality 100 +noise Gaussian -colorspace Gray scanned-"$1"
}

toread () {
    links -dump "$1" >> "$2"
    vim "$2"
}
