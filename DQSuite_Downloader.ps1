############### Data Quality Suite ####################

#################### Set Variables ####################

# License string
$license            = "your_license"

# Release version
$release_version    = "latest"  

# Target directory - where you want to download files to; The default is current directory.
$target_directory   = Get-Location

# Program directory - where you put MelissaUpdater.exe; The default is current directory.
# Melissa Updater source code: https://github.com/MelissaData/MelissaUpdater
# Melissa Updater binary download link: https://releases.melissadata.net/Download/Library/WINDOWS/NET/ANY/latest/MelissaUpdater.exe
$program_directory  = "$target_directory\MelissaUpdater" 
$program_path       = "$program_directory\MelissaUpdater.exe" 



#################### Functions ####################
 
function Get-File {
    param (
      [parameter(Mandatory=$true)][String]$Filename,
      [parameter(Mandatory=$false)][String]$Type,
      [parameter(Mandatory=$true)][String]$OperatingSystem,
      [parameter(Mandatory=$true)][String]$Compiler,
      [parameter(Mandatory=$true)][String]$Architecture,
      [parameter(Mandatory=$true)][String]$TargetDirectory,
      [parameter(Mandatory=$false)][String]$WorkingDirectory
    )
       
    $path = "$target_directory\$TargetDirectory" 
    
    $verifyPath = "$target_directory\$TargetDirectory\$Filename"
    $params = "verify", "-p", "$verifyPath"
    & $program_path $params
    
    if($? -eq $False) {
      Invoke-Expression "$program_path file -f -n `"$Filename`" -r `"$release_version`" -l `"$license`" -y `"$Type`" -o `"$OperatingSystem`" -c `"$Compiler`" -a `"$Architecture`" -t `"$path`" " 
    } else {
      Invoke-Expression "$program_path file -n `"$Filename`" -r `"$release_version`" -l `"$license`" -y `"$Type`" -o `"$OperatingSystem`" -c `"$Compiler`" -a `"$Architecture`" -t `"$path`" " 
    }
}
  

function Get-Manifest {
    param (
      [parameter(Mandatory=$true)][String]$ProductName,
      [parameter(Mandatory=$true)][String]$TargetDirectory,
      [parameter(Mandatory=$false)][String]$WorkingDirectory
    )
       
    $path = "$target_directory\$TargetDirectory" 
    $verifyPath = "$target_directory\$TargetDirectory"
    $params = "verify", "-p", "$verifyPath"
    & $program_path $params
    
    if($? -eq $False) {
      Invoke-Expression "$program_path manifest -f -p `"$ProductName`" -r `"$release_version`" -l `"$license`" -t `"$path`" " 
    } else {
      Invoke-Expression "$program_path manifest -p `"$ProductName`" -r `"$release_version`" -l `"$license`" -t `"$path`" " 
    }
}



#################### Main ####################

###################
# Section 1: Data #
###################

# Address Object Data
$target_path = "Data\AddressObject"
Get-Manifest -ProductName "DQ_ADDR_DATA" -TargetDirectory $target_path

# Email Object Data
$target_path = "Data\EmailObject"
Get-Manifest -ProductName "DQ_EMAIL_DATA" -TargetDirectory $target_path

# Name Object Data
$target_path = "Data\NameObject"
Get-Manifest -ProductName "DQ_NAME_DATA" -TargetDirectory $target_path

# Phone Object Data
$target_path = "Data\PhoneObject"
Get-Manifest -ProductName "DQ_PHONE_DATA" -TargetDirectory $target_path


######################
# Section 2: Objects #
######################

# Address Object 
$target_path = "Objects\AddressObject"
Get-File -Filename "mdAddr.dll" -Type "BINARY" -OperatingSystem "WINDOWS" -Compiler "DLL" -Architecture "64BIT" -TargetDirectory $target_path

# Email Object
$target_path = "Objects\EmailObject"
Get-File -Filename "mdEmail.dll" -Type "BINARY" -OperatingSystem "WINDOWS" -Compiler "DLL" -Architecture "64BIT" -TargetDirectory $target_path

# Name Object
$target_path = "Objects\NameObject"
Get-File -Filename "mdName.dll" -Type "BINARY" -OperatingSystem "WINDOWS" -Compiler "DLL" -Architecture "64BIT" -TargetDirectory $target_path

# Phone Object
$target_path = "Objects\PhoneObject"
Get-File -Filename "mdPhone.dll" -Type "BINARY" -OperatingSystem "WINDOWS" -Compiler "DLL" -Architecture "64BIT" -TargetDirectory $target_path


#######################
# Section 3: Wrappers #
#######################

