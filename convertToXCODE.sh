#!/bin/bash
mkdir xcode
cd xcode
/Users/eugenetrounev/QtCommertial/5.5/ios/bin/qmake ../$1 -r -spec macx-ios-clang CONFIG+=release CONFIG+=iphoneos