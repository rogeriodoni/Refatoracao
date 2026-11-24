$ErrorActionPreference = 'Stop'
$f = 'C:\4c\projeto\app\classes\SigOpTotBO.prg'
$enc = [System.Text.Encoding]::GetEncoding(28591)
$script:t = [System.IO.File]::ReadAllText($f, $enc)

$LF = [string][char]10
$CR = [string][char]13
# o arquivo chegou da fase anterior em LF; as ancoras casam em LF e na
# gravacao final tudo volta para CRLF (convencao dos demais .prg)
$NL = $LF
$script:nAplic = 0

function Swap([string]$old, [string]$new, [string]$rotulo) {
    $n = ([regex]::Matches($script:t, [regex]::Escape($old))).Count
    if ($n -ne 1) { throw "ANCORA '$rotulo' casou $n vez(es) - esperado 1" }
    $script:t = $script:t.Replace($old, $new)
    $script:nAplic++
    Write-Host ("  [OK] " + $rotulo)
}

# ---------------------------------------------------------------- A1: header
$oldHdr = @(
'* NATUREZA DESTE DIALOGO: e SOMENTE LEITURA - todas as colunas das grades',
'* (grade_total/Grade_Serv/Grade_ProdutoTam/Grade_Produto/GrdTCompo) tem',
'* Text1.When = Return .F. no SCX e nao ha nenhum Click/DblClick nelas; o',
'* unico botao e OK.btnSair ("Retornar"), que so reabilita o form pai e',
'* libera o dialogo. O campo editavel (Get_Compensacao) grava DIRETO no',
'* cursor TprMvCab do form pai via ControlSource - este BO nunca grava em',
'* tabela do SQL Server (a unica excecao e o INSERT/DELETE transitorio em',
'* SigTempD, usado so como area de troca para calcular componentes, nunca',
'* como persistencia de entidade).',
'*',
'* Por isso este BO NAO sobrescreve Inserir()/Atualizar()/',
'* ExecutarExclusao()/RegistrarAuditoria(): o comportamento padrao herdado',
'* de BusinessBase (recusar a operacao) ja eh o correto, e inventar',
'* INSERT/UPDATE aqui violaria a regra #22 do CLAUDE.md (a lista de colunas',
'* vem do schema, nunca de adivinhacao). Os metodos desta fase reproduzem a',
'* logica real do PROCEDURE Init + PROCEDURE calctotais do SIGOPTOT.SCX',
'* legado (tasks\task813\SigOpTot_form_codigo_fonte.txt, linhas 1278-1593).'
) -join $NL

$aspa = [string][char]39
$newHdr = @(
'* NATUREZA DESTE DIALOGO: para o USUARIO e uma tela de consulta - todas as',
'* colunas das grades (grade_total/Grade_Serv/Grade_ProdutoTam/',
'* Grade_Produto/GrdTCompo) tem Text1.When = Return .F. no SCX e nao ha',
'* nenhum Click/DblClick nelas; o unico botao e OK.btnSair ("Retornar"),',
'* que so reabilita o form pai e libera o dialogo. O campo editavel',
'* (Get_Compensacao) grava DIRETO no cursor TprMvCab do form pai via',
'* ControlSource, nunca em tabela.',
'*',
'* MAS O LEGADO GRAVA NO SQL SERVER: quando a operacao explode componentes',
'* (crSigCdOpe.TotCompos = 1), o Init legado (linhas 1448-1505) usa a',
'* tabela SigTempD como AREA DE TROCA, para poder fazer o agrupamento no',
('* servidor - ele faz .Addcursor(' + $aspa + 'SigTempD' + $aspa + ',...), Zap, Append Blank +'),
('* Replace por produto, Podatamgr.UpDate(' + $aspa + 'CrSigTempD' + $aspa + ') + commit() (que e'),
'* o TABLEUPDATE do Fortyus, ou seja um INSERT remoto), consulta o JOIN',
'* SigTempD x SigPrCpo e por fim "Delete From SigTempD Where CidQuerys =',
'* ?lcCidQuery3". Essas duas gravacoes remotas sao reproduzidas aqui em',
'* Inserir() (o INSERT) e ExecutarExclusao() (o DELETE), com a lista de',
'* colunas tirada do schema e nao de adivinhacao (regra #22 do CLAUDE.md):',
'* alem das colunas que o legado preenche (cidquerys/cpros/qtds) entram as',
'* duas NOT NULL sem DEFAULT de SIGTEMPD - cidchaves char(64), que e a PK e',
'* recebe fUniqueIds(), e dpros char(65), que no legado ficava em branco',
'* por vir do registro em branco do Append Blank.',
'*',
'* Atualizar() NAO e sobrescrito: o legado nao tem nenhum UPDATE contra',
'* SigTempD (as linhas sao escritas uma vez e apagadas no fim do mesmo',
'* processo), e escrever um UPDATE aqui seria inventar SQL - o',
'* comportamento herdado de BusinessBase, que recusa a operacao e reporta',
'* pelo ExibirFalha do Salvar, ja e o correto. RegistrarAuditoria() tambem',
'* nao e sobrescrito: SigTempD e area de troca transitoria, nao entidade de',
'* negocio, e auditar cada linha dela encheria LogAuditoria a cada abertura',
'* da tela - o legado tambem nao registra nada disso.',
'*',
'* Os metodos desta classe reproduzem a logica real do PROCEDURE Init +',
'* PROCEDURE calctotais do SIGOPTOT.SCX legado',
'* (tasks\task813\SigOpTot_form_codigo_fonte.txt, linhas 1278-1593).'
) -join $NL
Swap $oldHdr $newHdr 'A1 cabecalho'

