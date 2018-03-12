#!/bin/bash

# make sure the file to store the last selection exists
f=~/.old_sel
touch $f
x=390
y=650
w=500
font="Inconsolata:size=12"
seconds=3

if [ "$1" != "" ]; then
	showdzen $1
	return 1
fi


showdzen()
{
    query=$(echo $1 | xargs) #trim leading and trailing whitespace
    if [ -z "$query" ]; then #exit on empty string
        return 1
    fi
    translation=$(translate $query)
    # numlines=$(($(echo -e "$translation" | wc -l) - 1))
    numlines=5
    echo "${query}:$(translate $query)" |
    dzen2 -p $seconds -x $x -y $y -w $w -l $numlines \
    -sa 'c' -ta 'c'\
    -fg "#EEEEEE"\
    -title-name 'dictionary'\
    -e 'onstart=uncollapse,grabkeys,scrollhome;\
        key_Up=scrollup;\
        key_k=scrollup;\
        key_Down=scrolldown;\
        button4=scrolldown;\
        key_j=scrolldown;\
        key_Escape=exit;\
        key_Enter=exit;\
        button1=exit;\
        button3=exit;\
        key_q=exit'\
    -fn "$font"
}

translate()
{
    echo "$(python2 /home/ergo/bin/dict.cc.py en de "$@")"
}

# get the previous & current selection
old=$(cat "$f"); current=$(xsel -o)
if [ "$old" = "$current" ]; then
    showdzen $(dmenu -noinput -x $x -y $y -w $w\
                     -p "Translate: " -fn "$font" -sb "#000000")
else
  # if selection changed, store the current selection to remember
  echo "$current" > "$f"
  showdzen $current
fi
