#!/usr/bin/env bash

session="mysessionname"
base_dir=`dirname $0`/..

ARG1="../standard/local-up.sh" 
ARG2="sleep 20 && docker-compose run --rm app flask db upgrade" 
ARG3="sleep 25 && pushd ../server && poetry run python ./seed/local-seed.py && popd "

main ()
{

    createSession
    separateScreens
    updateScreens $@
    connectSession
}

createSession ()
{
    tmux new -A -d -s $session
}

connectSession ()
{
    tmux ls
    tmux a -t $session
}

separateScreens ()
{
    tmux split-window -h bash
    tmux split-window -v bash
    tmux split-window -v bash
}

sendCommandToScreen ()
{
    tmux send -t "$session:0.$1" "${*:2}" C-m
}

updateScreens ()
{
    updateScreenA $1 &
    updateScreenB $2 &
    updateScreenC $3 &
    updateScreenD $4 ;
}

screenA ()
{
    sendCommandToScreen 0 "$@"
}

screenB ()
{
    sendCommandToScreen 1 "$@"
}

screenC ()
{
    sendCommandToScreen 2 "$@"
}

screenD ()
{
    sendCommandToScreen 3 "$@"
}

updateScreenA ()
{
    screenA $ARG1
}

updateScreenB ()
{
    screenB $ARG2
}

updateScreenC ()
{
    screenC $ARG3
}

updateScreenD ()
{
    screenD $1
}


main $@
