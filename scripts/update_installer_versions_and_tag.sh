#!/bin/bash
# run this script from the root of the checked out repo
# the build number must be passed in
build_number=$1

set -e
version_file="version"
major_version=$(grep "MAJOR_VERSION" $version_file | grep -o '[0-9]*')
minor_version=$(grep "MINOR_VERSION" $version_file | grep -o '[0-9]*')
feature_version=$(grep "FEATURE_VERSION" $version_file | grep -o '[0-9]*')

current_version="$major_version"."$minor_version"."$feature_version"

# installer versions
msi_1="./setup/DirectShowFilterPack/DirectShowFilterPack/DirectShowFilterPack.vdproj"
msi_version_1=$(grep "ProductVersion" $msi_1 | awk '{print substr($3, 4, length($3)-4)}')
echo "Installer versions: DS: $msi_version_1" 

new_version="$major_version"."$minor_version"."$build_number"
echo "Updated version: " $new_version

# replace in files
sed -i "s/FEATURE_VERSION = $feature_version/FEATURE_VERSION = $build_number/" $version_file 
sed -i "s/= \"8:$msi_version_1/= \"8:$new_version/" $msi_1
 
# replace product and package codes
old_product_code_1=$(grep "ProductCode\" = \"8:{" $msi_1  | sed 's/{/ /g' | sed 's/}/ /g' | awk '{print $4}')
new_product_code_1=$(uuidgen | tr [a-z] [A-Z])
echo "Updating product code for installer 1. Old: $old_product_code_1 Updated: $new_product_code_1"
sed -i "s/$old_product_code_1/$new_product_code_1/" $msi_1
old_package_code_1=$(grep "PackageCode\" = \"8:{" $msi_1 | sed 's/{/ /g' | sed 's/}/ /g' | awk '{print $4}')
new_package_code_1=$(uuidgen | tr [a-z] [A-Z])
echo "Updating package code for installer 1. Old: $old_package_code_1 Updated: $new_package_code_1"
sed -i "s/$old_package_code_1/$new_package_code_1/" $msi_1

# echo version number into file
echo $new_version > ./setup/version

exit 0
