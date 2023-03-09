#!/bin/bash

set -e

echo "Preparing Apple binaries..."

# ensure existence of release folder
if ! [ -d "./release" ]; then
    mkdir ./release
fi

# ensure zip is installed
if [ "$(which zip)" = "" ]; then
    apt-get update && apt-get install -y zip
fi

# handle apple binaries
echo "Unzipping..."
unzip ./build/WakaTime.zip

echo "Adding permissions..."
chmod -R 750 ./build/Contents/

echo "Creating ./WakaTime.app/Contents"
mkdir -p ./WakaTime.app/Contents

echo "Moving files..."
mv -v ./build/Contents/* ./WakaTime.app/Contents/

echo "Zipping..."
zip -r ./release/WakaTime.zip ./WakaTime.app

# calculate checksums
for file in  ./release/*; do
	checksum=$(sha256sum "${file}" | cut -d' ' -f1)
	filename=$(echo "${file}" | rev | cut -d/ -f1 | rev)
	echo "${checksum} ${filename}" >> ./release/checksums_sha256.txt
done
