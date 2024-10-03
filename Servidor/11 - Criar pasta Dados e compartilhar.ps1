mkdir C:\Dados
New-SmbShare -Name "Dados" -Path "C:\Dados" -FullAccess "Everyone"
cd C:\Dados
mkdir "Administrativo", "Depto Contabil", "Depto Legal", "Depto Pessoal", "Depto Fiscal", "Diretoria", "Financeiro", "Publico", "Transferencia"