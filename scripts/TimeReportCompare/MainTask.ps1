$Time1 = Get-Date -format HH:mm:ss
PowerShell.exe -command "MultiThreadingScript.ps1"
$Time2 = Get-Date -format HH:mm:ss
$TimeDiff = New-TimeSpan $Time1 $Time2
if ($TimeDiff.Seconds -lt 0) {
	$Hrs = ($TimeDiff.Hours) + 23
	$Mins = ($TimeDiff.Minutes) + 59
	$Secs = ($TimeDiff.Seconds) + 59 }
else {
	$Hrs = $TimeDiff.Hours
	$Mins = $TimeDiff.Minutes
	$Secs = $TimeDiff.Seconds }
$Difference = '{0:00}:{1:00}:{2:00}' -f $Hrs,$Mins,$Secs
echo "Time for multi threading script execution is:"
$Difference1 = $Difference
$Difference1


$Time1 = Get-Date -format HH:mm:ss
PowerShell.exe -command "NonMultiThreadingTaskText.ps1"
$Time2 = Get-Date -format HH:mm:ss
$TimeDiff = New-TimeSpan $Time1 $Time2
if ($TimeDiff.Seconds -lt 0) {
	$Hrs = ($TimeDiff.Hours) + 23
	$Mins = ($TimeDiff.Minutes) + 59
	$Secs = ($TimeDiff.Seconds) + 59 }
else {
	$Hrs = $TimeDiff.Hours
	$Mins = $TimeDiff.Minutes
	$Secs = $TimeDiff.Seconds }
$Difference = '{0:00}:{1:00}:{2:00}' -f $Hrs,$Mins,$Secs
echo "Time for Non multi threading script execution is:"
$Difference2 = $Difference
$Difference2

echo "Time for multi threading script execution is:"
$Difference1