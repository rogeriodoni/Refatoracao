# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'OP_ESCOLHA' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: PNVIAS, PNQBOLS, LNI, USUACESS, CIMPS, USUARIOS, GRUPOS, NTPIMPRES, PNTPBOL, LNIMPRES, LNCIMP, LLOBS

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES SQL
- [GRID-SQL] Campos no ControlSource que nao existem no CREATE CURSOR/SELECT
- [SQL-COLUNA] Nomes de colunas que NAO existem na tabela (validado contra banco real)
  - A mensagem mostra colunas VALIDAS - usar nome EXATO
  - Se sugere "voce quis dizer 'X'?", usar X
- [SQL-TABELA] Tabela inventada que nao existe no original
- [SQL-ASPAS] Aspas duplicadas ou concatenacao sem EscaparSQL
  - EscaparSQL() JA retorna com aspas. FormatarDataSQL() idem.
- [SQL-FILTRO-INVENTADO] Condicao WHERE inventada pela LLM - REMOVER
- [TRANSACAO-AVULSA] COMMIT/ROLLBACK sem BEGIN TRANSACTION - REMOVER

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

### LINHAS SQL/CONTROLSOURCE DO CODIGO ORIGINAL (referencia):
  ControlSource = ""
If poForm.podatamgr.sqlexecute('select * from SigCdmp order by impres','CrSigCdmp') <= 0
		Insert Into crImpre	(impres) Values(Upper(laPrinters(lnI, 1)))
lcSql = [Select b.* From SigSyImp a, SigCdmp b Where a.UsuAcess = ']+Usuar+[' And a.Cimps = b.Impres ]+;
		[Select c.* From SigCdAcG a, SigSyImp b, SigCdmp c Where a.Usuarios=']+Usuar+[' ]+;
If poForm.podatamgr.sqlexecute(lcSql,'CrTmpCimp') <= 0
Select CrTmpCimp
	Select Distinct Impres, nTpImpres, TpBarra, MaxCols ;
	  From crTmpCimp ;
SELECT PADR(ALLTRIM(a.Impres),15)+' '+ALLTRIM(b.impres) as IDupla, b.impres, a.impres as impresS from crSigCdmp a, crImpre b ;
SELECT * FROM crImp order by 1 into cursor crImpreV
SELECT crImpreV
		Delete File [BOLETO.txt]

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpIbo.prg) - TRECHOS RELEVANTES PARA PASS SQL (2157 linhas total):

*-- Linhas 67 a 85:
67: *   token Grade/grd do proprio form .... 0
68: *   AddCursor que liga grade (5o arg) .. 0 (nenhum AddCursor no dump)
69: *   RecordSource ....................... 0
70: *   ControlSource ...................... 1, e eh `ControlSource = ""` (VAZIO),
71: *                                        no ComboBox Get_Printer
72: * Isto eh: NAO HA LISTA. Ha 7 controles de entrada (1 ComboBox, 1 TextBox,
73: * 3 CheckBox, 1 OptionGroup, 1 EditBox), dos quais so o EditBox eh
74: * ReadOnly = .T. - logo nao eh dialogo de EXIBICAO nem DESPACHANTE: eh um
75: * dialogo de CAPTURA (coleta impressora/quantidade/opcoes e manda imprimir).
76: * O que a Fase 4 tem de concreto para entregar, entao, eh a BARRA DE ACAO do
77: * legado - o CommandGroup btnReport, que eh o equivalente desta tela aos
78: * "botoes" da fase - COM os handlers reais, mais a resolucao da lista de
79: * impressoras, que precisa existir ANTES dos campos (ver ordem abaixo):
80: *   - ConfigurarBotoes()            -> obj_4c_BtnReport (btnReport): Imprimir
81: *                                      (Cmd_Imprimir) e Encerrar (Cmd_Sair)
82: *   - ConfigurarEventos()           -> BINDEVENT dos dois Click
83: *   - CarregarImpressoras()         -> bloco do Init legado que monta crImpreV
84: *                                      (via SigOpIboBO) e resolve lcErro
85: *   - AplicarEstadoBotoes()         -> "With .btnReport / If .Cmd_Imprimir.Enabled"

