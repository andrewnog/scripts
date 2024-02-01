# Importar o módulo Active Directory
Import-Module ActiveDirectory

# Criar uma unidade organizacional chamada "Empresa" na raiz do domínio
New-ADOrganizationalUnit -Name "Empresa" -Description "Unidade organizacional para a empresa"

# Criar um array com os nomes dos departamentos
$departamentos = @("Contabil", "RH", "Fiscal", "Legal", "Juridico", "TI", "Diretoria")

# Criar um array com o número de usuários para cada departamento
$usuarios = @(5, 5, 5, 5, 5, 1, 3)

# Criar um loop para cada departamento
for ($i = 0; $i -lt $departamentos.Length; $i++) {

    # Obter o nome do departamento e o número de usuários do array
    $departamento = $departamentos[$i]
    $num_usuarios = $usuarios[$i]

    # Criar uma unidade organizacional para o departamento dentro da unidade organizacional "Empresa"
    New-ADOrganizationalUnit -Name $departamento -Path "OU=Empresa,DC=plugarit,DC=com,DC=br" -Description "Unidade organizacional para o departamento de $departamento"

    # Criar um grupo para o departamento dentro da unidade organizacional do departamento
    New-ADGroup -Name ("GP_" + $departamento) -GroupScope Global -GroupCategory Security -Path "OU=$departamento,OU=Empresa,DC=plugarit,DC=com,DC=br" -Description "Grupo de segurança para o departamento de $departamento"

    # Criar um loop para criar o número de usuários especificado para o departamento
    for ($j = 1; $j -le $num_usuarios; $j++) {

        # Criar um nome de usuário baseado no nome do departamento e no número do loop
        $username = $departamento.ToLower() + "0" + $j

        # Verificar se o departamento é TI e o usuário é o primeiro
        if ($departamento -eq "TI" -and $j -eq 1) {

            # Criar um usuário com o nome de "Plugar IT" na unidade organizacional do TI e adicioná-lo ao grupo do TI
            New-ADUser -Name "Plugar IT" -GivenName "Plugar" -Surname "IT" -SamAccountName "PlugarIT" -UserPrincipalName "PlugarIT@plugarit.com.br" -Path "OU=TI,OU=Empresa,DC=plugarit,DC=com,DC=br" -AccountPassword (ConvertTo-SecureString "Plug@r1t" -AsPlainText -Force) -Enabled $true -Description "Usuário para o departamento de TI" -CannotChangePassword $true -PasswordNeverExpires $true
            Add-ADGroupMember -Identity "GP_TI" -Members "PlugarIT"
        }
        else {

            # Criar um usuário com o nome de usuário gerado na unidade organizacional do departamento e adicioná-lo ao grupo do departamento
            New-ADUser -Name $username -GivenName $username -Surname $username -SamAccountName $username -UserPrincipalName "$username@plugarit.com.br" -Path "OU=$departamento,OU=Empresa,DC=plugarit,DC=com,DC=br" -AccountPassword (ConvertTo-SecureString "Plug@r1t" -AsPlainText -Force) -Enabled $true -Description "Usuário para o departamento de $departamento" -CannotChangePassword $true -PasswordNeverExpires $true
            Add-ADGroupMember -Identity ("GP_" + $departamento) -Members $username
        }
    }
}