# ------------------------------------------------------- A2: novas properties
$ancProTam = '    this_cCursorProTam    = "ProTam"       && Totais agrupados por produto + tamanho (Grade_ProdutoTam)'
$blocoProps = @(
'',
'    *-- Cursor de agrupamento por produto que alimenta Inserir() (equivale',
'    *-- ao cursor wEesti do Init legado, linha 1452)',
'    this_cCursorAgrupado  = "cursor_4c_CompoAgrupado"',
'',
'    *-- Flags do TIPO DE OPERACAO. CarregarDoCursor() e a fonte UNICA de',
'    *-- leitura destas colunas; os metodos que decidem por elas usam a',
'    *-- property, nunca o cursor. Todas as colunas de flag sao',
'    *-- numeric(1,0) NOT NULL no schema (SigCdOpe.ChkQtds/PesoVts/',
'    *-- PrecoVts/HabServs/TotCompos/Opers), por isso ficam em property',
'    *-- NUMERICA (this_n*) e nunca logica - coluna numeric(1,0) de duas',
'    *-- opcoes NAO e booleana (CLAUDE.md), e aqui ChkQtds vale 6 ou 7 e',
'    *-- Opers e comparada com 3.',
'    this_nChkQtds   = 0    && SigCdOpe.ChkQtds   - 6/7 trocam o criterio de soma de quantidade/peso',
'    this_nPesoVts   = 0    && SigCdOpe.PesoVts   - 1 = acumula o peso no total por moeda',
'    this_nPrecoVts  = 0    && SigCdOpe.PrecoVts  - 1 = acumula o valor no total por moeda',
'    this_nHabServs  = 0    && SigCdOpe.HabServs  - 1 = a operacao tem grade de servicos',
'    this_nTotCompos = 0    && SigCdOpe.TotCompos - 1 = a operacao explode componentes (SigTempD x SigPrCpo)',
'    this_nOpers     = 0    && SigCdOpe.Opers     - 3 inverte o multiplicador de entrada/saida',
'    this_cCmoes     = ""   && SigCdOpe.Cmoes     - char(3): moeda fixa da operacao (vazia = usa a do item)',
'    this_cDocQtd2s  = ""   && SigOpCdc.DocQtd2s  - char(12): rotulo alternativo do total de peso',
'    this_nMtCubs    = 0    && SigOpCdd.MtCubs    - numeric(4,0): <> 0 habilita o total em metros cubicos',
'',
'    *-- Latch de carga das flags acima. Os metodos que decidem por flag',
'    *-- (CalcularTotais/ProcessarComponentes/MontarGradeServicos) chamam a',
'    *-- carga quando este latch esta desligado, para a flag nunca ser lida',
'    *-- como zero so porque o metodo foi acionado por um caminho que nao',
'    *-- passou pelo ProcessarTotais - zero em TotCompos/HabServs',
'    *-- desligaria secao inteira da tela sem erro nenhum.',
'    this_lFlagsCarregadas = .F.'
) -join $NL
Swap $ancProTam ($ancProTam + $blocoProps) 'A2 properties'

# ------------------------------------------------------------ A3: Init defaults
# a linha do rotulo aparece tambem no ELSE de PrepararRotuloTotalPeso, por
# isso a ancora precisa levar o "loc_lResultado = .T." que so existe no Init
$ancInit = @(
'            THIS.this_cRotuloTotalPeso = "Total Peso :"',
'',
'            loc_lResultado = .T.'
) -join $NL
$blocoInit = @(
'            THIS.this_cRotuloTotalPeso = "Total Peso :"',
'            THIS.this_nChkQtds   = 0',
'            THIS.this_nPesoVts   = 0',
'            THIS.this_nPrecoVts  = 0',
'            THIS.this_nHabServs  = 0',
'            THIS.this_nTotCompos = 0',
'            THIS.this_nOpers     = 0',
'            THIS.this_cCmoes     = ""',
'            THIS.this_cDocQtd2s  = ""',
'            THIS.this_nMtCubs    = 0',
'            THIS.this_lFlagsCarregadas = .F.',
'',
'            loc_lResultado = .T.'
) -join $NL
Swap $ancInit $blocoInit 'A3 Init defaults'

# ------------------------------------------- A4: ProcessarTotais chama a carga
$ancPrep = '        THIS.PrepararRotuloTotalPeso()'
$novoPrep = @(
'        *-- Fonte unica das flags do tipo de operacao (ChkQtds/PesoVts/',
'        *-- PrecoVts/HabServs/TotCompos/Opers/Cmoes) e dos parametros',
'        *-- complementares (DocQtd2s/MtCubs): tem de rodar ANTES de',
'        *-- qualquer decisao por flag.',
'        IF !THIS.CarregarDoCursor(THIS.this_cCursorOperacao)',
'            RETURN .F.',
'        ENDIF',
'',
'        THIS.PrepararRotuloTotalPeso()'
) -join $NL
Swap $ancPrep $novoPrep 'A4 ProcessarTotais'

# ---- gravacao: normaliza para CRLF (convencao dos demais .prg do projeto)
$saida = $script:t.Replace($CR + $LF, $LF).Replace($LF, $CR + $LF)
[System.IO.File]::WriteAllText($f, $saida, $enc)
Write-Host ''
Write-Host ('APLICADOS: ' + $script:nAplic + ' blocos')
