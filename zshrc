PS1="%F{001}%n%f in %d > "

platform='unknown'
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        platform='linux'
elif [[ "$OSTYPE" == "darwin"* ]]; then
        platform='macos'
elif [[ "$OSTYPE" == "cygwin" ]]; then
        platform='cygwin'
elif [[ "$OSTYPE" == "freebsd"* ]]; then
        platform='freebsd'
else
        echo "No OS Name detected"
fi

#|-----------------------------|
#|           ALIASES           |
#|-----------------------------|
if [[ $platform == 'macos' ]]; then

    alias ls="ls -FAG"

    alias brewrm="brew uninstall --zap"

    alias unquarantine="sudo xattr -dr com.apple.quarantine"

    alias emacs="open -a Emacs.app"

elif [[ $platform == 'linux' ]]; then

   alias ls='ls -G'

fi

alias youtube-dl-vid="youtube-dl -o '%(title)s.%(ext)s'"
alias youtube-dl-pl="youtube-dl -o '%(playlist_index)s-%(title)s.%(ext)s'"

#|-----------------------------|
#|           SCRIPTS           |
#|-----------------------------|


if [[ $platform == 'macos' ]]; then
   flushDNScache (){
       sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder
    }

elif [[ $platform == 'linux' ]]; then

fi

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
