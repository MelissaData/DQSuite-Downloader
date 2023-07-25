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
        eval "$program_path file --force --filename $1 --release_version $release_version --license $license --type $2 --os $3 --compiler $4 --architecture $5 --target_directory $path "
    else
        eval "$program_path file --filename $1 --release_version $release_version --license $license --type $2 --os $3 --compiler $4 --architecture $5 --target_directory $path "
    fi
}

Get-Manifest() 
{
    path="$target_directory/$2"
    
    verifyPath="$target_directory/$2"
    $program_path verify --path $verifyPath
    
    if [ $? -eq 0 ];
    then
      eval "$program_path manifest --force --product $1 --release_version $release_version --license $license --target_directory $path "
    else
      eval "$program_path manifest --product $1 --release_version $release_version --license $license --target_directory $path "
    fi
}

#################### Main ####################

###################
# Section 1: Data #
###################

# Address Object Data
target_path="Data/AddressObject"
Get-Manifest "DQ_ADDR_DATA" $target_path

# Email Object Data
target_path="Data/EmailObject"
Get-Manifest "DQ_EMAIL_DATA" $target_path

# Name Object Data
target_path="Data/NameObject"
Get-Manifest "DQ_NAME_DATA" $target_path

# Phone Object Data
target_path="Data/PhoneObject"
Get-Manifest "DQ_PHONE_DATA" $target_path


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
target_path="Wrappers/AddressObject/dotnet"
Get-File "mdAddr_cSharpCode.cs" "INTERFACE" "ANY" "NET" "ANY" $target_path

target_path="Wrappers/AddressObject/python3"
Get-File "mdAddr_pythoncode.py" "INTERFACE" "ANY" "PYTHON" "ANY" $target_path

target_path="Wrappers/AddressObject/java"
Get-File "mdAddr_JavaCode.zip" "DATA" "ANY" "ANY" "ANY" $target_path
Get-File "mdAddrJavaWrapper.cpp" "INTERFACE" "ANY" "JAVA" "ANY" $target_path
Get-File "libmdAddrJavaWrapper.so" "INTERFACE" "LINUX" "JAVA" "64BIT" $target_path

target_path="Wrappers/AddressObject/cpp"
Get-File "mdEnums.h" "INTERFACE" "ANY" "C" "ANY" $target_path
Get-File "mdAddr.h" "INTERFACE" "ANY" "C" "ANY" $target_path
Get-File "mdAddr.lib" "INTERFACE" "WINDOWS" "C" "64BIT" $target_path

target_path="Wrappers/AddressObject/php"
Get-File "mdAddr_phpCode.cpp" "INTERFACE" "ANY" "PHP" "ANY" $target_path
Get-File "mdAddr_phpCode.php" "INTERFACE" "ANY" "PHP" "ANY" $target_path


# Email Object Wrappers
target_path="Wrappers/EmailObject/dotnet"
Get-File "mdEmail_cSharpCode.cs" "INTERFACE" "ANY" "NET" "ANY" $target_path

target_path="Wrappers/EmailObject/python3"
Get-File "mdEmail_pythoncode.py" "INTERFACE" "ANY" "PYTHON" "ANY" $target_path

target_path="Wrappers/EmailObject/java"
Get-File "mdEmail_JavaCode.zip" "DATA" "ANY" "ANY" "ANY" $target_path
Get-File "mdEmailJavaWrapper.cpp" "INTERFACE" "ANY" "JAVA" "ANY" $target_path
Get-File "libmdEmailJavaWrapper.so" "INTERFACE" "LINUX" "JAVA" "64BIT" $target_path

target_path="Wrappers/EmailObject/cpp"
Get-File "mdEnums.h" "INTERFACE" "ANY" "C" "ANY" $target_path
Get-File "mdEmail.h" "INTERFACE" "ANY" "C" "ANY" $target_path
Get-File "mdEmail.lib" "INTERFACE" "WINDOWS" "C" "64BIT" $target_path

target_path="Wrappers/EmailObject/php"
Get-File "mdEmail_phpCode.cpp" "INTERFACE" "ANY" "PHP" "ANY" $target_path
Get-File "mdEmail_phpcode.php" "INTERFACE" "ANY" "PHP" "ANY" $target_path


# Name Object Wrappers
target_path="Wrappers/NameObject/dotnet"
Get-File "mdName_cSharpCode.cs" "INTERFACE" "ANY" "NET" "ANY" $target_path

target_path="Wrappers/NameObject/python3"
Get-File "mdName_pythoncode.py" "INTERFACE" "ANY" "PYTHON" "ANY" $target_path

target_path="Wrappers/NameObject/java"
Get-File "mdName_JavaCode.zip" "DATA" "ANY" "ANY" "ANY" $target_path
Get-File "mdNameJavaWrapper.cpp" "INTERFACE" "ANY" "JAVA" "ANY" $target_path
Get-File "libmdNameJavaWrapper.so" "INTERFACE" "LINUX" "JAVA" "64BIT" $target_path

target_path="Wrappers/NameObject/cpp"
Get-File "mdNameEnums.h" "INTERFACE" "ANY" "C" "ANY" $target_path
Get-File "mdName.h" "INTERFACE" "ANY" "C" "ANY" $target_path
Get-File "mdName.lib" "INTERFACE" "WINDOWS" "C" "64BIT" $target_path

target_path="Wrappers/NameObject/php"
Get-File "mdName_phpCode.cpp" "INTERFACE" "ANY" "PHP" "ANY" $target_path
Get-File "mdName_phpcode.php" "INTERFACE" "ANY" "PHP" "ANY" $target_path


# Phone Object Wrappers
target_path="Wrappers/PhoneObject/dotnet"
Get-File "mdPhone_cSharpCode.cs" "INTERFACE" "ANY" "NET" "ANY" $target_path

target_path="Wrappers/PhoneObject/python3"
Get-File "mdPhone_pythoncode.py" "INTERFACE" "ANY" "PYTHON" "ANY" $target_path

target_path="Wrappers/PhoneObject/java"
Get-File "mdPhone_JavaCode.zip" "DATA" "ANY" "ANY" "ANY" $target_path
Get-File "mdPhoneJavaWrapper.cpp" "INTERFACE" "ANY" "JAVA" "ANY" $target_path
Get-File "libmdPhoneJavaWrapper.so" "INTERFACE" "LINUX" "JAVA" "64BIT" $target_path

target_path="Wrappers/PhoneObject/cpp"
Get-File "mdEnums.h" "INTERFACE" "ANY" "C" "ANY" $target_path
Get-File "mdPhone.h" "INTERFACE" "ANY" "C" "ANY" $target_path
Get-File "mdPhone.lib" "INTERFACE" "WINDOWS" "C" "64BIT" $target_path

target_path="Wrappers/PhoneObject/php"
Get-File "mdPhone_phpCode.cpp" "INTERFACE" "ANY" "PHP" "ANY" $target_path
Get-File "mdPhone_phpcode.php" "INTERFACE" "ANY" "PHP" "ANY" $target_path
