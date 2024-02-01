### 1 - Substitua a variavel $exportPath colocando o caminho de destino do backup da VM
### 2 - Substitua no script onde está newserver para o nome da VM

# Definir caminho de exportação
$exportPath = "\\CAMINHO\ONDE\SERA\GUARDADO\OS\BACKUPS"  # Substitua pelo caminho da rede ou disco físico
# Obter a data e hora atual para uso no nome da pasta de backup
$backupDateTime = Get-Date -Format "yyyy-MM-dd_HHmmss"

# Exportar a VM para o caminho especificado
Write-Host "Exporting VM: newserver"
Export-VM -Name "newserver" -Path "$exportPath\newserver_$backupDateTime"
Write-Host "Export completed for VM: newserver"

# Obter a lista de todos os diretórios de backup
$backupDirectories = Get-ChildItem -Path $exportPath -Filter "newserver_*" -Directory | Sort-Object LastWriteTime -Descending

# Remover backups antigos além dos últimos 5
if ($backupDirectories.Count -gt 5) {
    $backupDirectoriesToDelete = $backupDirectories[5..($backupDirectories.Count - 1)]
    foreach ($directoryToDelete in $backupDirectoriesToDelete) {
        Write-Host "Deleting old backup: $($directoryToDelete.Name)"
        Remove-Item -Path $directoryToDelete.FullName -Recurse -Force
    }
}