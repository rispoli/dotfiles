# Eli Bendersky's persistent history (http://eli.thegreenplace.net/2013/06/11/keeping-persistent-history-in-bash/)
log_bash_persistent_history()
{
    [[
    $(history 1) =~ ^\ *[0-9]+\ +([^\ ]+\ [^\ ]+)\ +(.*)$
    ]]
    local date_part="${BASH_REMATCH[1]}"
    local command_part="${BASH_REMATCH[2]}"
    if [ "$command_part" != "$PERSISTENT_HISTORY_LAST" ]
    then
        echo $date_part "|" "$command_part" >> ~/.persistent_history
        export PERSISTENT_HISTORY_LAST="$command_part"
    fi
}

# Stuff to do on PROMPT_COMMAND
run_on_prompt_command()
{
    log_bash_persistent_history
}

PROMPT_COMMAND="run_on_prompt_command"
alias ls='ls --color=auto'
alias xterm='xterm -bg black -fg white'

alias irb='irb --readline -r irb/completion'
alias ocaml='rlwrap ocaml'
alias racket='rlwrap racket'

alias jazz='mplayer -playlist $HOME/projects/radio/radioswissjazz.m3u -cache 1024 -demuxer aac -softvol'
alias classic='mplayer -playlist $HOME/projects/radio/radioswissclassic.m3u -cache 1024 -demuxer aac -softvol'
alias medieval='mplayer -playlist $HOME/projects/radio/ancientfm.pls -cache 1024 -softvol'

alias lasvistas='$HOME/scripts/webcam.sh http://webcamftp.arona.org/webcam/webcam/LasVistas1.jpg 60'
alias hermanns='$HOME/scripts/webcam.sh http://web18.ms41.de.kolido.net/webcam.jpg 60'
alias puertocolon='$HOME/scripts/webcam.sh http://usuarios.lycos.es/canariaswebcam/webcam/puertocolon.jpg 60'

alias log='$HOME/scripts/log.sh'

alias dus='du -s * | sort -n | cut -f 2- | xargs -Ix du -hs x'

alias img_server='ssh daniele@img-server.di.unito.it -i $HOME/.ssh/img-server'
alias legal_informatics='ssh handler@legal-informatics.di.unito.it -i $HOME/.ssh/legal-informatics'

PS1='\[\033[01;31m\](\[\033[01;37m\]\t\[\033[01;31m\] - \[\033[01;37m\]\u@\h \w\[\033[01;31m\])\[\033[00m\]\$ '

export LC_ALL='en_US.UTF-8'

export SVN_EDITOR='vim'
export GIT_EDITOR='vim'

export HISTIGNORE="&:ls:[bf]g:exit"
