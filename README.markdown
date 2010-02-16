Chromium Upgrader for Mac OS X
==============================

[Chromium](http://www.chromium.org/) is a free open source Web browser based on [Webkit](http://webkit.org/) and represents a credible alternative to [Chrome](http://www.google.com/chrome), the Google Web browser.

While Chrome offers built-in automatic updates, Chromium.app strangely doesn't: you're supposed to download manually the latest build, unzip it and replace your previous version with it. As it may sound dead simple at first glance, this task can become especially boring when done on a daily basis. So this script will try to upgrade to latest OS X Chromium build on your system via the command line.

Installation
------------

1. the download way

    $ cd ~/bin
    $ curl -O http://gist.github.com/gists/304554/download
    $ tar xvzf download
    $ mv gist304554-*/getchromium.sh .
    $ chmod +x getchromium.sh

2. The git way 

    $ cd ~/bin
    $ git clone git://gist.github.com/304554.git .
    $ chmod +x getchromium.sh

Usage
-----

Run it that way:

    $ ./getchromium.sh

Notes
-----

*Use with CAUTION*, quick and dirty homemade script. At least, works on my box.

The script is intented and only intended to be used on Mac OS X Snow Leopard (10.6.x) but might be ported to other \*n*x OSes. Feel free to send any patch or pull request if you want to contribute enhancements.