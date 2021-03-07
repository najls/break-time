Param (
    [Parameter (
        Mandatory = $false,
        HelpMessage="Break interval in minutes"
    )]
    [int]$Interval = 30
)

$messages = @(
    'Stand up for a while.',
    'Stretch or something.',
    'Pushups!',
    'Drink water!',
    'Maybe you need to pee?',
    'Hey, guy!'
)

$startTime = Get-Date
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null

while ($true) {
    Start-Sleep -Seconds 1
    if ($startTime.AddMinutes($Interval) -lt $(Get-Date)) {
        $startTime = Get-Date
        [System.Windows.Forms.MessageBox]::Show($($messages | Get-Random),"Break Time",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Exclamation)
    }
}
