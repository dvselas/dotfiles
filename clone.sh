#!/bin/sh

echo "Cloning repositories..."

SITES=$HOME/Development
PRIVATE=$SITES/private
GLOMEX=$SITES/glomex

# Private
if [ ! -d "$PRIVATE/HomeControl-" ] ; then
    git clone git@github.com:dvselas/HomeControl-.git $PRIVATE/HomeControl-
fi
if [ ! -d "$PRIVATE/VselasHomeScreensaver" ] ; then
    git clone git@github.com:dvselas/VselasHomeScreensaver.git $PRIVATE/VselasHomeScreensaver
fi
if [ ! -d "$PRIVATE/vselasQuickAccess" ] ; then    
    git clone git@github.com:dvselas/vselasQuickAccess.git $PRIVATE/vselasQuickAccess
fi
if [ ! -d "$PRIVATE/dock.sh" ] ; then
    git clone git@gist.github.com:7634870a5abbbe62a31c36d7bee282e6.git $PRIVATE/dock.sh
fi

# glomex

