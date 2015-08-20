#!/bin/bash
function contains() {
    local n=$#
    local value=${!n}
    for ((i=1;i < $#;i++)) {
        if [ "${!i}" == "${value}" ]; then
            echo "y"
            return 0
        fi
    }
    echo "n"
    return 1
}
BASE_DIR=`pwd`
SRC_DIR=$BASE_DIR/src
BUILD_DIR=$BASE_DIR/build
TEMP_DIR=$BASE_DIR/tmp
PATTERN=*.svg
#Find available modules
for var in $(find $SRC_DIR -maxdepth 1 -mindepth 1 -type d -name '[!.]*' | rev | cut -d/ -f1 | rev)
do
    AVAILABLE_MODULES+="$var "
done

#Checking command line arguments
if [ $# -eq 0 ]; then
    MODULES=$AVAILABLE_MODULES
else
    if [ "$1" == "-h" ]; then
        echo "Usage:
    `basename $0` [list of modules to include separeted by space]
    Running script with no arguments will include all available modules.
Available Modules:
    $AVAILABLE_MODULES
Example:
    `basename $0` images ui
    will create font with images and ui modules compiled in."
        exit 0
    fi
    MODULES="$@"
    for var in $MODULES
    do
        if [[ ! $AVAILABLE_MODULES =~ "$var" ]]; then
            echo "Error:
    \"$var\" is not a valid module name.
    run `basename $0` -h to see usage details."
            exit 1
        fi
    done
fi

#If the temp dir exists - delete it
if [  -d "$TEMP_DIR" ]; then
    rm $TEMP_DIR -R
fi
#create temporarty directory
mkdir $TEMP_DIR

#Copying SVG files to TEMP
for MODULE in $MODULES
do
    cp $SRC_DIR/$MODULE/$PATTERN $TEMP_DIR
done
cp $SRC_DIR/icons.js $TEMP_DIR

#If the build dir exists - delete it
if [  -d "$BUILD_DIR" ]; then
    rm $BUILD_DIR -R
fi
#create build directory
mkdir $BUILD_DIR
#Compile SVG files into a custom font
fontcustom.ruby2.1 compile -c $BASE_DIR/icons.yml
mv $BUILD_DIR/icons.ttf $BUILD_DIR/icons_raw.ttf
ttfautohint -v -D none -s -l 4 -G 0 -f hebr $BUILD_DIR/icons_raw.ttf $BUILD_DIR/icons.ttf
#Remove TEMP directory
rm $TEMP_DIR -R
exit 0