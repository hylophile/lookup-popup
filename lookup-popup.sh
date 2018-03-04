#!/bin/bash

# make sure the file to store the last selection exists
f=~/.old_sel
touch $f
x=390
y=100
w=500
font="Inconsolata:size=12"

showdzen()
{
    translation=$(translate $1)
    numlines=$(($(echo -e "$translation" | wc -l) - 1))
    echo "${1}:$(translate $1)" |
    dzen2 -p 5 -x $x -y $y -w $w -l $numlines \
    -sa 'c' -ta 'c'\
    -fg "#EEEEEE"\
    -title-name 'dictionary'\
    -e 'onstart=uncollapse,grabkeys,scrollhome;key_Down=scrolldown;key_Up=scrollup;button4=scrolldown;key_Escape=exit;button1=exit;button3=exit;key_q=exit;key_j=scrolldown;key_k=scrollup'\
    -fn "$font"
}

translate()
{
    echo "$(python2 /home/ergo/bin/dict.cc.py en de "$@")"
}

# get the previous & current selection
old=$(cat "$f"); current=$(xsel -o)
if [ "$old" = "$current" ]; then
  showdzen $(dmenu -noinput -x $x -y $y -w $w -p "Translate: " -fn "$font" -sb "#000000")
else
  # if selection changed, store the current selection to remember
  echo "$current" > "$f"
  showdzen $current
fi
