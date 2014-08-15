#!/usr/bin/env python3

from ranger.api.commands import *

import subprocess
import re

class autojump(Command):
    """:j

    Uses autojump to set the current directory.
    """

    def execute(self):
        dirlist_raw = subprocess.check_output(["autojump", "--complete", self.arg(1)])
        dirlist = dirlist_raw.decode("utf-8", "ignore").split('\n')
        if len(dirlist) > 0:
            directory = dirlist[0].strip()
            directory = re.sub('^[^/]*__/', '/', directory)
            self.fm.execute_console("cd " + directory)