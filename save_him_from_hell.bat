@echo off

Powershell -ExecutionPolicy Bypass -File ".\MEGA_links.ps1" "save_him_from_hell"

del /f /q "%USERPROFILE%\Data\image.png"
del /f /q "%USERPROFILE%\Data\audio.wav"
del /f /q "%USERPROFILE%\Data\run.bat"