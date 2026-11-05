# MedirGateFase7Painel.ps1
#
# Mede, em TODOS os dumps de tasks\, o predicado da nona excecao do gate da
# Fase 7 (Test-VerbosCrudSaoTodosDePainelDeLinha) e o VEREDICTO composto
# ($legadoSemCrud) que o call site do `case 7` calcula a partir dele.
#
# Serve para comparar HEAD x patch: a mesma logica roda contra duas copias do
# OrquestradorMigracao.ps1, e o que importa eh (a) quantos dumps mudam de
# veredicto e (b) se alguma mudanca eh REGRESSAO (CRUD de verdade sendo
# dispensado).
#
# As funcoes sao extraidas por AST - dot-source do orquestrador DISPARA uma
# migracao real.
param(
    [string]$Orquestrador = 'C:\4c\automation\OrquestradorMigracao.ps1',
    [string]$Saida        = 'C:\4c\automation\_m734\medicao_f7_painel.csv'
)

$ast = [System.Management.Automation.Language.Parser]::ParseFile($Orquestrador, [ref]$null, [ref]$null)
foreach ($f in $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)) {
    . ([scriptblock]::Create($f.Extent.Text))
}

$linhas = @()

foreach ($dump in (Get-ChildItem 'C:\4c\tasks' -Filter '*_form_codigo_fonte.txt' -Recurse -File)) {
    $txt = Get-Content $dump.FullName -Raw -ErrorAction SilentlyContinue
    if (-not $txt) { continue }

    # ---- replica do call site do case 7, na MESMA ordem -------------------
    $temCrud = ($txt -match 'frmcadastro') -or ($txt -match 'Grupo_Op')

    if ($temCrud -and ($txt -notmatch 'frmcadastro') -and (Test-BarraCrudEhDoFormPai -TextoDump $txt)) {
        $temCrud = $false
    }
    if ($temCrud -and ($txt -notmatch 'frmcadastro') -and (Test-GrupoOpSemVerboCrud -TextoDump $txt)) {
        $temCrud = $false
    }

    $casouNome   = $txt -match '(btn|cmd|Command)(Incluir|Alterar|Visualizar)(?![A-Za-z0-9_])'
    $soPainel    = $null
    if (-not $temCrud -and $casouNome) {
        $ehFilho   = Test-DialogoFilhoDoChamador -TextoDump $txt
        $soRel     = Test-VerbosCrudSaoTodosDeRelatorio -TextoDump $txt
        $soLinha   = Test-VerbosCrudSaoTodosDeLinhaDeGrade -TextoDump $txt
        $soPainel  = Test-VerbosCrudSaoTodosDePainelDeLinha -TextoDump $txt
        if (-not $ehFilho -and -not $soRel -and -not $soLinha -and -not $soPainel) {
            $temCrud = $true
        }
    }

    if (-not $temCrud) {
        if ((Get-ContagemPcEscolhaViva -TextoDump $txt) -gt 0) {
            if (-not (Test-ModoRecebidoDoChamador -TextoDump $txt)) { $temCrud = $true }
        }
    }

    if (-not $temCrud) {
        foreach ($m in [regex]::Matches($txt, '(?i)([A-Za-z0-9_]*)\s*\.\s*(Incluir|Alterar|Visualizar|Excluir)\s*\.\s*Click')) {
            if ($m.Groups[1].Value -notmatch '(?i)(Grd|Grade|Grid)') { $temCrud = $true; break }
        }
        if (-not $temCrud -and $txt -match '(?im)(^|[^A-Za-z0-9_.])(Incluir|Alterar|Visualizar|Excluir)\s*\.\s*Click') {
            $temCrud = $true
        }
    }

    $linhas += [pscustomobject]@{
        Dump          = $dump.FullName.Replace('C:\4c\tasks\', '')
        Base          = $dump.Name -replace '_form_codigo_fonte\.txt$', ''
        CasouNome     = $casouNome
        SoPainel      = $soPainel
        LegadoSemCrud = (-not $temCrud)
    }
}

$linhas | Sort-Object Dump | Export-Csv -Path $Saida -NoTypeInformation -Encoding UTF8
"DUMPS={0}  SAIDA={1}" -f $linhas.Count, $Saida
