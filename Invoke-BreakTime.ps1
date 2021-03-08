<#
.SYNOPSIS
    Prompts the user to take regular breaks.
.DESCRIPTION
    Prompts the user to take regular breaks based on the provided interval in
    minutes. Each prompt displays a randomly selected clever and funny message!
.PARAMETER Interval
    The time between each break in minutes.
.PARAMETER NotificationSound
    Windows alarm sound selection.
.NOTES
    Author: najls
    Date:   March 7, 2021
#>

Param (
    [Parameter(Mandatory = $true)]
    [int]$Interval = 30,

    [Parameter(Mandatory = $false)]
    [ValidateRange(0, 10)]
    [int]$AlarmSound = 1
)

begin {
    [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null

    $scriptTitle = 'Break Time'
    $messages = @(
        'Stand up for a while.',
        'Stretch or something.',
        'Drink water.',
        'Maybe you need to pee?',
        "Hey, don't sit so much or whatever.",
        "Do $(Get-Random -Minimum 5 -Maximum 20) push-ups!",
        "It's been $Interval minutes now."
    )

    $notifier = [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($scriptTitle)
    $startTime = Get-Date

    Write-Host "Break Time script is running and will display a prompt every $Interval minutes. Enjoy!"
}

process {
    while ($true) {
        Start-Sleep -Seconds 1

        if ($startTime.AddMinutes($Interval) -lt $(Get-Date)) {
            $startTime = Get-Date

            $toastTemplate = @"
<toast duration="short">
    <visual>
    <binding template="ToastText02">
        <text id="1">$scriptTitle</text>
        <text id="2">$($messages | Get-Random)</text>
    </binding>
    </visual>
    <audio src="ms-winsoundevent:Notification.Looping.Alarm$AlarmSound" />
</toast>
"@

            $serializedXml = New-Object Windows.Data.Xml.Dom.XmlDocument
            $serializedXml.LoadXml($toastTemplate)

            $toast = [Windows.UI.Notifications.ToastNotification]::new($serializedXml)
            $notifier.Show($toast);
        }
    }
}
