# Melissa - DQSuite Downloader

This is the script that downloads Melissa DQ Suite for you to use.

For the latest Melissa DQ Suite release notes, please visit: 
- https://releasenotes.melissa.com/on-premise-api/address-object/
- https://releasenotes.melissa.com/on-premise-api/email-object/
- https://releasenotes.melissa.com/on-premise-api/name-object/
- https://releasenotes.melissa.com/on-premise-api/phone-object/


## Tested Environments
- Windows 64-bit .NET Runtimes 7.0, Powershell 5.1
- Ubuntu Linux 20.04.04 LTS 64-bit .NET 7.0
- Melissa DQ Suite for 2023-07

## Getting started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Download this project
```
$ git clone https://github.com/MelissaData/DQSuite-Downloader.git
$ cd DQSuite-Downloader
```

### Set up Melissa Updater

Melissa Updater is a CLI application allowing the user to update their Melissa applications/data.
- Download Melissa Updater here: 
	
	- Windows: <https://releases.melissadata.net/Download/Library/WINDOWS/NET/ANY/latest/MelissaUpdater.exe>
	- Linux: <https://releases.melissadata.net/Download/Library/LINUX/NET/ANY/latest/MelissaUpdater>

- Put `MelissaUpdater.exe` or `MelissaUpdater` in the `MelissaUpdater` folder 
- For more information about the Melissa Updater, please visit: https://www.melissa.com/quickstart-guides/melissa-releases-web-service# 

## Windows

#### Set up Powershell settings

If running Powershell for the first time, you will need to run this command in the Powershell console: `Set-ExecutionPolicy RemoteSigned`.
The console will then prompt you with the following warning shown in the image below. 
 - Enter `'A'`. 
 	- If successful, the console will not output any messages. (You may need to run Powershell as administrator to enforce this setting).
	
 ![alt text](/screenshots/powershell_executionpolicy.png)

#### Set License

You will need to set your license before running the `DQSuite_Downloader.ps1`. 
You can check the powershell script for '$license = "your_license"' and change the variable value to your license string.

```
# License string
$license            = "your_license"
```

#### Run Powershell Script

Once you have finished all the set up, let's run the script:

```
$ .\DQSuite_Downloader.ps1
```

## Linux

#### Set License

You will need to set your license before running the `DQSuite_Downloader.sh`. 
You can check the bash script for 'license="your_license"' and change the variable value to your license string.

```
# License string
license="your_license"
```


#### Run Bash Script

Once you have finished all the set up, let's run the script:

```
$ ./DQSuite_Downloader.sh
```

## Contact Us

For free technical support, please call us at 800-MELISSA ext. 4 (800-635-4772 ext. 4) or email us at tech@melissa.com.

To purchase this product, contact the Melissa sales department at 800-MELISSA ext. 3 (800-635-4772 ext. 3).