# VerificarGateFase8Task648.ps1
#
# Prova, SEM executar o orquestrador, que a Fase 8 de SIGOPBOL -> FormSIGOPBOL
# passa pelo motivo ESTRUTURAL certo e nao por acaso:
#   1) o OrquestradorMigracao.ps1 continua sintaticamente valido;
#   2) os 4 nomes CRUD-canonicos nao bloqueiam;
#   3) o UNICO bloqueio que restava era o nome do handler de acao
#      (PROCEDURE Btn(Salvar|Confirmar|...)Click), e ele eh dispensado por
#      Test-AcaoDoLegadoTemHandler - verbo REAL do legado ("Imprimir", de
#      Command1.Name = "Cmd_Imprimir") casando com o handler REAL do migrado
#      (CmdImprimirClick), e NAO por ter sido inventado um botao;
#   4) a fronteira de seguranca segue fechada: o legado nao tem botao de
#      gravar ($legadoSemSalvar), que eh a pre-condicao para o helper ser
#      sequer consultado.
#
# AST-only de proposito: dot-source do orquestrador DISPARA uma migracao real
# (move .SCX de origem\ e sobrescreve BO existente).

$src = 'C:\4c\automation\OrquestradorMigracao.ps1'
$erros = $null
[System.Management.Automation.Language.Parser]::ParseFile($src, [ref]$null, [ref]$erros) | Out-Null
if ($erros -and $erros.Count -gt 0) {
    "SINTAXE=FALHA ({0} erro(s))" -f $erros.Count
    $erros | Select-Object -First 5 | ForEach-Object { "  L{0}: {1}" -f $_.Extent.StartLineNumber, $_.Message }
    exit 1
}
"SINTAXE=OK"

$ast = [System.Management.Automation.Language.Parser]::ParseFile($src, [ref]$null, [ref]$null)
foreach ($f in $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)) {
    . ([scriptblock]::Create($f.Extent.Text))
}

$txt      = Get-Content 'C:\4c\tasks\task648\SIGOPBOL_form_codigo_fonte.txt' -Raw
$conteudo = Get-Content 'C:\4c\projeto\app\forms\operacionais\FormSIGOPBOL.prg' -Raw
$padraoAcaoGravar = 'PROCEDURE\s+Btn(Salvar|Confirmar|Gravar|Processa|Aplicar|Executar|OK)\w*Click'

# ---- (2) os 4 nomes CRUD-canonicos ----------------------------------------
$metodosFinals = @("BtnCancelarClick", "FormParaBO", "BOParaForm", "CarregarLista")
$faltantes = @($metodosFinals | Where-Object { $conteudo -notmatch $_ })
"metodosFaltantes(4 nomes)   = [{0}]" -f ($faltantes -join ', ')

# ---- superficie do LEGADO -------------------------------------------------
$semSalvar = -not (@('btnSalvar','btnGravar','PROCEDURE\s+\w*(Salvar|Gravar)\w*\.Click','mGravaDados') | Where-Object { $txt -match $_ })
$csf       = Test-LegadoCliqueSoFecha -TextoDump $txt
"legadoSemSalvar             = {0}   <- pre-condicao do helper" -f $semSalvar
"nBotoesLegado               = {0}" -f (Get-ContagemBotoesLegado -TextoDump $txt)
"cliqueSoFecha               = {0}   <- o Click IMPRIME antes de fechar" -f $(if ($null -eq $csf) {'<nulo>'} else {$csf})
"somenteLeitura              = {0}" -f (Test-LegadoSomenteLeitura -TextoDump $txt)

# ---- (3) o helper do verbo ------------------------------------------------
$acao = Test-AcaoDoLegadoTemHandler -TextoDump $txt -ConteudoForm $conteudo
"padraoAcaoGravar no migrado = {0}   <- nome canonico NAO casa (acao e' imprimir)" -f ($conteudo -match $padraoAcaoGravar)
"acaoDoLegadoTemHandler      = {0}" -f $acao

# ---- (4) veredito ---------------------------------------------------------
$bloqueiaAcao = (-not ($conteudo -match $padraoAcaoGravar)) -and (-not ($semSalvar -and $acao))
"bloqueio por botao de acao  = {0}" -f $bloqueiaAcao

if ($faltantes.Count -eq 0 -and -not $bloqueiaAcao) {
    "VEREDITO=PASSA (metodosFaltantes vazio)"
    exit 0
}
"VEREDITO=REPROVA"
exit 1