# Address Object Wrappers
$target_path = "Wrappers\AddressObject\dotnet"
Get-File -Filename "mdAddr_cSharpCode.cs" -Type "INTERFACE" -OperatingSystem "ANY" -Compiler "NET" -Architecture "ANY" -TargetDirectory $target_path

$target_path = "Wrappers\AddressObject\python3"
Get-File -Filename "mdAddr_pythoncode.py" -Type "INTERFACE" -OperatingSystem "ANY" -Compiler "PYTHON" -Architecture "ANY" -TargetDirectory $target_path

$target_path = "Wrappers\AddressObject\java"
Get-File -Filename "mdAddr_JavaCode.zip" -Type "DATA" -OperatingSystem "ANY" -Compiler "ANY" -Architecture "ANY" -TargetDirectory $target_path
Get-File -Filename "mdAddrJavaWrapper.cpp" -Type "INTERFACE" -OperatingSystem "ANY" -Compiler "JAVA" -Architecture "ANY" -TargetDirectory $target_path
Get-File -Filename "mdAddrJavaWrapper.dll" -Type "INTERFACE" -OperatingSystem "WINDOWS" -Compiler "JAVA" -Architecture "64BIT" -TargetDirectory $target_path

$target_path = "Wrappers\AddressObject\cpp"
Get-File -Filename "mdEnums.h" -Type "INTERFACE" -OperatingSystem "ANY" -Compiler "C" -Architecture "ANY" -TargetDirectory $target_path
Get-File -Filename "mdAddr.h" -Type "INTERFACE" -OperatingSystem "ANY" -Compiler "C" -Architecture "ANY" -TargetDirectory $target_path
Get-File -Filename "mdAddr.lib" -Type "INTERFACE" -OperatingSystem "WINDOWS" -Compiler "C" -Architecture "64BIT" -TargetDirectory $target_path

$target_path = "Wrappers\AddressObject\php"
Get-File -Filename "mdAddr_phpCode.cpp" -Type "INTERFACE" -OperatingSystem "ANY" -Compiler "PHP" -Architecture "ANY" -TargetDirectory $target_path
Get-File -Filename "mdAddr_phpCode.php" -Type "INTERFACE" -OperatingSystem "ANY" -Compiler "PHP" -Architecture "ANY" -TargetDirectory $target_path


# Email Object Wrappers
$target_path = "Wrappers\EmailObject\dotnet"
Get-File -Filename "mdEmail_cSharpCode.cs" -Type "INTERFACE" -OperatingSystem "ANY" -Compiler "NET" -Architecture "ANY" -TargetDirectory $target_path

$target_path = "Wrappers\EmailObject\python3"
Get-File -Filename "mdEmail_pythoncode.py" -Type "INTERFACE" -OperatingSystem "ANY" -Compiler "PYTHON" -Architecture "ANY" -TargetDirectory $target_path

$target_path = "Wrappers\EmailObject\java"
Get-File -Filename "mdEmail_JavaCode.zip" -Type "DATA" -OperatingSystem "ANY" -Compiler "ANY" -Architecture "ANY" -TargetDirectory $target_path
Get-File -Filename "mdEmailJavaWrapper.cpp" -Type "INTERFACE" -OperatingSystem "ANY" -Compiler "JAVA" -Architecture "ANY" -TargetDirectory $target_path
Get-File -Filename "mdEmailJavaWrapper.dll" -Type "INTERFACE" -OperatingSystem "WINDOWS" -Compiler "JAVA" -Architecture "64BIT" -TargetDirectory $target_path

$target_path = "Wrappers\EmailObject\cpp"
Get-File -Filename "mdEnums.h" -Type "INTERFACE" -OperatingSystem "ANY" -Compiler "C" -Architecture "ANY" -TargetDirectory $target_path
Get-File -Filename "mdEmail.h" -Type "INTERFACE" -OperatingSystem "ANY" -Compiler "C" -Architecture "ANY" -TargetDirectory $target_path
Get-File -Filename "mdEmail.lib" -Type "INTERFACE" -OperatingSystem "WINDOWS" -Compiler "C" -Architecture "64BIT" -TargetDirectory $target_path

$target_path = "Wrappers\EmailObject\php"
Get-File -Filename "mdEmail_phpCode.cpp" -Type "INTERFACE" -OperatingSystem "ANY" -Compiler "PHP" -Architecture "ANY" -TargetDirectory $target_path
Get-File -Filename "mdEmail_phpcode.php" -Type "INTERFACE" -OperatingSystem "ANY" -Compiler "PHP" -Architecture "ANY" -TargetDirectory $target_path


