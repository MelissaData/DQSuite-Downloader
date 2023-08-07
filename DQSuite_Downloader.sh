#!/bin/bash
############### Data Quality Suite ####################

#################### Set Variables ####################

# License string
license="your_license"

# Release version
release_version="latest"  

# Target directory - where you want to download files to; The default is current directory.
target_directory=$(pwd)

# Program directory - where you put MelissaUpdater; The default is current directory.
# Melissa Updater source code: https://github.com/MelissaData/MelissaUpdater
# Melissa Updater binary download link: https://releases.melissadata.net/Download/Library/LINUX/NET/ANY/latest/MelissaUpdater
program_directory="$target_directory/MelissaUpdater"
program_path="$program_directory/MelissaUpdater"


#################### Functions ####################
 
Get-File() 
{
    path="$target_directory/$6" 
    
    verifyPath="$target_directory/$6/$1"
    $program_path verify --path $verifyPath
    
    if [ $? -eq 0 ];
    then
        eval "$program_path file --filename $1 --release_version $release_version --license $license --type $2 --os $3 --compiler $4 --architecture $5 --target_directory $path "
    else
        eval "$program_path file --force --filename $1 --release_version $release_version --license $license --type $2 --os $3 --compiler $4 --architecture $5 --target_directory $path "
    fi
}

Get-Manifest() 
{
    path="$target_directory/$2"
    
    eval "$program_path manifest --product $1 --release_version $release_version --license $license --target_directory $path "
}

#################### Main ####################

###################
# Section 1: Data #
###################

# Address Object Data
target_path="Data/AddressObject"
Get-Manifest "dq_addr_data" $target_path

# Email Object Data
target_path="Data/EmailObject"
Get-Manifest "dq_email_data" $target_path

# Name Object Data
target_path="Data/NameObject"
Get-Manifest "dq_name_data" $target_path

# Phone Object Data
target_path="Data/PhoneObject"
Get-Manifest "dq_phone_data" $target_path


######################
# Section 2: Objects #
######################

# Address Object 
target_path="Objects/AddressObject"
Get-File "libmdAddr.so" "BINARY" "LINUX" "GCC48" "64BIT" $target_path

# Email Object
target_path="Objects/EmailObject"
Get-File "libmdEmail.so" "BINARY" "LINUX" "GCC48" "64BIT" $target_path

# Name Object
target_path="Objects/NameObject"
Get-File "libmdName.so" "BINARY" "LINUX" "GCC48" "64BIT" $target_path

# Phone Object
target_path="Objects/PhoneObject"
Get-File "libmdPhone.so" "BINARY" "LINUX" "GCC48" "64BIT" $target_path


#######################
# Section 3: Wrappers #
#######################

# Address Object Wrappers
target_path="Wrappers/AddressObject"
Get-Manifest "dq_addr_wrappers" $target_path

# Email Object Wrappers
target_path="Wrappers/EmailObject"
Get-Manifest "dq_email_wrappers" $target_path

# Name Object Wrappers
target_path="Wrappers/NameObject"
Get-Manifest "dq_name_wrappers" $target_path

# Phone Object Wrappers
target_path="Wrappers/PhoneObject"
Get-Manifest "dq_phone_wrappers" $target_path
