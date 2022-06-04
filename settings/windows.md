# Windows

## Developer tools with winget

Since 2021 Windows 10/11 we can use [winget](https://github.com/microsoft/winget-cli/releases) instead chocolatey.
If you do not want to login to the microsoft store, you will need to use version 1.3 or higher

``` powershell
winget install Google.Chrome
winget install 7zip.7zip
winget install Notepad++.Notepad++
winget install Git.Git
winget install Python.Python.3
winget install WinMerge.WinMerge
winget install LLVM.LLVM
winget install cmake
winget install Microsoft.WindowsTerminal
winget install Microsoft.VisualStudioCode
winget install Microsoft.VisualStudio.2022.Community
```

## Developer tools with Chocolatey

Install Chocolatey

``` bash
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

Install a set of developer tools

``` bash
choco install googlechrome
choco install 7zip
choco install notepadplusplus
choco install microsoft-windows-terminal
choco install git
choco install python --version=3.7
choco install llvm --version=10
choco install winmerge
choco install vscode
choco install visualstudio2019community
```

## Enable WSL

[Enable WSL configuration](https://docs.microsoft.com/es-es/windows/wsl/install)

``` powershell
wsl --install
```

## Install Meslo Fonts

``` powershell
mkdir Meslo
cd Meslo
wsl wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
"C:\Program Files\7-Zip\7z.exe" x Meslo.zip
powershell $fonts = (New-Object -ComObject Shell.Application).Namespace(0x14); Get-ChildItem -Recurse -include *.ttf | % { $fonts.CopyHere($_.fullname) }
```

## Install [oh-my-posh](https://ohmyposh.dev/)

``` powershell
winget install oh-my-posh
powershell Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
powershell oh-my-posh init pwsh --config ~/.jandedobbeleer.omp.json | Invoke-Expression
powershell Write-Output "oh-my-posh init pwsh | Invoke-Expression" >> $PROFILE
```

## Enable ssh configuration

[Enable ssh configuration](https://docs.microsoft.com/es-es/windows-server/administration/openssh/openssh_install_firstuse).

``` powershell
# Install the OpenSSH Client
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0

# Install the OpenSSH Server
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

# Start the sshd service
Start-Service sshd

# OPTIONAL but recommended:
Set-Service -Name sshd -StartupType 'Automatic'

# Confirm the Firewall rule is configured. It should be created automatically by setup. Run the following to verify
if (!(Get-NetFirewallRule -Name "OpenSSH-Server-In-TCP" -ErrorAction SilentlyContinue | Select-Object Name, Enabled)) {
    Write-Output "Firewall Rule 'OpenSSH-Server-In-TCP' does not exist, creating it..."
    New-NetFirewallRule -Name 'OpenSSH-Server-In-TCP' -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
} else {
    Write-Output "Firewall rule 'OpenSSH-Server-In-TCP' has been created and exists."
}

# Start the sshd service
Start-Service ssh-agent;

# OPTIONAL but recommended:
Set-Service -Name ssh-agent -StartupType 'Automatic'


```
