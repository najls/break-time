<#
.SYNOPSIS
    Prompts the user to take regular breaks.
.DESCRIPTION
    Prompts the user to take regular breaks based on the provided interval in
    minutes. Each prompt displays a randomly selected clever and funny message!
.PARAMETER Interval
    The time between each break in minutes.
.NOTES
    Author: najls
    Date:   March 7, 2021
#>

Param (
    [Parameter(
        Mandatory = $false,
        HelpMessage= 'The time between each break in minutes'
    )]
    [int]$Interval = 30
)

$messages = @(
    'Stand up for a while.',
    'Stretch or something.',
    'Drink water.',
    'Maybe you need to pee?',
    "Hey, don't sit so much or whatever.",
    "Do $(Get-Random -Minimum 5 -Maximum 20) push-ups!",
    "It's been $Interval minutes now."
)

$startTime = Get-Date
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null

Write-Host "Break Time script is running and will display a prompt every $Interval minutes. Enjoy!"

while ($true) {
    Start-Sleep -Seconds 1
    if ($startTime.AddMinutes($Interval) -lt $(Get-Date)) {
        $startTime = Get-Date
        [System.Windows.Forms.MessageBox]::Show($($messages | Get-Random), 'Break Time', [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Exclamation) | Out-Null
    }
}
