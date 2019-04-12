#!/bin/bash

VersionString=`grep -E 's.version.*=' TestModulizedACategory.podspec`
VersionNumber=`tr -cd 0-9 <<<"$VersionString"`

NewVersionNumber=$(($VersionNumber + 1))
LineNumber=`grep -nE 's.version.*=' TestModulizedACategory.podspec | cut -d : -f1`
sed -i "" "${LineNumber}s/${VersionNumber}/${NewVersionNumber}/g" TestModulizedACategory.podspec

echo "current version is ${VersionNumber}, new version is ${NewVersionNumber}"

git add .
git commit -am ${NewVersionNumber}
git tag ${NewVersionNumber}
git push origin master --tags
pod repo push TestPrivatePod TestModulizedACategory.podspec --verbose --allow-warnings --use-libraries --use-modular-headers

