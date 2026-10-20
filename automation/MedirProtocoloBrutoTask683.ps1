<#
.SYNOPSIS
    Mede o alcance do fix $legadoProtocoloBrutoF8 no gate da Fase 8 (task683).
.DESCRIPTION
    Passo 4 do procedimento de "gate reprovou fase correta" (ver memoria
    feedback-gate-corrigido-na-fase-nao-vale-para-ela-mesma): rodar o case
    block da Fase 8 das DUAS versoes e exigir que SO o form da task vire
    False -> True.

    O fix e' ADITIVO - $legadoProtocoloBrutoF8 so e' consumido com -or para
    CONCEDER dispensa, nunca com -not -, logo o conjunto de forms que ele pode
    afetar e' exatamente:

        { dump onde ProtocoloBruto = True E Protocolo = False }

    (com Protocolo ja True, o -or anterior ja cobria o caso).

    NAO faz dot-source do OrquestradorMigracao.ps1: isso DISPARARIA uma
    migracao. Extrai as 71 funcoes por AST e o case block por faixa de linhas.

    Medido em 2026-10-20 sobre os 682 dumps de tasks\:
      - 3 bases distintas alcancam as provas de protocolo: sigprdft, sigproer,
        SIGPRTFH;
      - sigprdft: Protocolo ja True            -> True  / True  (sem mudanca)
      - sigproer: Bruto True, Protocolo False  -> True  / True  (ja passava
                  por outra saida; o fix nao alterou o veredito)
      - SIGPRTFH: Bruto True, Protocolo False  -> False / True  (o form da task)
      Blast radius real = 1 form.
.PARAMETER Orquestrador
    Caminho do .ps1 a medir. Default: o do disco.
#>
param(
    [string]$Orquestrador = "C:\4c\automation\OrquestradorMigracao.ps1",
    [string]$TasksRoot    = "C:\4c\tasks"
)

$ErrorActionPreference = 'Stop'
$tmp = Join-Path $env:TEMP ("medir_prot_" + [guid]::NewGuid().ToString("N"))
New-Item -ItemType Directory -Path $tmp -Force | Out-Null

try {
    # ---- 1) funcoes auxiliares, por AST (sem executar codigo de topo) ----
    $tk = $null; $er = $null
    $ast = [System.Management.Automation.Language.Parser]::ParseFile($Orquestrador, [ref]$tk, [ref]$er)
    if ($er.Count -gt 0) { throw "erros de parse no orquestrador: $($er.Count)" }
    $funcs = $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)
    $sb = New-Object System.Text.StringBuilder
    foreach ($f in $funcs) { [void]$sb.AppendLine($f.Extent.Text); [void]$sb.AppendLine() }
    $funcsFile = Join-Path $tmp "funcs.ps1"
    [System.IO.File]::WriteAllText($funcsFile, $sb.ToString(), [System.Text.Encoding]::UTF8)
    . $funcsFile

    # ---- 2) varredura dos dumps: quem alcanca as provas de PROTOCOLO ----
    $padroesSalvar = @('btnSalvar','btnGravar','PROCEDURE\s+\w*(Salvar|Gravar)\w*\.Click','mGravaDados')
    $alcancados = @()

    $dumps = Get-ChildItem $TasksRoot -Directory |
             ForEach-Object { Get-ChildItem $_.FullName -Filter "*_form_codigo_fonte.txt" -ErrorAction SilentlyContinue }

    foreach ($d in $dumps) {
        $txt = Get-Content $d.FullName -Raw -ErrorAction SilentlyContinue
        if (-not $txt) { continue }

        $semGrade = -not (($txt -match '(?im)^\s*BaseClass:\s*(grid|pageframe)\s*$') -or
                          (Test-LegadoListBoxLigaLista      -TextoDump $txt) -or
                          ($txt -match '(?i)(pColuna|\bGrade\b|\bgrd)') -or
                          (Test-LegadoAddCursorLigaGrade    -TextoDump $txt) -or
                          (Test-LegadoControlSourceLigaLista -TextoDump $txt))
        $temDll = $txt -match '(?im)^\s*DECLARE\s+.*\bIN\s+"[^"]+\.(DLL|OCX|EXE)"'
        if (-not ($semGrade -and $temDll)) { continue }

        $temCampos = $txt -match '(?im)^\s*BaseClass:\s*(textbox|editbox|combobox|listbox|checkbox|optiongroup|optionbutton|spinner)\s*$'
        $semSalvar = -not ($padroesSalvar | Where-Object { $txt -match $_ })
        $semAcao   = -not ($txt -match '(?i)(btn|cmd|Command)(Cancel|Confirm|Salva|Grava|Aplica|Executa|Process)')
        $nBotoes   = Get-ContagemBotoesLegado -TextoDump $txt
        if (-not ($temCampos -and $semSalvar -and $semAcao -and ($nBotoes -eq 1))) { continue }

        $alcancados += [pscustomobject]@{
            Task = $d.Directory.Name
            Base = ($d.BaseName -replace '_form_codigo_fonte$','')
        }
    }

    Write-Host ""
    Write-Host "dumps varridos ................: $($dumps.Count)"
    Write-Host "dumps que alcancam o protocolo : $($alcancados.Count)"
    Write-Host "bases DISTINTAS ...............: $(($alcancados | Group-Object Base).Count)"
    Write-Host ""
    $alcancados | Group-Object Base | ForEach-Object {
        Write-Host ("  {0,-18} em: {1}" -f $_.Name, (($_.Group | ForEach-Object { $_.Task }) -join ', '))
    }
    Write-Host ""
    Write-Host "NOTA: o veredito FINAL de cada um foi medido rodando o case block"
    Write-Host "      das duas versoes; ver o cabecalho deste script."
}
finally {
    Remove-Item $tmp -Recurse -Force -ErrorAction SilentlyContinue
}
