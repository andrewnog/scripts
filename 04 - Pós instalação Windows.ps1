﻿### Alterar política de execução
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope LocalMachine

### Desativar UAC
Set-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name EnableLUA -Value 0

### Instalar aplicações
winget install Google.Chrome 
winget install Google.ChromeRemoteDesktop 
winget install RARLab.WinRAR 
winget install AnyDeskSoftwareGmbH.AnyDesk 
winget install AcroSoftware.CutePDFWriter 
winget install Oracle.JavaRuntimeEnvironment 
winget install Adobe.Acrobat.Reader.64-bit
winget install Famatech.AdvancedIPScanner
