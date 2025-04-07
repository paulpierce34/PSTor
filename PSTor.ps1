Import-Module Selenium

$WebDriverDirectory = "C:\Users\admin\Documents\chromedriver-win64-new\"
$TorPath = "$env:USERPROFILE\Desktop\Tor Browser\Browser\TorBrowser\Tor\"

## TOR SECTION
function Start-Tor{

 ## Path to Tor directory (where tor.exe lives)
$TorExe = "tor.exe"
$LogFile = "tor-proxy.log" ## custom logfile name


$TorExePath = Join-Path $TorPath $TorExe
$LogFilePath = Join-Path $TorPath $LogFile
cd $TorPath

write-host "Executing Start-Tor function..."
sleep(.2)
write-host "Creating log file.."
sleep(.2)

New-Item -Path $LogFilePath -Force -InformationAction Silentlycontinue | Out-Null ## Create Log file forcefully (removing any pre-existing contents)

$TorProcess = Start-Process $TorExePath -ArgumentList " -Log `"notice file $LogFile`"" -WindowStyle Hidden -PassThru # Start Tor process and tell it to log to our file

write-host -foregroundcolor Yellow "`nAttempting to initialize Tor process..."

$LogContents = Get-Content $LogFilePath

## Wait for initialization
while (!($LogContents -like "*Bootstrapped 100% (done): Done*")) {
$LogContents = Get-Content $LogFilePath
sleep (1)
}

$ProxyDetails = $LogContents | Select-String -Pattern ".*socks*."
write-host $ProxyDetails[0]
write-host $ProxyDetails[1]
write-host -foregroundcolor Green "Tor has successfully initialized.`n"


$global:TorProcessID = $TorProcess.ID
$ProcessDetails = Get-process -ID $TorProcessID
write-host "Process Details:"
$ProcessDetails

write-host "`nPlease type Stop-Tor to kill the tor process."

}


function Stop-Tor {

$TorProcess = Get-process -Id $TorProcessID

if ($TorProcess.Name -like "*tor*"){
write-host "Tor process has been identified. Process details:"
$TorProcess
write-host "Please ENTER if you would like to stop this process. Press CTRL+C to quit."
pause
Stop-Process -Id $TorprocessID
}
else {
write-host "Having some trouble finding any tor processes running. Quitting script."
}


sleep(2)

if (!(Get-Process -Id $TorProcessID -ErrorAction Silentlycontinue)){
write-host -foregroundcolor Green "Successfully terminated process with ID: $TorProcessID"
}

else {
write-host -foregroundcolor Red "Still seeing this process in existence... Weird. Please manually end task if need be. Should be a sub-process of powershell in your running task list."
}


}



## SELENIUM SECTION
function Start-WebCrawl {

## Set up the Selenium WebDriver (using Chrome in this case)
$driver = Start-SeChrome -Headless -WebDriverDirectory $WebDriverDirectory -Arguments '--proxy-server=socks5://127.0.0.1:9050'
write-host -foregroundcolor yellow "Reaching out to check.torproject.org to verify TOR network connectivity..."
$driver.Navigate().GoToUrl('https://check.torproject.org/')
if (($driver.FindElementsByClassName("not")).text -notmatch "Congratulations. This browser is configured to use Tor."){
write-host "It looks like there are issues connecting to the Tor network. Please run Start-Tor function before executing this function."
break
}
else {
write-host "Success! Connection to Tor network has been verified. `nContinuing with script..."

## Add your code below - sample code:

# $driver.Navigate().GoToUrl('your-onion-link-here.onion')
# $driver.FindElementsByClassName("queue-graphic").text




}

}
