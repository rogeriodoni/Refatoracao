# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EMPDOPNUMS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NOPS, NENVS, EMPDNPS, GLOBALIZAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'MA' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NOPS, NENVS, EMPDNPS, GLOBALIZAS

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
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  Column6.ControlSource = ""
  Column7.ControlSource = ""
	Select DbProduto
		Select crSigOpPic
			lcQuery = [Select Top 1 Nops, Nenvs, CodPds, Grupods, Contads ] + ;
					    [From SigPdMvf ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigPdMvf') < 1)
			Select crSigPdMvf
			Select DbProduto
			lcQuery = [Select Top 1 EmpDNps ] + ;
					    [From SigPdMvf ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTopMfas') < 1)
			Select crTopMfas
				lcQuery = [Select Nenvs, Nops, CodPds, Grupods, Contads, Emps, Dopps, Numps ] + ;
						    [From SigPdMvf ] + ;
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigPdMvf') < 1)
				Select crSigPdMvf
					Select crSigOpPic
						Select DbProduto
			Select crSigOpPic
				lcQuery = [Select Top 1 Nops, Nenvs, CodPds, Grupods, Contads ] + ;
						    [From SigPdMvf ] + ;
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigPdMvf') < 1)
				Select crSigPdMvf
				Select DbProduto
		lcQuery = [Select Dopes, NDopes, Globalizas, Reservas ] + ;
					[From SigCdOpe ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpOper') < 1)
		Select TmpOper
			.Column1.ControlSource     = 'dbProduto.Nenvs'
			.Column2.ControlSource     = 'dbProduto.Nops'
			.Column3.ControlSource     = 'dbProduto.DopNums'
			.Column4.ControlSource     = 'dbProduto.Cpros'
			.Column5.ControlSource     = 'dbProduto.Qtds'
			.Column6.ControlSource     = 'dbProduto.Grupods'
			.Column7.ControlSource     = 'dbProduto.Contads'
	If Not Seek(This.Value, 'TmpOper', 'Dopes')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpCgr.prg) - TRECHOS RELEVANTES PARA PASS SQL (1804 linhas total):

*-- Linhas 101 a 142:
101: *     Grd_Produto / .RecordSource = 'dbProduto' / .ColumnCount = 7 / ..."
102: *     do PROCEDURE Init legado. Vira FONTE UNICA do bind da grade
103: *     (ConfigurarPaginaDados e CarregarLista chamam o MESMO metodo), para
104: *     os dois call sites nao divergirem em silencio. ControlSource,
105: *     Header1.Caption e Width sao reaplicados DEPOIS do RecordSource
106: *     (regra CLAUDE.md #41/#48 - RecordSource reseta Width e Caption).
107: *
108: *   CarregarLista() - repintura da grade de resultado: GO TOP no cursor +
109: *     Grid.Refresh (regra CLAUDE.md #21 - popular cursor NAO repinta a
110: *     grade), rebind SO quando o alias ligado ao Grid nao for mais o
111: *     cursor de resultado. Chamado em TODO caminho que popula ou exibe o
112: *     resultado: BtnProcessarClick, AlternarPagina(2) DEPOIS do ActivePage
113: *     (regra #21/Erro192 - Refresh em pagina OCULTA nao pinta) e
114: *     LimparCampos.
115: *
116: *   FormParaBO() / BOParaForm() - transferencia dos 4 campos de filtro
117: *     (Op / Envelope / Pedido+Numero) entre a tela e o BO, nos dois
118: *     sentidos. Antes estava embutida em BtnProcessarClick; extraida
119: *     aqui, BOParaForm passa a ser tambem quem sincroniza os 3 CheckBoxes
120: *     de cnt_4c_ModoRastro (o "With This.Parent.Parent.pag_resultado.
121: *     Container1" do fim do cmdprocessar.Click legado) e as flags
122: *     this_lRastroPor* que BtnRastreabClick consulta.
123: *
124: *   LimparCampos() - o "With .fld_principal.pag_consulta.Origem.Pedido /
125: *     .get_Env.Value = 0 / .get_Op.Value = 0 / .get_Numero.Value = 0 /
126: *     .get_Pedido.Value = Space(20) / EndWith" + ".ConsultaExecutada =
127: *     .f." do PROCEDURE Init legado, mais o "Select DbProduto / Zap" do
128: *     PROCEDURE processa. Passa a ser chamado no fim de InicializarForm,
129: *     que antes nao reproduzia esse trecho do Init.
130: *
131: *   HabilitarCampos(par_lHabilitar) - materializa os When dos 4 campos de
132: *     filtro ("preencher APENAS um dos tres": Op OU Envelope OU
133: *     Pedido+Numero). DESVIO CONSCIENTE do mecanismo legado, registrado:
134: *     o When eh EVENTO, nao propriedade, e nao se atribui a controle
135: *     criado por AddObject; ligado por BINDEVENT ele ate dispara, mas o
136: *     BINDEVENT DESCARTA o retorno do delegate, entao GetOpWhenCheck e
137: *     irmaos (Fase 6) avaliam o guard e nao bloqueiam nada. O equivalente
138: *     que funciona sem subclasse nova eh .Enabled: o usuario continua
139: *     impedido de preencher os outros dois grupos e o foco continua
140: *     pulando os campos bloqueados, com a unica diferenca de que o campo
141: *     bloqueado aparece esmaecido. Os BINDEVENT "When" da Fase 6 ficam no
142: *     lugar (documentam o guard do legado e sao inofensivos), mas quem

*-- Linhas 256 a 322:
256: 
257:     *==========================================================================
258:     * InicializarCursorResultado - Cria o cursor placeholder de resultado
259:     * (equivalente ao "Create Cursor dbProduto(...) / Index On Nops Tag Nops"
260:     * do PROCEDURE Load legado). Estrutura IDENTICA a que a Fase 7/8 vai
261:     * popular via SQLEXEC/APPEND FROM DBF, para o Grid poder ser configurado
262:     * (RecordSource/ControlSource) nesta mesma fase sem a tela quebrar.
263:     *==========================================================================
264:     PROTECTED PROCEDURE InicializarCursorResultado()
265:         LOCAL loc_cCursor
266:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorResultado
267: 
268:         IF !USED(loc_cCursor)
269:             SET NULL ON
270:             CREATE CURSOR (loc_cCursor) ;
271:                 (Nenvs N(10), Nops N(10), DopNums C(26), Cpros C(14), ;
272:                  Qtds N(12,3), Grupods C(10), Contads C(10))
273:             SET NULL OFF
274:             INDEX ON Nops TAG Nops
275:         ENDIF
276:     ENDPROC
277: 
278:     *==========================================================================
279:     * InicializarForm - Chamado por FormBase.Init via DODEFAULT
280:     *==========================================================================
281:     PROTECTED PROCEDURE InicializarForm()
282:         LOCAL loc_lSucesso, loc_oErro
283:         loc_lSucesso = .F.
284: 
285:         *-- A guarda de conexao fica FORA do TRY (mesmo padrao de
286:         *-- Formsigopcgc.prg): o harness de teste automatizado define
287:         *-- gnConnHandle = 0 de proposito, e a guarda precisa devolver
288:         *-- antes de qualquer SQLEXEC/CREATEOBJECT que dependa de conexao.
289:         IF !THIS.ValidarParametros()
290:             RETURN .F.
291:         ENDIF
292: 
293:         TRY
294:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpCgrBO")
295: 
296:             *-- cursor_4c_Operacoes (equivalente a TmpOper do Init legado) -
297:             *-- precisa estar carregado ANTES de ConfigurarPaginaLista, pois
298:             *-- o lookup do campo Pedido (Fase 6) faz SEEK nele. Falha aqui
299:             *-- aborta a abertura do form, igual ao legado ("Favor
300:             *-- Reinicializar o Processo!!!" + Return .f. no Init).
301:             IF THIS.this_oBusinessObject.CarregarOperacoes()
302: 
303:                 *-- Cursor placeholder de cursor_4c_Resultado ANTES do
304:                 *-- PageFrame: a Page2 liga Grid.RecordSource a este alias
305:                 *-- na mesma fase (regra CLAUDE.md #41 - Column.ControlSource
306:                 *-- de cursor inexistente derruba o Init). A estrutura e
307:                 *-- IDENTICA ao Create Cursor dbProduto do Load() legado.
308:                 THIS.InicializarCursorResultado()
309: 
310:                 THIS.ConfigurarPageFrame()
311:                 THIS.ConfigurarPaginaLista()
312:                 THIS.ConfigurarPaginaDados()
313:                 THIS.TornarControlesVisiveis(THIS)
314: 
315:                 THIS.pgf_4c_Paginas.Visible    = .T.
316:                 THIS.pgf_4c_Paginas.ActivePage = 1
317: 
318:                 *-- Estado inicial do Init legado (valores dos 4 filtros +
319:                 *-- ConsultaExecutada = .f.), consolidado em LimparCampos na
320:                 *-- Fase 8 - inclui o guard dos When (HabilitarCampos) e a
321:                 *-- primeira repintura da grade vazia.
322:                 THIS.LimparCampos()

*-- Linhas 894 a 989:
894:         BINDEVENT(loc_oPag.cnt_4c_ModoRastro.chk_4c_Envelope, "Click", THIS, "ChkEnvelopeClick")
895:         BINDEVENT(loc_oPag.cnt_4c_ModoRastro.chk_4c_Pedido,   "Click", THIS, "ChkPedidoClick")
896: 
897:         *-- Grd_Produto do legado - grade de resultado. ControlSource/
898:         *-- Header1.Caption/Width TRANSCRITOS do PROCEDURE Init legado (que
899:         *-- SOBRESCREVE os headers do dump estatico do SCX - regra "a pagina
900:         *-- segue o Init legado, nao o SCX desenhado"), nao do dump da
901:         *-- SECAO 2 (que tem Column6/7 com Header1.Caption = "Header1").
902:         loc_oPag.AddObject("grd_4c_Dados", "Grid")
903:         WITH loc_oPag.grd_4c_Dados
904:             .Top           = 219
905:             .Left          = 35
906:             .Width         = 729
907:             .Height        = 400
908:             .FontName      = "Tahoma"
909:             .FontSize      = 8
910:             .ReadOnly      = .T.
911:             .DeleteMark    = .F.
912:             .RecordMark    = .F.
913:             .RowHeight     = 17
914:             .ScrollBars    = 2
915:             .GridLineColor = RGB(238, 238, 238)
916:         ENDWITH
917: 
918:         *-- ColumnCount/RecordSource/ControlSource/Width/Header1.Caption
919:         *-- ficam em VincularGradeResultado (Fase 8) - FONTE UNICA do bind,
920:         *-- compartilhada com CarregarLista.
921:         THIS.VincularGradeResultado()
922: 
923:         BINDEVENT(loc_oPag.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
924:     ENDPROC
925: 
926:     *==========================================================================
927:     * VincularGradeResultado - Liga grd_4c_Dados ao cursor de resultado.
928:     * Transcrito do "With .Fld_Principal.Pag_Resultado.Grd_Produto" do
929:     * PROCEDURE Init legado (que SOBRESCREVE os headers do dump estatico do
930:     * SCX - a pagina segue o Init legado, nao o SCX desenhado: por isso
931:     * Column6/Column7 recebem "Fase"/"Conta" e nao o "Header1" do dump).
932:     *
933:     * ORDEM OBRIGATORIA (regra CLAUDE.md #41/#48): ColumnCount ->
934:     * RecordSource -> ControlSource -> Width -> Header1.Caption. Atribuir
935:     * RecordSource RECALCULA as larguras para o default 90 e zera os
936:     * captions, entao Width/Caption tem de vir DEPOIS - em TODO site que
937:     * re-vincula a grade, e nao so na montagem inicial.
938:     *
939:     * PUBLIC de proposito (regra CLAUDE.md #1/#51 - o harness da etapa 06b
940:     * chama metodos do form de FORA da classe).
941:     *==========================================================================
942:     PROCEDURE VincularGradeResultado()
943:         LOCAL loc_oGrid, loc_cCursor, loc_lSucesso, loc_oErro
944: 
945:         loc_lSucesso = .F.
946:         loc_cCursor  = THIS.this_oBusinessObject.this_cCursorResultado
947: 
948:         *-- Column.ControlSource de cursor INEXISTENTE derruba o Init
949:         *-- (regra CLAUDE.md #41) - o placeholder tem de existir antes.
950:         IF !USED(loc_cCursor)
951:             THIS.InicializarCursorResultado()
952:         ENDIF
953: 
954:         loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados
955: 
956:         TRY
957:             *-- ColumnCount so eh reatribuido quando DIVERGE de 7: qualquer
958:             *-- atribuicao recria os objetos Column (regra CLAUDE.md #144) e
959:             *-- aqui nao ha motivo para pagar esse custo a cada repintura.
960:             IF loc_oGrid.ColumnCount != 7
961:                 loc_oGrid.ColumnCount = 7
962:             ENDIF
963: 
964:             loc_oGrid.RecordSource = loc_cCursor
965: 
966:             loc_oGrid.Column1.ControlSource = loc_cCursor + ".Nenvs"
967:             loc_oGrid.Column2.ControlSource = loc_cCursor + ".Nops"
968:             loc_oGrid.Column3.ControlSource = loc_cCursor + ".DopNums"
969:             loc_oGrid.Column4.ControlSource = loc_cCursor + ".Cpros"
970:             loc_oGrid.Column5.ControlSource = loc_cCursor + ".Qtds"
971:             loc_oGrid.Column6.ControlSource = loc_cCursor + ".Grupods"
972:             loc_oGrid.Column7.ControlSource = loc_cCursor + ".Contads"
973: 
974:             *-- Width e Header1.Caption DEPOIS do RecordSource/ControlSource
975:             WITH loc_oGrid.Column1
976:                 .FontSize          = 8
977:                 .Movable           = .F.
978:                 .Resizable         = .F.
979:                 .Width             = 68
980:                 .Header1.Caption   = "Envelope"
981:                 .Header1.Alignment = 2
982:                 .Header1.FontSize  = 8
983:                 .Text1.FontSize    = 8
984:             ENDWITH
985: 
986:             WITH loc_oGrid.Column2
987:                 .FontSize          = 8
988:                 .Movable           = .F.
989:                 .Resizable         = .F.

*-- Linhas 1499 a 1517:
1499:                 THIS.VincularGradeResultado()
1500:             ENDIF
1501: 
1502:             SELECT (loc_cCursor)
1503:             GO TOP
1504: 
1505:             loc_oGrid.Refresh()
1506:             loc_lSucesso = .T.
1507:         CATCH TO loc_oErro
1508:             MsgErro(loc_oErro.Message + CHR(13) + ;
1509:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1510:                     "Procedure: " + loc_oErro.Procedure, ;
1511:                     "Erro ao Carregar a Lista de Resultado")
1512:         ENDTRY
1513: 
1514:         *-- A linha corrente mudou (GO TOP) - reposiciona as properties
1515:         *-- this_nSel*/this_cSel* do BO e reavalia o Enabled do Rastreab.
1516:         IF USED(loc_cCursor)
1517:             THIS.this_oBusinessObject.CarregarDoCursor(loc_cCursor)

*-- Linhas 1630 a 1648:
1630:     *                       .get_Numero.Value = 0 /
1631:     *                       .get_Pedido.Value = Space(20) / EndWith"
1632:     *                      e ".ConsultaExecutada = .f."
1633:     *   PROCEDURE processa -> "*-[ Limpa os Arquivos ]-* / Select DbProduto /
1634:     *                       Zap" (o resultado anterior some junto com os
1635:     *                       criterios que o produziram).
1636:     * Fecha reaplicando o guard dos When (HabilitarCampos), repintando a
1637:     * grade vazia (CarregarLista) e reavaliando os botoes.
1638:     *
1639:     * PROTECTED EXPLICITO pelo mesmo motivo de FormParaBO: o escopo vem da
1640:     * HERANCA (FormBase declara PROTECTED PROCEDURE LimparCampos) e nao da
1641:     * ausencia do modificador aqui. Quem precisa de um ponto de entrada
1642:     * PUBLICO para zerar a tela usa THIS.AjustarBotoesPorModo /
1643:     * THIS.CarregarLista, que nao existem em FormBase e sao publicos de
1644:     * verdade.
1645:     *==========================================================================
1646:     PROTECTED PROCEDURE LimparCampos()
1647:         LOCAL loc_oPg, loc_cCursor, loc_oErro
1648: 

*-- Linhas 1663 a 1684:
1663:                 .this_cMensagemErroOp     = ""
1664:             ENDWITH
1665: 
1666:             *-- "Select DbProduto / Zap" do processa legado
1667:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorResultado
1668:             IF USED(loc_cCursor)
1669:                 SELECT (loc_cCursor)
1670:                 ZAP
1671:             ENDIF
1672:         CATCH TO loc_oErro
1673:             MsgErro(loc_oErro.Message + CHR(13) + ;
1674:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1675:                     "Procedure: " + loc_oErro.Procedure, ;
1676:                     "Erro ao Limpar os Campos")
1677:         ENDTRY
1678: 
1679:         *-- BOParaForm zera tambem os 3 CheckBoxes de modo e as flags
1680:         *-- this_lRastroPor* (todos os criterios estao vazios agora).
1681:         THIS.BOParaForm()
1682:         THIS.HabilitarCampos(.T.)
1683:         THIS.CarregarLista()
1684:         THIS.AjustarBotoesPorModo()


### BO (C:\4c\projeto\app\classes\SigOpCgrBO.prg):
*------------------------------------------------------------------------------
* SigOpCgrBO - Business Object para FormSigOpCgr
* Dialogo operacional de "Pesquisa Global de Rastreabilidade": o usuario
* informa UM dos tres criterios (N. Op, Envelope ou Pedido/Numero), o BO
* monta a lista de produtos envolvidos naquele lote (tabela SigPdMvf,
* cruzada com a picagem de SigOpPic e a lista de operacoes de SigCdOpe) e
* o form exibe o resultado numa grade. A partir de uma linha do resultado,
* o usuario abre o relatorio SigReCgr (rastreabilidade) filtrado por
* Op/Envelope/Pedido, conforme o modo marcado.
* Migrado de: SIGOPCGR (Framework Fortyus)
*
* Este dialogo nao possui tabela propria persistida (nao ha Inserir/
* Atualizar/Excluir no legado - e so consulta). A tabela "principal" para
* efeito de this_cTabela/this_cCampoChave e SigPdMvf, que e a fonte real
* do resultado (equivalente a dbProduto no legado); SigCdOpe e SigOpPic
* sao consultadas apenas como apoio (lista de operacoes e picagem).
*------------------------------------------------------------------------------
DEFINE CLASS SigOpCgrBO AS BusinessBase

    *-- Criterios de pesquisa (equivalentes aos Get_Op/Get_Env/Get_Pedido/
    *-- Get_Numero do dump legado - o usuario preenche APENAS um dos tres
    *-- grupos: Op, OU Envelope, OU Pedido+Numero)
    this_nOps    = 0
    this_nEnvs   = 0
    this_cPedido = ""
    this_nNumero = 0

    *-- Estado de controle (equivalente a ThisForm.ConsultaExecutada) -
    *-- evita reprocessar a mesma consulta enquanto nenhum criterio mudou
    this_lConsultaExecutada = .F.

    *-- Modo de rastreabilidade escolhido na pagina de resultado
    *-- (equivalente aos Chk_op/chk_Env/Chk_Dop do Container1 do legado -
    *-- define qual chave o Bot_Rastro.Click usa para abrir SigReCgr)
    this_lRastroPorOp      = .F.
    this_lRastroPorEnvelop = .F.
    this_lRastroPorPedido  = .F.

    *-- Linha corrente do resultado (equivalente ao registro atual de
    *-- dbProduto - usado pelo Bot_Rastro.Click e pelas colunas da grade)
    this_nSelNenvs   = 0
    this_nSelNops    = 0
    this_cSelDopNums = ""
    this_cSelCpros   = ""
    this_nSelQtds    = 0
    this_cSelGrupods = ""
    this_cSelContads = ""

    *-- Nomes dos cursores que este BO consome/popula (propriedade para o
    *-- Form referenciar sem repetir literais - padrao sigopagrBO/SigMvSbnBO)
    this_cCursorOperacoes = "cursor_4c_Operacoes" && equivalente a TmpOper (SigCdOpe) - lista de operacoes para o lookup do Pedido
    this_cCursorPicagem   = "cursor_4c_Picagem"   && equivalente a crSigOpPic (SigOpPic) - picagem por Op/Envelope/EmpDopNums
    this_cCursorMovimento = "cursor_4c_Movimento" && equivalente a crSigPdMvf (SigPdMvf) - lote/producao por Op ou por EmpDNps
    this_cCursorTopo      = "cursor_4c_Topo"      && equivalente a crTopMfas (SigPdMvf) - top 1 EmpDNps por envelope
    this_cCursorResultado = "cursor_4c_Resultado" && equivalente a dbProduto - grade de resultado exibida na pagina 2

    *-- Mensagem de erro do ultimo ValidarOperacao() (equivalente aos dois
    *-- MessageBox do Get_Op.Valid legado: "Op Nao Cadastrada!!!" / "Op de
    *-- Outra Empresa!!!") - o Form le esta property para exibir o MsgAviso.
    this_cMensagemErroOp = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigPdMvf"
        THIS.this_cCampoChave = "Nops"
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega os dados da linha CORRENTE do cursor de
    * resultado (equivalente ao registro atual de dbProduto no legado) para
    * as properties this_nSel*/this_cSel*. E chamado pelo form ao posicionar
    * o grid de resultado (AfterRowColChange da grade) e antes de
    * Bot_Rastro.Click, que precisa da linha selecionada para montar a
    * chave (Nops/Nenvs/DopNums) usada ao abrir SigReCgr.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        IF USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_nSelNenvs   = TratarNulo(Nenvs, 0)
            THIS.this_nSelNops    = TratarNulo(Nops, 0)
            THIS.this_cSelDopNums = TratarNulo(DopNums, "")
            THIS.this_cSelCpros   = TratarNulo(Cpros, "")
            THIS.this_nSelQtds    = TratarNulo(Qtds, 0)
            THIS.this_cSelGrupods = TratarNulo(Grupods, "")
            THIS.this_cSelContads = TratarNulo(Contads, "")

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOperacoes - Popula this_cCursorOperacoes (equivalente a TmpOper
    * do PROCEDURE Init legado: Select Dopes, NDopes, Globalizas, Reservas
    * From SigCdOpe Where Globalizas In (1, 2), Index On Dopes Tag Dopes).
    * Usado pelo lookup do campo Pedido (Fase 6): SEEK contra o cursor local
    * + picker FormBuscaAuxiliar.DefinirCursor/Mostrar (Pattern A - regra
    * "FormBuscaAuxiliar Pattern B broken") sobre este MESMO cursor, sem
    * nova consulta SQL - igual ao fwBuscaSel legado, que tambem trabalha
    * em cima do cursor ja carregado.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarOperacoes()
        LOCAL loc_cCursor, loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.
        loc_cCursor  = THIS.this_cCursorOperacoes

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF

        *-- Modo teste/validacao de UI: sem conexao real de SQL Server -
        *-- SQLEXEC com handle invalido DISPARA excecao (nao devolve -1),
        *-- entao criar o cursor vazio com a MESMA estrutura do TmpOper
        *-- legado, para o SEEK do lookup de Pedido nao estourar "Alias
        *-- CURSOR_4C_OPERACOES is not found".
        IF (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
           (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
            CREATE CURSOR (loc_cCursor) ;
                (Dopes C(20), NDopes N(4, 0), Globalizas N(1, 0), Reservas N(1, 0))
            INDEX ON Dopes TAG Dopes
            RETURN .T.
        ENDIF

        loc_cSQL = "SELECT Dopes, NDopes, Globalizas, Reservas " + ;
                   "FROM SigCdOpe WHERE Globalizas IN (1, 2)"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

        IF loc_nResultado >= 0 AND USED(loc_cCursor)
            SELECT (loc_cCursor)
            INDEX ON Dopes TAG Dopes
            GO TOP
            loc_lSucesso = .T.
        ELSE
            MostrarErro("Favor Reinicializar o Processo!!!", ;
                "Falha na Conex" + CHR(227) + "o (" + loc_cCursor + ")")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarOperacao - Confere se a Op existe em SigOpPic e pertence a
    * empresa corrente (equivalente ao Get_Op.Valid legado: CursorQuery +
    * Eof('crSigOpPic') + crSigOpPic.Emps <> _Empr). Preenche
    * this_cMensagemErroOp quando invalido, para o Form exibir o MsgAviso.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarOperacao(par_nOps)
        LOCAL loc_cCursor, loc_cSQL, loc_nResultado, loc_lValido

        loc_lValido = .F.
        THIS.this_cMensagemErroOp = ""
        loc_cCursor = "cursor_4c_ValOp"

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF

        loc_cSQL = "SELECT TOP 1 Emps FROM SigOpPic WHERE Nops = " + ;
                   FormatarNumeroSQL(par_nOps, 0)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

        IF loc_nResultado > 0 AND USED(loc_cCursor) AND !EOF(loc_cCursor)
            SELECT (loc_cCursor)
            IF ALLTRIM(Emps) == ALLTRIM(go_4c_Sistema.cCodEmpresa)
                loc_lValido = .T.
            ELSE
                THIS.this_cMensagemErroOp = "Op de Outra Empresa!!!"
            ENDIF
        ELSE
            THIS.this_cMensagemErroOp = "Op N" + CHR(227) + "o Cadastrada!!!"
        ENDIF

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * Processar - equivalente ao PROCEDURE processa do legado: monta o
    * resultado da pesquisa (this_cCursorResultado) a partir de QUAL dos
    * tres criterios foi preenchido (Op, Envelope ou Pedido+Numero). O
    * guard "If Not Thisform.ConsultaExecutada" do legado fica aqui dentro
    * (nao reprocessa enquanto nenhum criterio mudou - os handlers de
    * LostFocus dos filtros resetam this_lConsultaExecutada no Form).
    *--------------------------------------------------------------------------
    PROCEDURE Processar()
        LOCAL loc_cCursorResultado, loc_lSucesso

        loc_lSucesso          = .T.
        loc_cCursorResultado  = THIS.this_cCursorResultado

        IF !THIS.this_lConsultaExecutada
            *-[ Limpa os Arquivos ]-* (equivalente a "Select DbProduto / Zap")
            IF USED(loc_cCursorResultado)
                SELECT (loc_cCursorResultado)
                ZAP
            ENDIF

            DO CASE
                CASE THIS.this_nOps != 0
                    loc_lSucesso = THIS.ProcessarPorOp()
                CASE THIS.this_nEnvs > 0
                    loc_lSucesso = THIS.ProcessarPorEnvelope()
                OTHERWISE
                    loc_lSucesso = THIS.ProcessarPorPedido()
            ENDCASE

            IF loc_lSucesso
                THIS.this_lConsultaExecutada = .T.
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarPorOp - ramo "If (lnOp <> 0)" do legado: pesquisa a picagem
    * (SigOpPic) da Op informada e, para cada linha, busca o topo de
    * producao (SigPdMvf) correspondente.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ProcessarPorOp()
        LOCAL loc_cCursorPic, loc_cSQL, loc_nResultado, loc_lSucesso
        LOCAL loc_aDopes[1], loc_aNumes[1], loc_aQtds[1], loc_nTotal, loc_nI

        loc_lSucesso   = .T.
        loc_cCursorPic = THIS.this_cCursorPicagem

        IF USED(loc_cCursorPic)
            USE IN (loc_cCursorPic)
        ENDIF

        loc_cSQL = "SELECT Dopes, Numes, Qtds FROM SigOpPic WHERE Nops = " + ;
                   FormatarNumeroSQL(THIS.this_nOps, 0)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorPic)

        IF loc_nResultado < 0
            MostrarErro("Favor Reinicializar o Processo!!!", ;
                "Falha na Conex" + CHR(227) + "o (crSigOpPic)")
            RETURN .F.
        ENDIF

        *-- Snapshot em array ANTES de fechar o cursor: BuscarTopoPorOp faz
        *-- SQLEXEC/SELECT proprios, e um SCAN direto neste cursor perderia
        *-- a posicao corrente quando a funcao chamada troca de workarea.
        loc_nTotal = 0
        IF USED(loc_cCursorPic)
            loc_nTotal = RECCOUNT(loc_cCursorPic)
        ENDIF

        IF loc_nTotal > 0
            DIMENSION loc_aDopes[loc_nTotal]
            DIMENSION loc_aNumes[loc_nTotal]
            DIMENSION loc_aQtds[loc_nTotal]

            SELECT (loc_cCursorPic)
            GO TOP
            FOR loc_nI = 1 TO loc_nTotal
                loc_aDopes[loc_nI] = Dopes
                loc_aNumes[loc_nI] = Numes
                loc_aQtds[loc_nI]  = Qtds
                SKIP
            ENDFOR
        ENDIF

        IF USED(loc_cCursorPic)
            USE IN (loc_cCursorPic)
        ENDIF

        FOR loc_nI = 1 TO loc_nTotal
            IF !THIS.BuscarTopoPorOp(THIS.this_nOps, loc_aDopes[loc_nI], ;
                    loc_aNumes[loc_nI], loc_aQtds[loc_nI], "1")
                loc_lSucesso = .F.
                EXIT
            ENDIF
        ENDFOR

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarPorEnvelope - ramo "If (lnEnv > 0)" do legado: acha o topo
    * de EmpDNps do envelope informado, pesquisa TODAS as linhas de
    * SigPdMvf daquele EmpDNps e, para cada uma, busca a picagem (SigOpPic)
    * da Op correspondente.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ProcessarPorEnvelope()
        LOCAL loc_cCursorTopo, loc_cSQL, loc_nResultado, loc_cChave, loc_lSucesso
        LOCAL loc_cCursorMvf, loc_nTotal, loc_nI
        LOCAL loc_aNops[1], loc_aNenvs[1], loc_aCodPds[1], loc_aGrupods[1], loc_aContads[1]

        loc_lSucesso    = .T.
        loc_cCursorTopo = THIS.this_cCursorTopo

        IF USED(loc_cCursorTopo)
            USE IN (loc_cCursorTopo)
        ENDIF

        loc_cSQL = "SELECT TOP 1 EmpDNps FROM SigPdMvf " + ;
                   "WHERE Nenvs = " + FormatarNumeroSQL(THIS.this_nEnvs, 0) + " " + ;
                   "ORDER BY Nenvs DESC, EmpDNps DESC"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTopo)

        IF loc_nResultado < 0
            MostrarErro("Favor Reinicializar o Processo!!!", ;
                "Falha na Conex" + CHR(227) + "o (crTopMfas)")
            RETURN .F.
        ENDIF

        *-- legado: "If Not Eof()" - sem registro, nao eh erro, simplesmente
        *-- nao ha nada para acrescentar ao resultado.
        IF !USED(loc_cCursorTopo) OR EOF(loc_cCursorTopo)
            IF USED(loc_cCursorTopo)
                USE IN (loc_cCursorTopo)
            ENDIF
            RETURN .T.
        ENDIF

        SELECT (loc_cCursorTopo)
        GO TOP
        loc_cChave = EmpDNps
        USE IN (loc_cCursorTopo)

        loc_cCursorMvf = THIS.this_cCursorMovimento
        IF USED(loc_cCursorMvf)
            USE IN (loc_cCursorMvf)
        ENDIF

        loc_cSQL = "SELECT Nenvs, Nops, CodPds, Grupods, Contads, Emps, Dopps, Numps " + ;
                   "FROM SigPdMvf WHERE EmpDNps = " + EscaparSQL(loc_cChave) + " " + ;
                   "ORDER BY Nenvs, Nops, CodPds, Grupods, Contads, Emps, Dopps, Numps"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorMvf)

        IF loc_nResultado < 0
            MostrarErro("Favor Reinicializar o Processo!!!", ;
                "Falha na Conex" + CHR(227) + "o (crSigPdMvf 2)")
            RETURN .F.
        ENDIF

        loc_nTotal = 0
        IF USED(loc_cCursorMvf)
            loc_nTotal = RECCOUNT(loc_cCursorMvf)
        ENDIF

        IF loc_nTotal > 0
            DIMENSION loc_aNops[loc_nTotal]
            DIMENSION loc_aNenvs[loc_nTotal]
            DIMENSION loc_aCodPds[loc_nTotal]
            DIMENSION loc_aGrupods[loc_nTotal]
            DIMENSION loc_aContads[loc_nTotal]

            SELECT (loc_cCursorMvf)
            GO TOP
            FOR loc_nI = 1 TO loc_nTotal
                loc_aNops[loc_nI]    = Nops
                loc_aNenvs[loc_nI]   = Nenvs
                loc_aCodPds[loc_nI]  = CodPds
                loc_aGrupods[loc_nI] = Grupods
                loc_aContads[loc_nI] = Contads
                SKIP
            ENDFOR
        ENDIF

        IF USED(loc_cCursorMvf)
            USE IN (loc_cCursorMvf)
        ENDIF

        FOR loc_nI = 1 TO loc_nTotal
            IF !THIS.AppendPicagemPorOp(loc_aNops[loc_nI], loc_aNenvs[loc_nI], ;
                    loc_aCodPds[loc_nI], loc_aGrupods[loc_nI], loc_aContads[loc_nI])
                loc_lSucesso = .F.
                EXIT
            ENDIF
        ENDFOR

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarPorPedido - ramo "Else" (nem Op nem Envelope) do legado:
    * monta a chave posicional EmpDopNums (Emps(3)+Dopes(20)+Numero(6) =
    * 29 = SigOpPic.EmpDopNums char(29) - regra CLAUDE.md #42) e pesquisa
    * a picagem direto por ela.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ProcessarPorPedido()
        LOCAL loc_cEDN, loc_cCursorPic, loc_cSQL, loc_nResultado, loc_lSucesso
        LOCAL loc_aNops[1], loc_aDopes[1], loc_aNumes[1], loc_aQtds[1], loc_nTotal, loc_nI

        loc_lSucesso = .T.

        *-- Chave POSICIONAL - PADR explicito nas DUAS partes de largura
        *-- fixa (nunca ALLTRIM, regra CLAUDE.md #42), independente do
        *-- padding que txt_4c_Pedido.Value tenha trazido.
        loc_cEDN = PADR(ALLTRIM(go_4c_Sistema.cCodEmpresa), 3) + ;
                   PADR(THIS.this_cPedido, 20) + ;
                   STR(THIS.this_nNumero, 6)

        loc_cCursorPic = THIS.this_cCursorPicagem
        IF USED(loc_cCursorPic)
            USE IN (loc_cCursorPic)
        ENDIF

        loc_cSQL = "SELECT Nops, Dopes, Numes, Qtds FROM SigOpPic " + ;
                   "WHERE EmpDopNums = " + EscaparSQL(loc_cEDN)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorPic)

        IF loc_nResultado < 0
            MostrarErro("Favor Reinicializar o Processo!!!", ;
                "Falha na Conex" + CHR(227) + "o (crSigOpPic)")
            RETURN .F.
        ENDIF

        loc_nTotal = 0
        IF USED(loc_cCursorPic)
            loc_nTotal = RECCOUNT(loc_cCursorPic)
        ENDIF

        IF loc_nTotal > 0
            DIMENSION loc_aNops[loc_nTotal]
            DIMENSION loc_aDopes[loc_nTotal]
            DIMENSION loc_aNumes[loc_nTotal]
            DIMENSION loc_aQtds[loc_nTotal]

            SELECT (loc_cCursorPic)
            GO TOP
            FOR loc_nI = 1 TO loc_nTotal
                loc_aNops[loc_nI]  = Nops
                loc_aDopes[loc_nI] = Dopes
                loc_aNumes[loc_nI] = Numes
                loc_aQtds[loc_nI]  = Qtds
                SKIP
            ENDFOR
        ENDIF

        IF USED(loc_cCursorPic)
            USE IN (loc_cCursorPic)
        ENDIF

        FOR loc_nI = 1 TO loc_nTotal
            IF !THIS.BuscarTopoPorOp(loc_aNops[loc_nI], loc_aDopes[loc_nI], ;
                    loc_aNumes[loc_nI], loc_aQtds[loc_nI], "3")
                loc_lSucesso = .F.
                EXIT
            ENDIF
        ENDFOR

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarTopoPorOp - equivalente ao "Select Top 1 Nops, Nenvs, CodPds,
    * Grupods, Contads From SigPdMvf Where Nops = ... Order By ... Desc"
    * repetido nos ramos Op e Pedido do legado. par_cContexto reproduz o
    * numero do MessageBox de falha original (crSigPdMvf 1 / 3).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION BuscarTopoPorOp(par_nOps, par_cDopes, par_nNumes, par_nQtds, par_cContexto)
        LOCAL loc_cCursorMvf, loc_cSQL, loc_nResultado
        LOCAL loc_nNenvs, loc_cCodPds, loc_cGrupods, loc_cContads

        loc_cCursorMvf = THIS.this_cCursorMovimento

        IF USED(loc_cCursorMvf)
            USE IN (loc_cCursorMvf)
        ENDIF

        loc_cSQL = "SELECT TOP 1 Nops, Nenvs, CodPds, Grupods, Contads " + ;
                   "FROM SigPdMvf " + ;
                   "WHERE Nops = " + FormatarNumeroSQL(par_nOps, 0) + " " + ;
                   "ORDER BY Nops DESC, Nenvs DESC, CodPds DESC, Grupods DESC, Contads DESC"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorMvf)

        IF loc_nResultado < 0 OR !USED(loc_cCursorMvf) OR EOF(loc_cCursorMvf)
            MostrarErro("Favor Reinicializar o Processo!!!", ;
                "Falha na Conex" + CHR(227) + "o (crSigPdMvf " + par_cContexto + ")")
            IF USED(loc_cCursorMvf)
                USE IN (loc_cCursorMvf)
            ENDIF
            RETURN .F.
        ENDIF

        SELECT (loc_cCursorMvf)
        GO TOP
        loc_nNenvs   = Nenvs
        loc_cCodPds  = CodPds
        loc_cGrupods = Grupods
        loc_cContads = Contads

        USE IN (loc_cCursorMvf)

        THIS.AppendResultado(loc_nNenvs, par_nOps, ;
            par_cDopes + STR(par_nNumes, 6), loc_cCodPds, par_nQtds, loc_cGrupods, loc_cContads)

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * AppendPicagemPorOp - equivalente ao bloco interno do ramo Envelope do
    * legado: "ThisForm.poDataMgr.CursorQuery('SigOpPic', ..., 'Nops', ...)
    * / Scan / Append Blank" - pesquisa a picagem da Op da linha de
    * SigPdMvf corrente e acrescenta UMA linha de resultado por cada linha
    * de picagem encontrada.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION AppendPicagemPorOp(par_nNops, par_nNenvs, par_cCodPds, par_cGrupods, par_cContads)
        LOCAL loc_cCursorPic, loc_cSQL, loc_nResultado
        LOCAL loc_aDopes[1], loc_aNumes[1], loc_aQtds[1], loc_nTotal, loc_nI

        loc_cCursorPic = THIS.this_cCursorPicagem

        IF USED(loc_cCursorPic)
            USE IN (loc_cCursorPic)
        ENDIF

        loc_cSQL = "SELECT Dopes, Numes, Qtds FROM SigOpPic WHERE Nops = " + ;
                   FormatarNumeroSQL(par_nNops, 0)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorPic)

        IF loc_nResultado < 0
            IF USED(loc_cCursorPic)
                USE IN (loc_cCursorPic)
            ENDIF
            RETURN .F.
        ENDIF

        loc_nTotal = 0
        IF USED(loc_cCursorPic)
            loc_nTotal = RECCOUNT(loc_cCursorPic)
        ENDIF

        IF loc_nTotal > 0
            DIMENSION loc_aDopes[loc_nTotal]
            DIMENSION loc_aNumes[loc_nTotal]
            DIMENSION loc_aQtds[loc_nTotal]

            SELECT (loc_cCursorPic)
            GO TOP
            FOR loc_nI = 1 TO loc_nTotal
                loc_aDopes[loc_nI] = Dopes
                loc_aNumes[loc_nI] = Numes
                loc_aQtds[loc_nI]  = Qtds
                SKIP
            ENDFOR
        ENDIF

        IF USED(loc_cCursorPic)
            USE IN (loc_cCursorPic)
        ENDIF

        FOR loc_nI = 1 TO loc_nTotal
            THIS.AppendResultado(par_nNenvs, par_nNops, ;
                loc_aDopes[loc_nI] + STR(loc_aNumes[loc_nI], 6), ;
                par_cCodPds, loc_aQtds[loc_nI], par_cGrupods, par_cContads)
        ENDFOR

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * AppendResultado - equivalente a "Select DbProduto / Append Blank /
    * Replace ..." do legado. Unico ponto de escrita em
    * this_cCursorResultado, usado pelos tres ramos de Processar().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AppendResultado(par_nNenvs, par_nNops, par_cDopNums, par_cCpros, par_nQtds, par_cGrupods, par_cContads)
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_cCursorResultado

        IF !USED(loc_cCursor)
            RETURN
        ENDIF

        SELECT (loc_cCursor)
        APPEND BLANK
        REPLACE Nenvs   WITH TratarNulo(par_nNenvs, 0), ;
                Nops    WITH TratarNulo(par_nNops, 0), ;
                DopNums WITH TratarNulo(par_cDopNums, ""), ;
                Cpros   WITH TratarNulo(par_cCpros, ""), ;
                Qtds    WITH TratarNulo(par_nQtds, 0), ;
                Grupods WITH TratarNulo(par_cGrupods, ""), ;
                Contads WITH TratarNulo(par_cContads, "")
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave que identifica a linha corrente do
    * resultado (nao existe PK de tabela gravavel neste dialogo - ver
    * decisao de projeto abaixo). Usa Nops, o mesmo campo definido como
    * this_cCampoChave no Init, igual ao padrao dos demais BOs.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nSelNops)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Decisao de projeto: BO somente-leitura (sem Inserir/Atualizar/Excluir)
    *--------------------------------------------------------------------------
    * O SIGOPCGR legado e um dialogo de PESQUISA (Pesquisa Global de
    * Rastreabilidade): o unico Create Cursor do Init e dbProduto, que e
    * um cursor LOCAL (nunca gravado no SQL Server), e todo Insert
    * Into/Replace do codigo fonte original tem como alvo esse mesmo
    * cursor local. Nao ha TableUpdate nem AddCursor contra tabela remota
    * em lugar nenhum do dump - as unicas chamadas SqlExecute/CursorQuery
    * do Processa()/Init() sao SELECTs de leitura (SigPdMvf, SigOpPic,
    * SigCdOpe). Por isso este BO nao sobrescreve Inserir(), Atualizar()
    * nem ExecutarExclusao(): o comportamento padrao herdado de
    * BusinessBase (recusar a operacao) ja eh o correto para uma tela que
    * so consulta. CarregarDoCursor() acima e o unico ponto de leitura de
    * linha que este BO precisa, pois alimenta a selecao usada por
    * Bot_Rastro.Click; RegistrarAuditoria() herdado de BusinessBase
    * tambem nao e chamado, porque nao ha Inserir/Atualizar/Excluir que o
    * dispare.
    *--------------------------------------------------------------------------

ENDDEFINE

