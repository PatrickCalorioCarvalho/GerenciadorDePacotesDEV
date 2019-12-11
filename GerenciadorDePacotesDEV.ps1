' $Pacotes = @{
             "NodeJS"= @{
                           "Instalador" = "choco install nodejs-lts";
                           "Versao" = "node -v";
                           "VersaoInstalada" = "NULL";
                           "Instalar" = $false;
                        };
             "Visual Studio Code"= @{
                           "Instalador" = "choco install vscode";
                           "Versao" = "code -v";
                           "VersaoInstalada" = "NULL";
                           "Instalar" = $false;
                        };
             "Python 3"= @{
                           "Instalador" = "choco install python3";
                           "Versao" = "python3 --version";
                           "VersaoInstalada" = "NULL";
                           "Instalar" = $false;
                        };
                        

}

$Form = New-Object System.Windows.Forms.Form
$Form.Text = "Gerenciador De Pacotes DEV"
$Form.width = 500
$Form.height = 750
$Form.StartPosition = "CenterScreen" 
 
$Font = New-Object System.Drawing.Font("Times New Roman",12)
$Form.Font = $Font

$X=30;
$Y=30;

foreach($pacote in $pacotes.Keys)
{
    foreach($info in $pacotes[$pacote])
    {
        try {
            $Teste = Invoke-Expression $info.Versao -ErrorAction Stop;
            $info.VersaoInstalada =  $Teste.Split("/n")[0];
            $info.Instalar = $true;
        } catch [Exception] {
            $info.VersaoInstalada =  "NULL";
            $info.Instalar = $false;
        }
        $checkbox = new-object System.Windows.Forms.checkbox
        $checkbox.Location = new-object System.Drawing.Size($X,$Y)
        $checkbox.Size = new-object System.Drawing.Size(500,30)
        $checkbox.Text = "$pacote ($($info.VersaoInstalada))"
        $checkbox.Checked = $info.Instalar
        $Form.Controls.Add($checkbox)  
        $Y=$Y+30;
    }
}

$Form.ShowDialog() 