*-- Linhas 106 a 124:
106: *   3. CarregarImpressoras()        ANTES dos campos: o ComboBox Get_Printer da
107: *                                   fase seguinte tem RowSourceType = 2 e
108: *                                   RowSource = cursor_4c_ImpreV, e atribuir
109: *                                   RowSource/ControlSource de cursor que ainda
110: *                                   NAO existe derruba o Init inteiro (regra
111: *                                   #41) - a tela nao abre
112: *   4. ConfigurarBotoes()
113: *   5. <<< A FASE DOS CAMPOS ENTRA AQUI (ConfigurarControles) >>>
114: *   6. TornarControlesVisiveis()    depois de TODO AddObject
115: *   7. AplicarEstadoBotoes()        depois do passo 6: ele mexe em Enabled, que
116: *                                   o passo 6 nao toca, mas a visibilidade dos
117: *                                   checkboxes (que depende do TpBol) tambem
118: *                                   precisa ser reaplicada depois dele
119: *   8. VerificarImpressaoAutomatica() por ULTIMO: ele CHAMA BtnImprimirClick,
120: *                                   que le o ComboBox e os 3 checkboxes
121: *
122: * TabIndex NAO entra nesta fase, de proposito (continua valendo o registrado na
123: * Fase 3): TabIndex fora da faixa 1..N eh descartado em SILENCIO, e com 3
124: * controles no form o TabIndex = 9 do btnReport seria clampado - uma linha que

*-- Linhas 156 a 174:
156: *     (CarregarImpressoras devolve .T. sem consultar quando gb_4c_ModoTeste /
157: *     gb_4c_ValidandoUI estao ligados) - ligar RowSource a alias inexistente
158: *     derruba o Init e a tela nao abre (regra #41).
159: *   - "ControlSource = """ do dump de Get_Printer NAO eh transcrito: eh
160: *     override VAZIO do Form Designer (regra #49), e apontar o combo para um
161: *     cursor/coluna que nao existe seria defeito, nao fidelidade.
162: *   - "ZOrderSet" do dump de Say9 e de getQtde NAO eh transcrito: a propriedade
163: *     nao existe em runtime em classe nenhuma (eh bookkeeping do Form Designer
164: *     gravado no SCX) e atribui-la derruba o Init (regra #33).
165: *   - AutoSize = .F. EXPLICITO nos quatro rotulos, com Width E Height do dump:
166: *     AutoSize eh no-op em Label criado por AddObject (a Width fica nos 100 do
167: *     default), entao declarar .T. seria uma linha que mente sobre o valor
168: *     efetivo - e os numeros do SCX JA SAO o auto-size que o Form Designer
169: *     calculou (regra #23).
170: *   - Say9 recebe BackStyle = 0 mesmo sem o dump declarar: a classe dele eh
171: *     "say" (framework.vcx), que eh transparente por heranca, e o migrado cria
172: *     um Label BASE, cujo default eh OPACO - sem esta linha o rotulo sairia
173: *     com um retangulo pintado por cima do fundo do form. Os outros tres
174: *     rotulos sao classe "label" e o SCX declara BackStyle = 0 neles.

*-- Linhas 398 a 417:
398: *    chamador para TRES coisas:
399: *      (a) "Set DataSession to poForm.DataSessionId" - compartilhar a
400: *          datasession do chamador;
401: *      (b) "poForm.podatamgr.sqlexecute(...)" - as duas consultas do Init, que
402: *          nesta arquitetura vao por gnConnHandle/SQLEXEC dentro do BO
403: *          (SigOpIboBO.CarregarImpressorasConfiguradas, fase 4);
404: *      (c) "poForm.Op_Escolha" - so no caso vnTpBol = 1, para decidir se o
405: *          botao Encerrar nasce habilitado (llSair).
406: *    Guardar a referencia fecharia um ciclo entre form pai e dialogo filho
407: *    (mesma decisao de SigOpIboBO.prg e de FormSIGOPBOL.prg). Em vez disso o
408: *    objeto chega como PARAMETRO do Init, eh LIDO e DESCARTADO: o que sobra
409: *    guardado sao dois valores escalares - this_nDataSessionChamador (um
410: *    NUMERO) e this_lBloquearEncerrar (um LOGICO).
411: * 2. A datasession do chamador fica REGISTRADA, nao perdida. Este form declara
412: *    DataSession = 2 (fiel ao SCX), logo nasce com datasession PRIVADA; o nome
413: *    do cursor a imprimir (pCursor) chega como STRING e o cursor em si vive na
414: *    datasession do CHAMADOR. O legado resolvia isso trocando a datasession no
415: *    Init. Como SigBlBol (PROCEDURE global do Fortyus) NAO veio no acervo - sem
416: *    .prg e sem FRX, regra CLAUDE.md #27 - nao ha como medir o que ele faz com
417: *    esse nome. Por isso o Id fica guardado em this_nDataSessionChamador e a

*-- Linhas 884 a 902:
884:     * O bypass por gb_4c_ModoTeste/gb_4c_ValidandoUI existe porque o harness
885:     * (TesteAutomatico.prg) define gnConnHandle = 0 DE PROPOSITO e espera que o
886:     * form pule as queries por esses flags, nao por checagem de handle: sem o
887:     * bypass, SQLEXEC falha, InicializarForm devolve .F., CREATEOBJECT devolve
888:     * .F. e o teste de instanciacao reprova sem nenhum erro de SQL no log.
889:     *--------------------------------------------------------------------------
890:     PROTECTED FUNCTION CarregarImpressoras()
891:         LOCAL loc_lSucesso, loc_oErro
892:         loc_lSucesso = .F.
893: 
894:         TRY
895:             DO CASE
896:                 CASE TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
897:                     *-- Harness: sem conexao, sem SQL. cursor_4c_ImpreV nao eh
898:                     *-- criado, e this_nQtdImp fica em 0.
899:                     loc_lSucesso = .T.
900: 
901:                 CASE TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
902:                     loc_lSucesso = .T.

*-- Linhas 1093 a 1111:
1093:     * metade (Left 125 e 242, contra o combo em Left 122).
1094:     *
1095:     * Decisoes de transcricao detalhadas no cabecalho do arquivo (secao da
1096:     * Fase 5): ControlSource vazio e ZOrderSet descartados, AutoSize = .F.
1097:     * explicito nos rotulos, BackStyle da classe "say" reposto em lbl_4c_Label9,
1098:     * fonte da classe "fwget" reposta em txt_4c_Qtde, ForeColor no MEMBRO do
1099:     * OptionGroup e Buttons(1).Value nao escrito.
1100:     *
1101:     * TabIndex NAO eh atribuido aqui, e isso NAO eh esquecimento: com AddObject
1102:     * o VFP9 clampa TabIndex a quantidade de controles focalizaveis que ja
1103:     * existem no container, e depois desta fase sao 4 (btnReport, Opt_Impressora,
1104:     * Get_Printer, getQtde) contra os valores 2/3/7/9/8/10/10 que o SCX declara.
1105:     * Escrever ".TabIndex = 7" agora gravaria 4 - uma linha que mente sobre o
1106:     * valor efetivo. A numeracao inteira mora na fase que criar o ULTIMO
1107:     * AddObject do form, em ordem ASCENDENTE e so nos focalizaveis (Label e
1108:     * Container tem TabIndex mas nao tem TabStop: numera-los apenas embaralha a
1109:     * sequencia). Dentro do OptionGroup o caso eh outro e por isso o TabIndex
1110:     * DO MEMBRO eh transcrito: Buttons(1).TabIndex = 1 esta dentro da faixa
1111:     * 1..ButtonCount (que ja vale 1) e grava o valor exato do SCX.

*-- Linhas 1225 a 1279:
1225:             *-- Style = 2 (Dropdown List - o usuario escolhe, nao digita) e
1226:             *-- RowSourceType = 2 (Alias) transcritos do SCX. RowSourceType eh
1227:             *-- definido JA AQUI, antes do RowSource logo abaixo.
1228:             *-- "ControlSource = """ do dump nao eh transcrito (override vazio).
1229:             THIS.AddObject("cbo_4c_Get_Printer", "ComboBox")
1230:             WITH THIS.cbo_4c_Get_Printer
1231:                 .FontName          = "Tahoma"
1232:                 .FontSize          = 8
1233:                 .BoundColumn       = 1
1234:                 .RowSourceType     = 2
1235:                 .Height            = 23
1236:                 .Left              = 122
1237:                 .SpecialEffect     = 1
1238:                 .Style             = 2
1239:                 .Top               = 174
1240:                 .Width             = 240
1241:                 .DisabledBackColor = RGB(238, 238, 238)
1242:                 .DisabledForeColor = RGB(0, 0, 128)
1243:                 .BorderColor       = RGB(100, 100, 100)
1244:                 .BoundTo           = .F.
1245:             ENDWITH
1246: 
1247:             *-- Vinculo do combo ao cursor das impressoras, na MESMA ORDEM do
1248:             *-- Init legado:
1249:             *--     SELECT crImpreV
1250:             *--     GO top
1251:             *--     thisform.get_Printer.value     = RECNO('crImpreV')
1252:             *--     thisform.get_Printer.RowSource = 'crImpreV'
1253:             *--     thisform.get_Printer.Refresh
1254:             *-- O Value NUMERICO antes do RowSource eh deliberado e eh o que o
1255:             *-- legado faz: com BoundTo = .F. um Value numerico vale pelo
1256:             *-- ListIndex, ou seja "selecione a N-esima linha" - e N eh o
1257:             *-- registro em que o cursor esta posicionado.
1258:             *-- A guarda de USED() existe porque o cursor NAO existe em harness:
1259:             *-- CarregarImpressoras devolve .T. sem consultar quando
1260:             *-- gb_4c_ModoTeste/gb_4c_ValidandoUI estao ligados, e ligar
1261:             *-- RowSource a alias inexistente derruba o Init inteiro (regra #41),
1262:             *-- deixando CREATEOBJECT devolver .F. sem erro nenhum no log.
1263:             IF USED("cursor_4c_ImpreV")
1264:                 SELECT cursor_4c_ImpreV
1265:                 GO TOP
1266:                 THIS.cbo_4c_Get_Printer.Value     = RECNO("cursor_4c_ImpreV")
1267:                 THIS.cbo_4c_Get_Printer.RowSource = "cursor_4c_ImpreV"
1268:                 THIS.cbo_4c_Get_Printer.Refresh()
1269:             ENDIF
1270: 
1271:             *-- Say9 (SIGOPIBO.Say9) -> lbl_4c_Label9: rotulo da quantidade de
1272:             *-- vias. Classe "say" do framework.vcx, que eh TRANSPARENTE por
1273:             *-- heranca - o dump nao declara BackStyle porque nao precisa, mas
1274:             *-- aqui o controle eh um Label BASE, cujo default eh OPACO: sem
1275:             *-- .BackStyle = 0 o rotulo sairia com um retangulo pintado sobre o
1276:             *-- fundo do form. Repor o default da classe nao eh invencao.
1277:             *-- "ZOrderSet = 27" do dump nao eh transcrito (regra #33).
1278:             THIS.AddObject("lbl_4c_Label9", "Label")
1279:             WITH THIS.lbl_4c_Label9

*-- Linhas 1851 a 1869:
1851:                 IF FILE("BOLETO.txt")
1852:                     loc_cConteudo = FILETOSTR("BOLETO.txt")
1853:                     THIS.ExibirConteudoBoleto(loc_cConteudo)
1854:                     DELETE FILE "BOLETO.txt"
1855:                 ENDIF
1856:             ENDIF
1857:         CATCH TO loc_oErro
1858:             *-- Restaura a datasession tambem no caminho de falha: sair daqui
1859:             *-- na sessao do chamador deixaria o resto do form lendo cursores
1860:             *-- que nao sao dele
1861:             THIS.RestaurarDataSession(loc_nSessaoAnterior)
1862:             MsgErro(loc_oErro.Message + CHR(13) + ;
1863:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1864:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpIbo.BtnImprimirClick")
1865:         ENDTRY
1866:     ENDPROC
1867: 
1868:     *--------------------------------------------------------------------------
1869:     * BtnEncerrarClick - PROCEDURE Cmd_Sair.Click legado ("Thisform.Release").

*-- Linhas 1915 a 1933:
1915: 
1916:         TRY
1917:             IF USED("cursor_4c_ImpreV")
1918:                 SELECT cursor_4c_ImpreV
1919:                 IF !EOF("cursor_4c_ImpreV") AND !BOF("cursor_4c_ImpreV")
1920:                     THIS.this_oBusinessObject.this_cImpressoraSelecionada = ;
1921:                         cursor_4c_ImpreV.IDupla
1922:                 ENDIF
1923:             ENDIF
1924: 
1925:             *-- "llObs = IIF(lnTpbols=18, .chkCarne.Value, .chkObss.Value)":
1926:             *-- os DOIS valores vao para o BO e a escolha entre eles fica em
1927:             *-- ExecutarImpressao, com a mesma expressao do legado
1928:             THIS.this_oBusinessObject.this_lImprimirCarne = ;
1929:                 ConverterParaLogico(THIS.chk_4c_ChkCarne.Value)
1930: 
1931:             THIS.this_oBusinessObject.this_lImprimirObservacoes = ;
1932:                 ConverterParaLogico(THIS.chk_4c_ChkObss.Value)
1933: 


### BO (C:\4c\projeto\app\classes\SigOpIboBO.prg):
*==============================================================================
* SIGOPIBOBO.prg
*
* Business Object para SIGOPIBO (Impressao de Boleto / Protocolo / Duplicata-Carne)
*
* Este form NAO persiste dados em tabela propria - e um dialogo OPERACIONAL
* que recebe parametros do form chamador (tipo de boleto, empresa, operacao,
* numero da movimentacao, etc.), permite ao usuario escolher a impressora de
* boletos configurada na estacao e repassa tudo para a rotina legada de
* impressao (Do SigBlBol With ...).
*
* Tabela: (nenhuma - dialogo parametrizado, sem persistencia propria)
*
* Irmao direto de SigOpBolBO.prg (SIGOPBOL - "Selecao de Impressora de
* Boleto"), mesma familia de dialogo de impressao. Diferencas do legado
* (tasks\task746\SigOpIbo_form_codigo_fonte.txt) que as proximas fases
* precisam reproduzir:
*   - Tres checkboxes de OPCAO do proprio dialogo (chkCarne/chkObss/
*     chkAgrupa), que NAO sao parametro do chamador - sao o estado inicial
*     da tela (.T./.T./.F. no SCX) e a visibilidade de cada um depende do
*     tipo de boleto (vnTpBol). O legado SOBRESCREVE chkObss.Visible e
*     chkCarne.Visible duas vezes seguidas (TpBol=17 e depois TpBol=18)
*     sem IF entre as duas - so a ULTIMA atribuicao tem efeito observavel;
*     isso vale reproduzir tal como se comporta, nao como foi escrito.
*   - O Do Case do titulo tem DUAS opcoes que o irmao SigOpBolBO nao tem
*     (TpBol=16 "Impressao de Boleto de Vendas" e TpBol=18 "Impressao de
*     Duplicata/Carne").
*   - A escolha de impressora eh por COMBOBOX (Get_Printer, RowSource =
*     crImpreV, montado por UNION ALL de SigSyImp/SigCdAcG/SigCdmp cruzado
*     com APRINTERS) - o Opt_Impressora do SCX esta Visible = .F. e o bloco
*     que o preenchia esta todo comentado (*!*) no legado; nao reativar.
*   - Cmd_Imprimir.Click repassa DOIS parametros extras ao SigBlBol que o
*     SigOpBolBO nao tem: llObs (chkObss ou chkCarne, conforme TpBol=18) e
*     llAgrupa (chkAgrupa.Value).
*   - Ha um fallback de exibicao (Container1/Edit1) que mostra o conteudo de
*     BOLETO.txt quando o arquivo existe apos a chamada ao SigBlBol - efeito
*     colateral de UI, nao dado de negocio; fica para a fase do Form.
*
* poForm (referencia ao form chamador) e a checagem llSair (fChecaAcesso
*('SIGCHE','PROTSEMPRE') AND poForm.Op_Escolha = 'INSERIR', usada so no caso
* TpBol=1 para decidir se o botao Encerrar nasce habilitado) NAO entram neste
* BO - mesma decisao arquitetural de SigOpCtdBO.prg ("ONDE FICA O poForm"):
* guardar referencia ao form pai aqui fecharia um ciclo de referencias e essa
* checagem eh de UI (Enabled do botao), nao de dado. Fica no Form (fase 3+).
*
* Fase 1/8: APENAS propriedades e Init() basico, no mesmo padrao de
* SigOpBolBO.prg - Init() sem parametros, zera tudo, this_cTabela e
* this_cCampoChave vazios (nao ha tabela/chave propria). As proximas fases
* adicionam os metodos que reproduzem a logica REAL do Init/Cmd_Imprimir.Click
* do legado:
*   - DefinirTipoBoleto()               : guarda de tipo, igual ao irmao
*   - ObterTituloPorTipoBoleto()        : Do Case do titulo (com 16 e 18)
*   - DeveExibirImprimirCarne()/DeveExibirImprimirObservacoes()/
*     DeveExibirAgruparInformacoes()    : visibilidade dos 3 checkboxes
*   - CarregarImpressorasConfiguradas() : UNION ALL SigSyImp/SigCdAcG/SigCdmp
*     + cruzamento com APRINTERS (crImpre/crImp/crImpreV do legado)
*   - ExecutarImpressao()               : Do SigBlBol With ... (com llObs e
*     llAgrupa) - rotina legada
*
* SigBlBol e uma PROCEDURE global do Fortyus (sig.prg/SIGFUNCS.PRG) que NAO
* veio no acervo (sem .prg fonte, sem FRX - ver regra CLAUDE.md #27 "Funcao
* GLOBAL do legado"). Nao ha como reproduzir a impressao real (layout de
* boleto bancario) sem esse fonte. ExecutarImpressao() (fase futura) deve
* TRANSCREVER o "Do SigBlBol With ..." exatamente como o legado chama, dentro
* de TRY/CATCH que exibe a falha com MsgErro (regra #9, CATCH nunca
* silencioso) - a ausencia fica VISIVEL em vez de virar um stub que finge
* imprimir.
*==============================================================================

DEFINE CLASS SigOpIboBO AS BusinessBase

    *-- Propriedades da entidade (parametros recebidos do form chamador,
    *-- espelhando as properties customizadas do form legado SIGOPIBO)
    this_nTpBol = 0               && vnTpBol - Tipo de Boleto
    this_cTitEnvelope = ""        && vcTitEnvelope - Titulo do Envelope
    this_cEmp = ""                && vcEmp - Codigo da Empresa
    this_cDope = ""                && vcDope - Nome da Operacao de Estoque/Producao
    this_nNum = 0                 && vnNum - Numero da Movimentacao de Estoque/Producao
    this_nDev = 0                 && vnDev - Valor de Devolucao
    this_nVias = 0                && vnVias - Numero da Via
    this_nQBols = 0               && vnQBols - Quantidade de Boletos
    this_cCursor = ""             && vnCursor - Nome do Cursor/Tabela a Imprimir (apesar do "vn", eh CHAR)
    this_nQtdImp = 0              && Quantidade de Impressoras de Boleto Configuradas (lnCimp/RECCOUNT('crImpreV'))
    this_cImpressoraSelecionada = "" && Impressora escolhida no combo (Get_Printer / crImpreV.IDupla)

    *-- Opcoes do PROPRIO dialogo (chkCarne/chkObss/chkAgrupa) - NAO sao
    *-- parametro do chamador, sao o estado inicial da tela no SCX
    this_lImprimirCarne = .F.         && chkCarne.Value (SCX: .T.)
    this_lImprimirObservacoes = .F.   && chkObss.Value (SCX: .T.)
    this_lAgruparInformacoes = .F.    && chkAgrupa.Value (SCX: .F.)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()

        *-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
        *-- Dialogo parametrizado: nao ha tabela nem campo chave proprios
        THIS.this_cTabela = ""
        THIS.this_cCampoChave = ""

        THIS.this_nTpBol = 0
        THIS.this_cTitEnvelope = ""
        THIS.this_cEmp = ""
        THIS.this_cDope = ""
        THIS.this_nNum = 0
        THIS.this_nDev = 0
        THIS.this_nVias = 0
        THIS.this_nQBols = 0
        THIS.this_cCursor = ""
        THIS.this_nQtdImp = 0
        THIS.this_cImpressoraSelecionada = ""

        THIS.this_lImprimirCarne = .F.
        THIS.this_lImprimirObservacoes = .F.
        THIS.this_lAgruparInformacoes = .F.

        RETURN .T.
    ENDPROC

    *====================================================================
    * DefinirTipoBoleto - Recebe os parametros do form chamador e aplica
    * as mesmas guardas de tipo do Init() legado (Iif(Type(...)='C'/'N',
    * valor, default)). Equivalente ao bloco WITH Thisform do Init do
    * SIGOPIBO.SCX, sem o SQLEXEC/UI que ficam em outros metodos.
    *====================================================================
    PROCEDURE DefinirTipoBoleto(par_nTpBol, par_cTitEnvelope, par_cEmp, ;
            par_cDope, par_nNum, par_nDev, par_nVias, par_nQBols, par_cCursor)

        THIS.this_cTitEnvelope = IIF(VARTYPE(par_cTitEnvelope) = "C", par_cTitEnvelope, "")
        THIS.this_nTpBol = IIF(VARTYPE(par_nTpBol) = "N", par_nTpBol, 0)
        THIS.this_cEmp = IIF(VARTYPE(par_cEmp) = "C", par_cEmp, "")
        THIS.this_cDope = IIF(VARTYPE(par_cDope) = "C", par_cDope, "")
        THIS.this_nNum = IIF(VARTYPE(par_nNum) = "N", par_nNum, 0)
        THIS.this_nDev = IIF(VARTYPE(par_nDev) = "N", par_nDev, 0)
        THIS.this_nVias = IIF(VARTYPE(par_nVias) = "N" AND par_nVias > 0, par_nVias, 0)
        THIS.this_nQBols = IIF(VARTYPE(par_nQBols) = "N" AND par_nQBols > 0, par_nQBols, 1)
        THIS.this_cCursor = IIF(VARTYPE(par_cCursor) = "C", par_cCursor, "")

        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterTituloPorTipoBoleto - Do Case do titulo/Caption do Init legado.
    * Caso 1 (Protocolo de Cheque) usa o titulo recebido do chamador quando
    * fornecido (pcTitEnvelope), senao cai no titulo fixo - os demais casos
    * SEMPRE usam titulo fixo, mesmo que pcTitEnvelope tenha sido informado
    * (fiel ao Do Case do legado, que so olha pcTitEnvelope no Case 1).
    *====================================================================
    PROCEDURE ObterTituloPorTipoBoleto()
        LOCAL loc_cTitulo

        DO CASE
            CASE THIS.this_nTpBol = 1
                loc_cTitulo = IIF(!EMPTY(THIS.this_cTitEnvelope), THIS.this_cTitEnvelope, ;
                    "Impress" + CHR(227) + "o de Protocolo de Cheque")

            CASE INLIST(THIS.this_nTpBol, 2, 3, 4, 5, 7, 9)
                loc_cTitulo = "Impress" + CHR(227) + "o de Boleto"

            CASE THIS.this_nTpBol = 6
                loc_cTitulo = "Impress" + CHR(227) + "o de Protocolo de Cart" + CHR(227) + "o de Cr" + CHR(233) + "dito"

            CASE THIS.this_nTpBol = 8
                loc_cTitulo = "Impress" + CHR(227) + "o de Boleto de Conserto"

            CASE THIS.this_nTpBol = 12
                loc_cTitulo = "Impress" + CHR(227) + "o de Boleto de Ordem de Servi" + CHR(231) + "o"

            CASE THIS.this_nTpBol = 16
                loc_cTitulo = "Impress" + CHR(227) + "o de Boleto de Vendas"

            CASE THIS.this_nTpBol = 18
                loc_cTitulo = "Impress" + CHR(227) + "o de Duplicata/Carne"

            OTHERWISE
                loc_cTitulo = "Impress" + CHR(227) + "o de Boleto (*)"
        ENDCASE

        RETURN loc_cTitulo
    ENDPROC

    *====================================================================
    * DeveExibirImprimirObservacoes / DeveExibirImprimirCarne /
    * DeveExibirAgruparInformacoes - visibilidade dos tres checkboxes do
    * Init legado. chkObss.Visible e chkCarne.Visible sao atribuidos DUAS
    * vezes seguidas, sem IF entre as duas atribuicoes (ver comentario no
    * cabecalho deste arquivo) - so a ULTIMA atribuicao tem efeito:
    *   chkObss.Visible  = (TpBol=17) depois sobrescrito por !(TpBol=18)
    *   chkCarne.Visible = !(TpBol=17) depois sobrescrito por (TpBol=18)
    * Os metodos abaixo reproduzem o resultado final observavel, nao a
    * sequencia intermediaria (que nunca chega a ser visivel na tela).
    *====================================================================
    PROCEDURE DeveExibirImprimirObservacoes()
        RETURN (THIS.this_nTpBol != 18)
    ENDPROC

    PROCEDURE DeveExibirImprimirCarne()
        RETURN (THIS.this_nTpBol = 18)
    ENDPROC

    PROCEDURE DeveExibirAgruparInformacoes()
        RETURN (THIS.this_nTpBol = 3)
    ENDPROC

    *====================================================================
    * CarregarImpressorasConfiguradas - Reproduz o bloco do Init legado que
    * monta crImpreV (ComboBox Get_Printer):
    *   1. SigSyImp+SigCdmp (acesso direto) UNION ALL SigCdAcG+SigSyImp+
    *      SigCdmp (acesso por grupo), filtrado pelo usuario logado
    *      (Usuar no legado -> gc_4c_UsuarioLogado aqui, regra #PUBLICvars).
    *   2. SELECT DISTINCT das impressoras de boleto configuradas.
    *   3. APRINTERS() para as impressoras do Windows na estacao.
    *   4. Cruzamento fuzzy (LIKE dos dois lados) entre as impressoras de
    *      boleto configuradas e as impressoras do Windows, e ORDER BY 1.
    * Preenche this_nQtdImp (lnCimp/RECCOUNT('crImpreV') do legado) e
    * this_cImpressoraSelecionada com o 1o registro (GO TOP), equivalente
    * ao "thisform.get_Printer.value = RECNO('crImpreV')" + BoundColumn=1
    * do legado (a 1a coluna do RowSource, IDupla, eh o Value do combo).
    *
    * Se nenhuma impressora de boleto estiver configurada para o usuario,
    * crSigCdmp nunca eh criado no legado e a consulta seguinte (crSigCdmp
    * JOIN crImpre) estouraria "Alias nao encontrado" - aqui, em vez de
    * reproduzir essa falha latente, cria-se cursor_4c_SigCdmp vazio com a
    * mesma estrutura para o cruzamento seguir e resultar em zero linhas
    * (mesmo efeito pratico do legado: nenhuma impressora disponivel).
    *====================================================================
    PROCEDURE CarregarImpressorasConfiguradas()
        LOCAL loc_cSQL, loc_nResultado, loc_nPrinters, loc_nI, loc_aPrinters

        IF USED("cursor_4c_TmpCimp")
            USE IN cursor_4c_TmpCimp
        ENDIF
        IF USED("cursor_4c_SigCdmp")
            USE IN cursor_4c_SigCdmp
        ENDIF
        IF USED("cursor_4c_Impre")
            USE IN cursor_4c_Impre
        ENDIF
        IF USED("cursor_4c_Imp")
            USE IN cursor_4c_Imp
        ENDIF
        IF USED("cursor_4c_ImpreV")
            USE IN cursor_4c_ImpreV
        ENDIF

        loc_cSQL = "SELECT b.* FROM SigSyImp a, SigCdmp b " + ;
                   "WHERE a.UsuAcess = " + EscaparSQL(gc_4c_UsuarioLogado) + " AND a.Cimps = b.Impres " + ;
                   "UNION ALL " + ;
                   "SELECT c.* FROM SigCdAcG a, SigSyImp b, SigCdmp c " + ;
                   "WHERE a.Usuarios = " + EscaparSQL(gc_4c_UsuarioLogado) + " AND a.Grupos = b.GrAcess AND b.Cimps = c.Impres"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCimp")
        IF loc_nResultado < 0
            MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + "o com Servidor de Banco de Dados.", "Erro")
            RETURN .F.
        ENDIF

        IF RECCOUNT("cursor_4c_TmpCimp") > 0
            SELECT DISTINCT Impres, nTpImpres, TpBarra, MaxCols ;
                FROM cursor_4c_TmpCimp ;
                ORDER BY Impres ;
                INTO CURSOR cursor_4c_SigCdmp
        ELSE
            CREATE CURSOR cursor_4c_SigCdmp (Impres C(50), nTpImpres N(1,0), TpBarra N(1,0), MaxCols N(3,0))
        ENDIF

        loc_nPrinters = APRINTERS(loc_aPrinters)
        CREATE CURSOR cursor_4c_Impre (impres C(50))
        IF loc_nPrinters != 0
            FOR loc_nI = 1 TO loc_nPrinters
                INSERT INTO cursor_4c_Impre (impres) VALUES (UPPER(loc_aPrinters[loc_nI, 1]))
            ENDFOR
        ENDIF

        SELECT PADR(ALLTRIM(a.Impres), 15) + " " + ALLTRIM(b.impres) AS IDupla, b.impres, a.impres AS impresS ;
            FROM cursor_4c_SigCdmp a, cursor_4c_Impre b ;
            WHERE (ALLTRIM(UPPER(b.impres)) LIKE "%" + ALLTRIM(UPPER(a.impres)) + "%" OR ;
                   ALLTRIM(UPPER(a.impres)) LIKE "%" + ALLTRIM(UPPER(b.impres)) + "%") ;
            GROUP BY b.impres, a.impres ;
            INTO CURSOR cursor_4c_Imp READWRITE

        SELECT * FROM cursor_4c_Imp ORDER BY 1 INTO CURSOR cursor_4c_ImpreV

        THIS.this_nQtdImp = RECCOUNT("cursor_4c_ImpreV")

        IF THIS.this_nQtdImp > 0
            SELECT cursor_4c_ImpreV
            GO TOP
            THIS.this_cImpressoraSelecionada = cursor_4c_ImpreV.IDupla
        ELSE
            THIS.this_cImpressoraSelecionada = ""
        ENDIF

        RETURN .T.
    ENDPROC

    *====================================================================
    * ExecutarImpressao - Transcreve o Do SigBlBol With ... do
    * Cmd_Imprimir.Click legado. SigBlBol e uma PROCEDURE global do
    * Fortyus (sig.prg/SIGFUNCS.PRG) que NAO veio no acervo (regra
    * CLAUDE.md #27) - nao ha fonte para reproduzir o layout real do
    * boleto bancario. A chamada fica dentro de TRY/CATCH que exibe a
    * falha com MsgErro (regra #9, CATCH nunca silencioso): a ausencia
    * fica VISIVEL ao usuario em vez de um stub que finge imprimir.
    *
    * llObs (11o parametro) segue a mesma expressao do legado:
    * IIF(vnTpBol=18, chkCarne.Value, chkObss.Value) - o 18o caso usa o
    * checkbox de carne no lugar do de observacoes.
    *====================================================================
    PROCEDURE ExecutarImpressao()
        LOCAL loc_lSucesso, loc_oErro, loc_lObs, loc_lAgrupa

        loc_lSucesso = .F.
        loc_lObs = IIF(THIS.this_nTpBol = 18, THIS.this_lImprimirCarne, THIS.this_lImprimirObservacoes)
        loc_lAgrupa = THIS.this_lAgruparInformacoes

        TRY
            DO SigBlBol WITH THIS.this_nTpBol, THIS.this_cTitEnvelope, THIS.this_cEmp, ;
                THIS.this_cDope, THIS.this_nNum, THIS.this_nDev, THIS.this_nVias, ;
                THIS.this_nQBols, THIS.this_cImpressoraSelecionada, THIS.this_cCursor, ;
                loc_lObs, loc_lAgrupa
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel executar a impress" + CHR(227) + "o do boleto:" + CHR(13) + ;
                loc_oErro.Message, "Erro ao Imprimir")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Este BO nao sobrescreve CarregarDoCursor()/Inserir()/Atualizar()/
    * ExecutarExclusao()/ObterChavePrimaria(): o dialogo nao tem tabela nem
    * chave primaria propria (ver cabecalho deste arquivo) - o comportamento
    * padrao herdado de BusinessBase ja eh o correto para este caso.
    *--------------------------------------------------------------------------

ENDDEFINE

