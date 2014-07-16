talkback.sh
===========

Have your terminal speak your commands.

## Usage

```bash
source talkback.sh
```

Then, use your terminal as usual,
and enjoy as all of the commands you issue
are spoken back to you.

## Caveats

So far, this has only been tested on OS X and Ubuntu 14.04.
For Ubuntu support, you'll need `espeak` (available via `apt-get`).

For support on other systems, or to use a custom TTS program,
edit the `DEFAULT_TTS` variable to your text-to-speech engine of choice.

## Why?

Why not?

But more seriously,
I find that having spoken confirmation of commands helps keep my focus and attention.
