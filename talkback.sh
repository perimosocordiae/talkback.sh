# talkback.sh - Have your computer read back the commands you run.
# Usage: source talkback.sh

# TODO: set this more intelligently for non-Mac systems.
text_to_speech='say'

# Function that runs before the command is executed.
# Add more -e replacements to the sed call as needed.
preexec () {
  cmd=`sed -e 's/\./ dot /g' \
           -e 's/\|/ pipe /g' \
           -e 's/\*/ star /g' \
           <<<$@`
  sh -c "$text_to_speech \"$cmd\" &" 2>/dev/null;
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
  local this_command=`history 1 | sed -e "s/^[ ]*[0-9]*[ ]*//"`;
  preexec "$this_command"
}

trap 'preexec_invoke_exec' DEBUG