# Name Object Wrappers
$target_path = "Wrappers\NameObject\dotnet"
Get-File -Filename "mdName_cSharpCode.cs" -Type "INTERFACE" -OperatingSystem "ANY" -Compiler "NET" -Architecture "ANY" -TargetDirectory $target_path

$target_path = "Wrappers\NameObject\python3"
Get-File -Filename "mdName_pythoncode.py" -Type "INTERFACE" -OperatingSystem "ANY" -Compiler "PYTHON" -Architecture "ANY" -TargetDirectory $target_path

$target_path = "Wrappers\NameObject\java"
Get-File -Filename "mdName_JavaCode.zip" -Type "DATA" -OperatingSystem "ANY" -Compiler "ANY" -Architecture "ANY" -TargetDirectory $target_path
Get-File -Filename "mdNameJavaWrapper.cpp" -Type "INTERFACE" -OperatingSystem "ANY" -Compiler "JAVA" -Architecture "ANY" -TargetDirectory $target_path
Get-File -Filename "mdNameJavaWrapper.dll" -Type "INTERFACE" -OperatingSystem "WINDOWS" -Compiler "JAVA" -Architecture "64BIT" -TargetDirectory $target_path

$target_path = "Wrappers\NameObject\cpp"
Get-File -Filename "mdNameEnums.h" -Type "INTERFACE" -OperatingSystem "ANY" -Compiler "C" -Architecture "ANY" -TargetDirectory $target_path
Get-File -Filename "mdName.h" -Type "INTERFACE" -OperatingSystem "ANY" -Compiler "C" -Architecture "ANY" -TargetDirectory $target_path
Get-File -Filename "mdName.lib" -Type "INTERFACE" -OperatingSystem "WINDOWS" -Compiler "C" -Architecture "64BIT" -TargetDirectory $target_path

$target_path = "Wrappers\NameObject\php"
Get-File -Filename "mdName_phpCode.cpp" -Type "INTERFACE" -OperatingSystem "ANY" -Compiler "PHP" -Architecture "ANY" -TargetDirectory $target_path
Get-File -Filename "mdName_phpcode.php" -Type "INTERFACE" -OperatingSystem "ANY" -Compiler "PHP" -Architecture "ANY" -TargetDirectory $target_path


# Phone Object Wrappers
$target_path = "Wrappers\PhoneObject\dotnet"
Get-File -Filename "mdPhone_cSharpCode.cs" -Type "INTERFACE" -OperatingSystem "ANY" -Compiler "NET" -Architecture "ANY" -TargetDirectory $target_path

$target_path = "Wrappers\PhoneObject\python3"
Get-File -Filename "mdPhone_pythoncode.py" -Type "INTERFACE" -OperatingSystem "ANY" -Compiler "PYTHON" -Architecture "ANY" -TargetDirectory $target_path

$target_path = "Wrappers\PhoneObject\java"
Get-File -Filename "mdPhone_JavaCode.zip" -Type "DATA" -OperatingSystem "ANY" -Compiler "ANY" -Architecture "ANY" -TargetDirectory $target_path
Get-File -Filename "mdPhoneJavaWrapper.cpp" -Type "INTERFACE" -OperatingSystem "ANY" -Compiler "JAVA" -Architecture "ANY" -TargetDirectory $target_path
Get-File -Filename "mdPhoneJavaWrapper.dll" -Type "INTERFACE" -OperatingSystem "WINDOWS" -Compiler "JAVA" -Architecture "64BIT" -TargetDirectory $target_path

$target_path = "Wrappers\PhoneObject\cpp"
Get-File -Filename "mdEnums.h" -Type "INTERFACE" -OperatingSystem "ANY" -Compiler "C" -Architecture "ANY" -TargetDirectory $target_path
Get-File -Filename "mdPhone.h" -Type "INTERFACE" -OperatingSystem "ANY" -Compiler "C" -Architecture "ANY" -TargetDirectory $target_path
Get-File -Filename "mdPhone.lib" -Type "INTERFACE" -OperatingSystem "WINDOWS" -Compiler "C" -Architecture "64BIT" -TargetDirectory $target_path

$target_path = "Wrappers\PhoneObject\php"
Get-File -Filename "mdPhone_phpCode.cpp" -Type "INTERFACE" -OperatingSystem "ANY" -Compiler "PHP" -Architecture "ANY" -TargetDirectory $target_path
Get-File -Filename "mdPhone_phpcode.php" -Type "INTERFACE" -OperatingSystem "ANY" -Compiler "PHP" -Architecture "ANY" -TargetDirectory $target_path
