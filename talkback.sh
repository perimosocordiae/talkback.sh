# talkback.sh - Have your computer read back the commands you run.
# Usage: source talkback.sh

# Set this if you know which TTS program you want.
DEFAULT_TTS=

if [ -n "$DEFAULT_TTS" ]; then
  text_to_speech="$DEFAULT_TTS"
elif [ "$(uname)" == 'Linux' ]; then
  text_to_speech='espeak'
else
  text_to_speech='say'
fi

SED='sed'
# Use 'sed -r' if we're using GNU sed.
$SED -re '' <<<'' && SED='sed -r'

# Function that runs before the command is executed.
# Add more -e replacements to the sed call as needed.
preexec () {
  cmd=$($SED -e 's/\./ dot /g' \
             -e 's/\|/ pipe /g' \
             -e 's/\*/ star /g' \
             -e 's/"//g' \
             <<<"$@")
  echo "$text_to_speech \"$cmd\""
  # sh -c "$text_to_speech \"$cmd\" &" 2>/dev/null;
}

# Idea borrowed from http://superuser.com/a/175802/74234
preexec_invoke_exec () {
  # do nothing if completing
  [ -n "$COMP_LINE" ] && return
  # don't cause a preexec for $PROMPT_COMMAND
  [ "$BASH_COMMAND" = "$PROMPT_COMMAND" ] && return
  # get the previous command from history
  # Note: this isn't always the last command executed,
  # depeding on the user's history configuration.
  local this_command=$(history 1 | $SED -e "s/^[ ]*[0-9]*[ ]*//");
  preexec "$this_command"
}

trap 'preexec_invoke_exec' DEBUG

