@echo off
powershell Write-Host "新しいオープンソースのpowershell(>=7)が必要です。"
pwsh if(where wsl){Write-Host "found 'wsl'" && Write-Host "お使いのwslで動作可能です。"}Else{Write-Host "not found 'wsl'"}
