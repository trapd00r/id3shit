id3shit
===========
All id3-editors that I've tried sucked. So does id3shit, but not as much.

    USAGE: /home/scp1/bin/id3shit [OPTIONS] <FILES>

    OPTIONS:
      -t  --tags    Show ID3V{1,2} tags
      -i  --info    Show audio information
      -r  --remove  Remove known tags
      -w  --write   Write tags. The syntax is --write FIELD VALUE FILE
                    Legal fields are ARTIST, ALBUM, TITLE, YEAR, COMMENT,
                    TRACKNUM, GENRE.

                    Examples:
                    --write artist laleh *.mp3
                    Will give us something like:
                    >> ARTIST: Laleh


License
=======
Copyright (C) 2010 trapd00r

This program is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License, version 2, as published by the
Free Software Foundation.
