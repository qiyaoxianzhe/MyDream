#!/usr/bin/env bash

source ~/.bash_profile
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
APP_ROOT="$DIR"
APP_ANDROID_ROOT="$DIR"
COCOS2DX_ROOT=$COCOS_X_ROOT

echo "- config:"
echo "  ANDROID_NDK_ROOT    = $ANDROID_NDK_ROOT"
echo "  COCOS2DX_ROOT 		= $COCOS2DX_ROOT"
echo "  COCOS2DX_ROOT       = $COCOS2DX_ROOT"
echo "  APP_ROOT            = $APP_ROOT"
echo "  APP_ANDROID_ROOT    = $APP_ANDROID_ROOT"

echo "- copy scr"
cp -rf "$APP_ROOT"/src "$APP_ROOT"/runtime/mac/DoraemonClient\ Mac.app/Contents/Resources
echo "- copy resources"
cp -rf "$APP_ROOT"/res "$APP_ROOT"/runtime/mac/DoraemonClient\ Mac.app/Contents/Resources
pkill DoraemonClient Mac
open $APP_ROOT/runtime/mac/DoraemonClient\ Mac.app 