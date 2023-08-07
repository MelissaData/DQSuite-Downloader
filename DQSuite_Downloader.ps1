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

    Invoke-Expression "$program_path manifest -p `"$ProductName`" -r `"$release_version`" -l `"$license`" -t `"$path`" " 
}



#################### Main ####################

###################
# Section 1: Data #
###################

# Address Object Data
$target_path = "Data\AddressObject"
Get-Manifest -ProductName "dq_addr_data" -TargetDirectory $target_path

# Email Object Data
$target_path = "Data\EmailObject"
Get-Manifest -ProductName "dq_email_data" -TargetDirectory $target_path

# Name Object Data
$target_path = "Data\NameObject"
Get-Manifest -ProductName "dq_name_data" -TargetDirectory $target_path

# Phone Object Data
$target_path = "Data\PhoneObject"
Get-Manifest -ProductName "dq_phone_data" -TargetDirectory $target_path


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
$target_path = "Wrappers\AddressObject"
Get-Manifest -ProductName "dq_addr_wrappers" -TargetDirectory $target_path

# Email Object Wrappers
$target_path = "Wrappers\EmailObject"
Get-Manifest -ProductName "dq_email_wrappers" -TargetDirectory $target_path

# Name Object Wrappers
$target_path = "Wrappers\NameObject"
Get-Manifest -ProductName "dq_name_wrappers" -TargetDirectory $target_path

# Phone Object Wrappers
$target_path = "Wrappers\PhoneObject"
Get-Manifest -ProductName "dq_phone_wrappers" -TargetDirectory $target_path
