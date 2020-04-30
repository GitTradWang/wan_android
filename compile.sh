#!/bin/sh

basePath=$(cd $(dirname $0) && pwd)

cd $basePath

flutter clean

flutter pub get

#生城启动图标需要配合flutter_launcher_icons这个库使用
flutter pub run flutter_launcher_icons:main
