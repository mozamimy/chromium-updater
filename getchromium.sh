#!/bin/bash
# This script will try to upgrade to latest OSX Chromium build on your system via the
# command line (right, that means you'll have to open a term and run it from there)
#
# See README for further informations

die() {
  echo "$@ => exiting" >&2
  exit 1
}

W=`whoami`
TMP="/tmp"
BASE_URL="http://commondatastorage.googleapis.com/chromium-browser-snapshots/Mac"
ARCHIVE_NAME="chrome-mac.zip"
LATEST_URL="$BASE_URL/LAST_CHANGE"
LATEST_VERSION=`curl -s -f $LATEST_URL` || die "Unable to fetch latest version number from $LATEST_URL"
PROC=`ps aux|grep -i Chromium|grep -iv grep|grep -iv $0|wc -l|awk '{print $1}'` || die "Unable to count running Chromium processes"
INSTALL_DIR="/Applications"
# Using Chromium's Info.plist to get the SVN Revision.
INSTALLED_VERSION=`defaults read $INSTALL_DIR/Chromium.app/Contents/Info SVNRevision 2>/dev/null`

# The script should never be run by root
if [[ $W == "root" ]]; then
  die "This script cannot be run as root"
fi

# Checking if latest available build version number is newer than installed one
if [[ $LATEST_VERSION -eq $INSTALLED_VERSION ]]; then
  die "You already have the latest build ($LATEST_VERSION) installed"
fi

# Testing if Chromium is currently running
if [[ ! $PROC -eq 0 ]]; then
  die "You must quit Chromium in order to install a new version"
fi

# Fetching latest archive if not already existing in tmp dir
if [[ ! -f $TMP/chromium-$LATEST_VERSION.zip ]]; then
  ARCHIVE_URL="$BASE_URL/$LATEST_VERSION/$ARCHIVE_NAME"
  echo "Fetching chromium build $LATEST_VERSION from $ARCHIVE_URL, please wait..."
  curl -O -L $ARCHIVE_URL || die "Unable to fetch version $LATEST_VERSION archive"
  mv $ARCHIVE_NAME $TMP/chromium-$LATEST_VERSION.zip || die "Unable to move downloaded archive to $TMP directory"
fi

# Unzipping
unzip -qq -u -d $TMP/chromium-$LATEST_VERSION $TMP/chromium-$LATEST_VERSION.zip || die "Unable to unzip version $LATEST_VERSION archive"

# Deleting previously installed version
if [[ -d $INSTALL_DIR/Chromium.app ]]; then
  rm -rf $INSTALL_DIR/Chromium.app || die "Unable to delete previous installed version of Chromium"
fi

# Installing new version
mv -f $TMP/chromium-$LATEST_VERSION/chrome-mac/Chromium.app $INSTALL_DIR || die "Unable to install fetched Chromium version"
echo "Chromium build $LATEST_VERSION succesfully installed"

# Cleaning
rm $TMP/chromium-$LATEST_VERSION.zip

# Open Chromium
open $INSTALL_DIR/Chromium.app
