col1='blue'
col2="white"
col3="green"
col4="blue"
mfg=$col1
mbg=$col2
local ret_status="%(?:%{$bg[green]$fg[white]%} ✔ %{$bg[$col1]$fg[green]%}:%{$bg[red]$fg[white]%} ❌ %{$bg[$col1]$fg[red]%})"


PROMPT='$ret_status$(splitpath "$(pwd | sed "s;$HOME;/~;")")%{$reset_color%} '
# PROMPT='$RANDOM'
# PROMPT='$RANDOM $(my_random)'
# function my_random(){
#   echo $RANDOM
# }

ZSH_THEME_GIT_PROMPT_PREFIX="$fg[magenta]"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_CLEAN=""

function output_section(){
  if [ "$2" -eq "1" ]; then
    mbg=$col2
    mfg=$col1
  else
    mbg=$col1
    mfg=$col2
  fi
  echo "%{$bg[$mbg]$fg[$mfg]%} $1 "
  if [ "$3" -eq "3" ]; then
    echo "%{$reset_color$fg[$mbg]%}"
    return
  fi
  echo "%{$bg[$mfg]$fg[$mbg]%}"
}

function splitpath(){
  IN=$1
  x=0
  info=$(git_prompt_info)
  if [ $#info -gt "0" ]; then
    IN="$IN | $info"
    x=3
  fi
  a=("${(@s|/|)IN}")
  if [ $#1 -eq "1" ]; then
    echo -n $(output_section "" 0 3)
    return
  fi
  for (( i=2; i<=$#a; i++ ));
  do
    if [ "$i" -eq $#a ]; then
      echo -n $(output_section $a[$i] $((i%2)) 3)
    else
      echo -n $(output_section $a[$i] $((i%2)))
    fi
done

}
