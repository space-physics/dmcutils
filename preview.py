#!/usr/bin/env python
"""
UNTESTED NOT YET WORKING

simple web server with polling of latest image for Andor Neo Spool Files
uses OpenCV 3 with Python 3.6
Michael Hirsch

Prereqs: pip install flask flask-limiter

./preview.py ~/datadir
"""
from pathlib import Path
from time import sleep
import sys
import subprocess

sys.tracebacklimit = 1

serverlogfn = Path('~/server.log').expanduser()
previewlogfn = Path('~/live.log').expanduser()

def preview_image_web(htmldir:Path):
    htmldir = Path(htmldir).expanduser()
    if not htmldir.is_dir():
        raise FileNotFoundError(f'{htmldir} not found')

    servlog = serverlogfn.open('a')
# %% detect if server already running, if not, start it
    subprocess.Popen(['nice','-n','15','python','Webserver.py','8088'],
                     stderr=servlog)

# %% every N seconds (600=10 minutes) update the preview
    """
    Note because of non-sequential file naming, this takes a few minutes each time,
     proportional to the rapidly increasing number of spool files...
    """
    previewlog = previewlogfn.open('a')

    while True:
        subprocess.run(['nice','-n','19','python','-u','live_preview_neospool.py',
                          str(htmldir)],
                         stderr=previewlog)
        sleep(10)

if __name__ == '__main__':
    from argparse import ArgumentParser
    p = ArgumentParser()
    p.add_argument('htmldir',help='directory to serve preview image from')
    p = p.parse_args()

    preview_image_web(p.htmldir)
