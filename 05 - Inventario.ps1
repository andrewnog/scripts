### Script para gerar informações sobre hardware e software do terminal Windows

$OutputFile = "C:\inventario.txt"

### Obter Fabricante
wmic COMPUTERSYSTEM get Manufacturer | Out-File -FilePath $OutputFile -Encoding UTF8
### Obter Modelo
wmic COMPUTERSYSTEM get Model | Out-File -FilePath $OutputFile -Encoding UTF8 -Append
### Obter Processador
wmic CPU get Name | Out-File -FilePath $OutputFile -Encoding UTF8 -Append
### Obter Memória RAM
wmic MEMORYCHIP get CAPACITY | Out-File -FilePath $OutputFile -Encoding UTF8 -Append
### Obter Discos
wmic DISKDRIVE get Model,Size | Out-File -FilePath $OutputFile -Encoding UTF8 -Append
### Obter S.O
wmic OS get Name,Version | Out-File -FilePath $OutputFile -Encoding UTF8 -Append
### Obter Hostname
wmic COMPUTERSYSTEM get Name | Out-File -FilePath $OutputFile -Encoding UTF8 -Append
### Obter Chave do Windows
wmic path softwarelicensingservice get OA3xOriginalProductKey | Out-File -FilePath $OutputFile -Encoding UTF8 -Append

# Exibir mensagem de conclusão
echo "As informações foram salvas em $OutputFile. Envie o arquivo para o e-mail solicitado."

# Aguardar entrada do usuário antes de enerrar o script
Read-Host "Pressione qualquer tecla para encerrar o script."