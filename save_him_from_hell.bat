@echo off

Powershell -ExecutionPolicy Bypass -File ".\MEGA_links.ps1" "save_him_from_hell"

del /f /q "C:\Users\%USERNAME%\Data\image.png"
del /f /q "C:\Users\%USERNAME%\Data\audio.wav"
del /f /q "C:\Users\%USERNAME%\Data\run.bat"