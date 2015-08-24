#!/usr/bin/env bash
source ~/.bash_profile
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
APP_ROOT="$DIR"

open -a Sublime\ Text\ 2 $APP_ROOT/runtime/mac/DoraemonClient\ Mac.app/Contents/Resources/debug.log