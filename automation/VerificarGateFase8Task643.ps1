# Replica a parte decisiva do case 8 do OrquestradorMigracao.ps1 para a
# task643 / FormSigOpAtu e imprime o VEREDICTO (metodos faltantes + exigencia
# de botao de acao).
#
# NAO dot-source o orquestrador (dispara migracao real) - so as definicoes de
# funcao, via AST. Mesmo padrao de VerificarGateFase8SigPrEst.ps1.

$RaizRepo4c = Split-Path -Parent $PSScriptRoot
$src = "$($RaizRepo4c)\automation\OrquestradorMigracao.ps1"
$ast = [System.Management.Automation.Language.Parser]::ParseFile($src, [ref]$null, [ref]$null)
$funcs = $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)
foreach ($f in $funcs) { . ([scriptblock]::Create($f.Extent.Text)) }

$txtLegadoF8 = Get-Content "$($RaizRepo4c)\tasks\task643\SigOpAtu_form_codigo_fonte.txt" -Raw
$conteudo    = Get-Content "$($RaizRepo4c)\projeto\app\forms\operacionais\FormSigOpAtu.prg" -Raw

$metodosFinals    = @("BtnCancelarClick", "FormParaBO", "BOParaForm", "CarregarLista")
$metodosFaltantes = @($metodosFinals | Where-Object { $conteudo -notmatch $_ })
"metodosFaltantes : [$($metodosFaltantes -join ', ')]"

$padroesSalvar   = @('btnSalvar','btnGravar','PROCEDURE\s+\w*(Salvar|Gravar)\w*\.Click','mGravaDados')
$legadoSemSalvar = -not ($padroesSalvar | Where-Object { $txtLegadoF8 -match $_ })
"legadoSemSalvar  : $legadoSemSalvar"

$padraoAcaoGravar = 'PROCEDURE\s+Btn(Salvar|Confirmar|Gravar|Processa|Aplicar|Executar|OK)\w*Click'
$temAcaoGravar    = $conteudo -match $padraoAcaoGravar
"temAcaoGravar    : $temAcaoGravar  (padrao canonico casou BtnOkClick)"

$cliqueSoFecha = Test-LegadoCliqueSoFecha -TextoDump $txtLegadoF8
$nBotoes       = Get-ContagemBotoesLegado -TextoDump $txtLegadoF8
"cliqueSoFecha    : $cliqueSoFecha    nBotoesLegado: $nBotoes"

if ($metodosFaltantes.Count -eq 0 -and $temAcaoGravar) {
    "VEREDICTO        : PASSA"
    exit 0
} else {
    "VEREDICTO        : REPROVA"
    exit 1
}
