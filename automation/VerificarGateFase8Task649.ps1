# VerificarGateFase8Task649.ps1
#
# Prova, SEM executar o orquestrador, que a Fase 8 de SIGOPBUS -> Formsigopbus
# passa pelo motivo ESTRUTURAL certo e nao por acaso:
#   1) o OrquestradorMigracao.ps1 continua sintaticamente valido;
#   2) os 4 nomes CRUD-canonicos nao bloqueiam - e FormParaBO/BOParaForm tem
#      definicao ANCORADA de verdade (criterio mais duro que o -match solto do
#      gate), entao nao dependem do "furo" do comentario de cabecalho;
#   3) o UNICO bloqueio que restava era a exigencia de BOTAO DE ACAO, e ela eh
#      dispensada pela prova de tres partes que o proprio gate ja tem - legado
#      sem botao de gravar + EXATAMENTE 1 botao + Click que so fecha. O Click
#      do Sair legado eh "x=Inkey(.1) / ThisForm.Release", e o Inkey com
#      resultado DESCARTADO passou a contar como no-op em
#      Test-LegadoCliqueSoFecha (Erro200);
#   4) nada foi inventado no form: o unico botao do SCX continua sendo o Sair,
#      com handler BtnSairClick nomeado pelo objeto/acao do legado.
#
# AST-only de proposito: dot-source do orquestrador DISPARA uma migracao real
# (move .SCX de origem\ e sobrescreve BO existente).
# Dot-source do orquestrador DISPARA migracao real - por isso so as funcoes.
$src = 'C:\4c\automation\OrquestradorMigracao.ps1'
$e = $null
[System.Management.Automation.Language.Parser]::ParseFile($src, [ref]$null, [ref]$e) | Out-Null
if ($e -and $e.Count -gt 0) { "SINTAXE=FALHA"; exit 1 }
"SINTAXE=OK"
$ast = [System.Management.Automation.Language.Parser]::ParseFile($src, [ref]$null, [ref]$null)
foreach ($f in $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)) {
    . ([scriptblock]::Create($f.Extent.Text))
}
$txt      = Get-Content 'C:\4c\tasks\task649\sigopbus_form_codigo_fonte.txt' -Raw
$conteudo = Get-Content 'C:\4c\projeto\app\forms\operacionais\Formsigopbus.prg' -Raw
$padraoAcaoGravar = 'PROCEDURE\s+Btn(Salvar|Confirmar|Gravar|Processa|Aplicar|Executar|OK)\w*Click'

# (1) os 4 nomes CRUD-canonicos, como o gate os checa (-match solto)
$metodosFinals  = @("BtnCancelarClick","FormParaBO","BOParaForm","CarregarLista")
$faltantes      = @($metodosFinals | Where-Object { $conteudo -notmatch $_ })
"faltantes(-match solto, como o gate)  = [{0}]" -f ($faltantes -join ', ')

# (2) os mesmos nomes ANCORADOS em definicao real (criterio mais duro que o gate)
foreach ($m in $metodosFinals) {
    $anc = $conteudo -match ('(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+' + $m + '\b')
    "  {0,-18} definicao ancorada = {1}" -f $m, $anc
}

# (3) superficie que o ramo CALCULADORA cobra antes de dispensar
$temSuperficieCalc = ($conteudo -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+FormParaBO\b') -and
                     ($conteudo -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+BOParaForm\b') -and
                     ($conteudo -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+Btn\w*Click\b')
"temSuperficieCalcF8                   = $temSuperficieCalc"

# (4) bloco do BOTAO DE ACAO - o que reprovava a fase
$semSalvar = -not (@('btnSalvar','btnGravar','PROCEDURE\s+\w*(Salvar|Gravar)\w*\.Click','mGravaDados') | Where-Object { $txt -match $_ })
$csf       = Test-LegadoCliqueSoFecha  -TextoDump $txt
$nBot      = Get-ContagemBotoesLegado  -TextoDump $txt
$semAcao   = (($csf -eq $true) -and ($nBot -eq 1))
"legadoSemSalvar                       = $semSalvar"
"cliqueSoFecha / nBotoes               = {0} / {1}" -f $csf, $nBot
"legadoSemAcao (dispensa o botao)      = $semAcao"
$bloqueiaAcao = (-not ($conteudo -match $padraoAcaoGravar)) -and (-not $semAcao)
"bloqueio por botao de acao            = $bloqueiaAcao"

# (5) veredito
if ($faltantes.Count -eq 0 -and -not $bloqueiaAcao) { "`nVEREDITO FASE 8 = PASSA" } else { "`nVEREDITO FASE 8 = REPROVA" }
