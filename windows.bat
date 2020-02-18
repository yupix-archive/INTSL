@echo off
powershell Write-Host "新しいオープンソースのpowershell'('>=7')'が必要です。しかし、=7はプレビュー版のため、=6で動くように機能制限中"
rem pwsh -Command { if(where.exe wsl){Write-Host "found 'wsl'" && Write-Host "お使いのwslで動作可能です。"}Else{Write-Host "not found 'wsl'"} }
pwsh -Command if(where.exe wsl){Write-Host "found 'wsl'"}Else{Write-Host "not found 'wsl'"}
