# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RECORDSOURCE' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: OPERS, PROGRAMAS

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
lcSqlLog = [Select '          'As cOpers,a.* From SigOpLog a Where ]
ThisForm.poDatamgr.SqlExecute(lcSqlLog+lcWhere,"crSigOpLog")
Select crSigOpLog
ThisForm.PgfPagina.PgResultado.GrdLog.Column1.ControlSource = 'crSigOpLog.Usuaredes'
ThisForm.PgfPagina.PgResultado.GrdLog.Column2.ControlSource = 'crSigOpLog.Datars'
ThisForm.PgfPagina.PgResultado.GrdLog.Column3.ControlSource = 'crSigOpLog.Horas'
ThisForm.PgfPagina.PgResultado.GrdLog.Column4.ControlSource = 'crSigOpLog.Progs'
ThisForm.PgfPagina.PgResultado.GrdLog.Column5.ControlSource = 'crSigOpLog.cOpers'
ThisForm.PgfPagina.PgResultado.GrdLog.Column6.ControlSource = 'crSigOpLog.Usuasis'
ThisForm.PgfPagina.PgResultado.GrdLog.Column7.ControlSource = 'crSigOpLog.Parametros'
ThisForm.PgfPagina.PgResultado.fwget1.ControlSource = 'crSigOpLog.Transacaos'
	ThisForm.PoDatamgr.SqlExecute([Select Distinct Programas From SigCdPrg Order By Programas],"crSigCdPrg")
	SELECT crSigCdPrg

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopclg.prg) - TRECHOS RELEVANTES PARA PASS SQL (2023 linhas total):

*-- Linhas 50 a 69:
50: * Grade grd_4c_Dados (Page2), ligada a this_oBusinessObject.this_cCursorLog
51: * via VincularGradeLog() - FONTE UNICA do bind (regra CLAUDE.md #41/#48),
52: * com cursor placeholder criado por InicializarCursorLog() ANTES do Grid
53: * ser configurado (regra #41 - Column.ControlSource de cursor inexistente
54: * derruba o Init). ControlSource/Width/Header1.Caption das 7 colunas
55: * transcritos do PROCEDURE processamento legado (que SOBRESCREVE os
56: * headers do dump estatico do SCX - regra "a pagina segue o Init/metodo
57: * legado, nao o dump"): Usuario Rede/Data/Hora/Programa/Operacao (ligada a
58: * cOpers, a descricao calculada, nao a Opers crua)/Usuario Sistema/
59: * Parametro. Geometria do Grid (Top=197/Left=63/Width=656/Height=307) =
60: * valores do dump + compensacao +29 do PageFrame.Top=-29 (regra #1/#11) -
61: * sem rescala horizontal, pois a faixa de botoes Left=917 nao alcanca essa
62: * altura (Top>=197). AlternarPagina(par_nPagina) tambem entra nesta fase,
63: * com o guard que o legado tem no proprio fluxo (Processamento so chega em
64: * "ActivePage = 2" quando a consulta devolve linha - "If Eof() Then
65: * Return" - aqui expresso contra this_oBusinessObject.this_nQtdeLog, que
66: * ja existe desde a Fase 1/2) e o toggle de Page2.Enabled (btnDados.Click
67: * legado faz Enabled=.f. antes de voltar para a Pagina 1).
68: *
69: * O BINDEVENT dos botoes e da grade (Click/AfterRowColChange) ficou para a

*-- Linhas 93 a 111:
93: * txt_4c_Param (Parametros) e txt_4c_Trans (Transacao) + os labels
94: * Say7/Say8/Say9/Say10 do legado; na Page2, txt_4c_Fwget1 (Transacao do
95: * registro corrente, Enabled=.F. no dump) + o Say10 homonimo dela
96: * (FontBold=.T.), com o ControlSource ligado dentro de VincularGradeLog()
97: * para acompanhar a grade - igual ao bloco final do PROCEDURE
98: * processamento legado, que liga grade e fwget1 juntos.
99: *
100: * Lookups COMPLETOS nesta fase, cada um com a API que corresponde ao
101: * browse do legado:
102: *   - Programa (GetPrg.Valid -> fwBuscaInt, browse sobre cursor LOCAL):
103: *     sigopclgBO.BuscarProgramas() popula cursor_4c_Programas, LOCATE
104: *     tenta o match e, falhando, FormBuscaAuxiliar recebe o cursor ja
105: *     populado via DefinirCursor() - reduzido a UMA coluna, porque
106: *     SigCdPrg.Programas eh codigo E descricao (familia de SigCdOpe).
107: *   - Usuario do Sistema (GetUserSis.Valid -> fwBuscaExt, consulta o SQL
108: *     Server): FormBuscaAuxiliar com Init por parametros (1o argumento =
109: *     gnConnHandle, regra CLAUDE.md #36) + guarda this_lAchouRegistro
110: *     antes do Show e this_lSelecionou antes de atribuir (regra #37).
111: * Os dois vao em "LostFocus" (o legado valida no Valid, ao SAIR do campo),

*-- Linhas 138 a 159:
138: *     de Selecao foi Preenchido"; 64 = MsgInfo para "Nenhum Registro
139: *     Encontrado para Selecao"), o bind/unbind da grade e a troca de pagina.
140: *   - BO (Fase 1/2): a validacao de "nenhum filtro", o WHERE dinamico e o
141: *     SQLEXEC em cursor_4c_Log (sigopclgBO.BuscarLog()).
142: * DesvincularGradeLog transcreve a 1a linha do processamento legado
143: * ("GrdLog.RecordSource = ''") e nao eh cosmetica: BuscarLog() faz USE IN +
144: * SQLEXEC sobre o MESMO alias, e SQLEXEC sobre alias ligado a Grid ZERA o
145: * ColumnCount. A ordem do caminho de sucesso eh desvincular -> consultar ->
146: * VincularGradeLog -> AlternarPagina(2) -> RepintarGradeLog, porque Refresh
147: * em pagina OCULTA nao pinta (regra CLAUDE.md #21).
148: * Nesta fase tambem entra o AfterRowColChange da grade
149: * (GrdDadosAfterRowColChange = "fwget1.Refresh" do legado + sincronizacao
150: * do registro corrente do BO via CarregarDoCursor), porque a grade e o
151: * campo txt_4c_Fwget1 ja existem e sem ele a Transacao exibida ficaria
152: * presa na primeira linha; e o "PgResultado.Enabled=.f." do Init legado,
153: * que eh o estado inicial do toggle que BtnVoltarClick/AlternarPagina usam.
154: *
155: * FASE 8/8: CarregarLog, BOParaForm e LimparCampos.
156: *
157: * CarregarLog eh o FUNIL unico de carga da grade - o corpo do "PROCEDURE
158: * processamento" legado, que na Fase 7 estava inline no BtnProcessarClick.
159: * O Click do botao ficou com o que o Click legado de fato tem (a

*-- Linhas 278 a 306:
278:         *-- A guarda de conexao fica FORA do TRY (mesmo padrao de
279:         *-- FormSigOpCgr.prg): o harness de teste automatizado define
280:         *-- gnConnHandle = 0 de proposito, e a guarda precisa devolver
281:         *-- antes de qualquer SQLEXEC/CREATEOBJECT que dependa de conexao.
282:         IF !THIS.ValidarParametros()
283:             RETURN .F.
284:         ENDIF
285: 
286:         TRY
287:             THIS.this_oBusinessObject = CREATEOBJECT("sigopclgBO")
288: 
289:             *-- Cursor placeholder de cursor_4c_Log ANTES do PageFrame: a
290:             *-- Page2 liga Grid.RecordSource a este alias na mesma fase
291:             *-- (regra CLAUDE.md #41 - Column.ControlSource de cursor
292:             *-- inexistente derruba o Init).
293:             THIS.InicializarCursorLog()
294: 
295:             THIS.ConfigurarPageFrame()
296:             THIS.ConfigurarPaginaLista()
297:             THIS.ConfigurarPaginaDados()
298:             THIS.TornarControlesVisiveis(THIS)
299: 
300:             THIS.pgf_4c_Paginas.Visible    = .T.
301: 
302:             *-- ".PgfPagina.PgResultado.Enabled=.f." do Init legado: a pagina
303:             *-- de resultado nasce DESLIGADA e so eh habilitada quando a
304:             *-- consulta devolve linha (BtnProcessarClick -> AlternarPagina(2),
305:             *-- Fase 7/8). Sem este estado inicial o toggle de AlternarPagina
306:             *-- comecaria invertido - BtnVoltarClick desliga a Page2, logo

*-- Linhas 326 a 357:
326: 
327:     *==========================================================================
328:     * InicializarCursorLog - Cria o cursor placeholder do resultado da
329:     * pesquisa (equivalente a estrutura do "Select '          ' As cOpers,
330:     * a.* From SigOpLog a" do PROCEDURE processamento legado). Mesma
331:     * estrutura que THIS.this_oBusinessObject.BuscarLog() popula via
332:     * SQLEXEC - existe so para o Grid poder ser configurado
333:     * (RecordSource/ControlSource) nesta fase sem a tela quebrar; o
334:     * SQLEXEC de BuscarLog() fecha e recria este alias do zero (Fase 7/8).
335:     *==========================================================================
336:     PROTECTED PROCEDURE InicializarCursorLog()
337:         LOCAL loc_cCursor
338:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorLog
339: 
340:         IF !USED(loc_cCursor)
341:             SET NULL ON
342:             CREATE CURSOR (loc_cCursor) ;
343:                 (cOpers C(10), UsuaRedes C(20), Datars T, Horas C(8), ;
344:                  Progs C(20), Opers C(1), Usuasis C(20), Parametros C(10), ;
345:                  Transacaos C(100), CVersaos C(70), cidchaves C(20), Copias C(1))
346:             SET NULL OFF
347:         ENDIF
348:     ENDPROC
349: 
350:     *==========================================================================
351:     * ConfigurarPageFrame - Constroi o PageFrame com 2 paginas
352:     * (Dados/Resultado, espelhando PgDados/pgResultado do legado)
353:     *==========================================================================
354:     PROTECTED PROCEDURE ConfigurarPageFrame()
355:         LOCAL loc_oPgf
356: 
357:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")

*-- Linhas 844 a 862:
844:         *-- GetTrans do legado - Transacao (this_cTrans no BO; filtro
845:         *-- "Transacaos Like 'valor%'"). MaxLength = 150 transcrito do dump:
846:         *-- a coluna filtrada eh SigOpLog.transacaos char(100), mas aqui o
847:         *-- campo eh FILTRO (nenhum INSERT passa por ele), entao a folga do
848:         *-- legado nao trunca gravacao nenhuma - mexer nela mudaria UX
849:         *-- (PILAR 1) sem corrigir defeito.
850:         loc_oPag.AddObject("txt_4c_Trans", "TextBox")
851:         WITH loc_oPag.txt_4c_Trans
852:             .Top       = 413
853:             .Left      = 189
854:             .Width     = 527
855:             .Height    = 23
856:             .FontName  = "Tahoma"
857:             .FontSize  = 8
858:             .Alignment = 3
859:             .MaxLength = 150
860:             .Value     = ""
861:             .TabIndex  = 10
862:         ENDWITH

*-- Linhas 1015 a 1045:
1015:         *-- GrdLog do legado - grade de resultado. Geometria = dump + 29
1016:         *-- (compensacao PageFrame.Top=-29, regra CLAUDE.md #1/#11); sem
1017:         *-- rescala horizontal (a barra de botoes Left=917 nao alcanca
1018:         *-- Top=197+). ControlSource/Header1.Caption/Width ficam em
1019:         *-- VincularGradeLog (Fase 8 do dialogo) - FONTE UNICA do bind,
1020:         *-- compartilhada com a repintura apos a consulta (Fase 7/8).
1021:         loc_oPag.AddObject("grd_4c_Dados", "Grid")
1022:         WITH loc_oPag.grd_4c_Dados
1023:             .Top           = 197
1024:             .Left          = 63
1025:             .Width         = 656
1026:             .Height        = 307
1027:             .FontName      = "Tahoma"
1028:             .FontSize      = 8
1029:             .ReadOnly      = .T.
1030:             .DeleteMark    = .F.
1031:             .RecordMark    = .F.
1032:             .RowHeight     = 17
1033:             .ScrollBars    = 2
1034:             .GridLineColor = RGB(238, 238, 238)
1035:         ENDWITH
1036: 
1037:         *-- Say10 da pgResultado - "Transacao :" (Left=62/Top=482 no dump;
1038:         *-- FontBold = .T. aqui, ao contrario do Say10 homonimo da pagina de
1039:         *-- filtros). Criado ANTES do campo para o TextBox desenhar por cima
1040:         *-- (regra CLAUDE.md #23).
1041:         loc_oPag.AddObject("lbl_4c_Label10", "Label")
1042:         WITH loc_oPag.lbl_4c_Label10
1043:             .Top       = 511
1044:             .Left      = 62
1045:             .Width     = 62

*-- Linhas 1056 a 1074:
1056: 
1057:         *-- fwget1 do legado - Transacao do registro corrente da grade.
1058:         *-- Enabled = .F. no dump: o campo eh somente EXIBICAO (o conteudo
1059:         *-- vem do cursor via ControlSource, ligado em VincularGradeLog -
1060:         *-- FONTE UNICA do bind, igual ao bloco final do PROCEDURE
1061:         *-- processamento legado, que liga a grade e o fwget1 juntos).
1062:         *-- DisabledBackColor transcrito do dump para o texto desabilitado
1063:         *-- continuar legivel sobre branco.
1064:         loc_oPag.AddObject("txt_4c_Fwget1", "TextBox")
1065:         WITH loc_oPag.txt_4c_Fwget1
1066:             .Top               = 508
1067:             .Left              = 140
1068:             .Width             = 578
1069:             .Height            = 23
1070:             .FontName          = "Tahoma"
1071:             .FontSize          = 8
1072:             .Alignment         = 3
1073:             .MaxLength         = 150
1074:             .Value             = ""

*-- Linhas 1108 a 1165:
1108:     * descricao calculada - e nao a Opers crua).
1109:     *
1110:     * ORDEM OBRIGATORIA (regra CLAUDE.md #41/#48): ColumnCount ->
1111:     * RecordSource -> ControlSource -> Width -> Header1.Caption, porque
1112:     * atribuir RecordSource RECALCULA as larguras para o default 90 e
1113:     * zera os captions - vale em TODO site que re-vincula a grade (a
1114:     * repintura da Fase 7/8 chama este MESMO metodo, nao duplica o bind).
1115:     *
1116:     * PUBLIC de proposito (regra CLAUDE.md #1/#51 - o harness da etapa 06b
1117:     * chama metodos do form de FORA da classe).
1118:     *==========================================================================
1119:     PROCEDURE VincularGradeLog()
1120:         LOCAL loc_oGrid, loc_cCursor, loc_lSucesso, loc_oErro
1121: 
1122:         loc_lSucesso = .F.
1123:         loc_cCursor  = THIS.this_oBusinessObject.this_cCursorLog
1124: 
1125:         *-- Column.ControlSource de cursor INEXISTENTE derruba o Init
1126:         *-- (regra CLAUDE.md #41) - o placeholder tem de existir antes.
1127:         IF !USED(loc_cCursor)
1128:             THIS.InicializarCursorLog()
1129:         ENDIF
1130: 
1131:         loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados
1132: 
1133:         TRY
1134:             *-- ColumnCount so eh reatribuido quando DIVERGE de 7: qualquer
1135:             *-- atribuicao recria os objetos Column (regra CLAUDE.md #144).
1136:             IF loc_oGrid.ColumnCount != 7
1137:                 loc_oGrid.ColumnCount = 7
1138:             ENDIF
1139: 
1140:             loc_oGrid.RecordSource = loc_cCursor
1141: 
1142:             loc_oGrid.Column1.ControlSource = loc_cCursor + ".UsuaRedes"
1143:             loc_oGrid.Column2.ControlSource = loc_cCursor + ".Datars"
1144:             loc_oGrid.Column3.ControlSource = loc_cCursor + ".Horas"
1145:             loc_oGrid.Column4.ControlSource = loc_cCursor + ".Progs"
1146:             loc_oGrid.Column5.ControlSource = loc_cCursor + ".cOpers"
1147:             loc_oGrid.Column6.ControlSource = loc_cCursor + ".Usuasis"
1148:             loc_oGrid.Column7.ControlSource = loc_cCursor + ".Parametros"
1149: 
1150:             *-- Width e Header1.Caption DEPOIS do RecordSource/ControlSource
1151:             WITH loc_oGrid.Column1
1152:                 .Width             = 130
1153:                 .Movable           = .F.
1154:                 .Resizable         = .F.
1155:                 .Header1.Caption   = "Usuario Rede"
1156:                 .Header1.Alignment = 2
1157:                 .Header1.ForeColor = RGB(36, 84, 155)
1158:             ENDWITH
1159: 
1160:             WITH loc_oGrid.Column2
1161:                 .Width             = 65
1162:                 .Movable           = .F.
1163:                 .Resizable         = .F.
1164:                 .Header1.Caption   = "Data"
1165:                 .Header1.Alignment = 2

*-- Linhas 1213 a 1237:
1213: 
1214:             *-- fwget1 - Transacao do registro corrente. O legado liga este
1215:             *-- campo no MESMO bloco da grade ("ThisForm.PgfPagina.
1216:             *-- PgResultado.fwget1.ControlSource = 'crSigOpLog.Transacaos'"),
1217:             *-- e por isso ele entra aqui: o SQLEXEC de BuscarLog() fecha e
1218:             *-- recria o alias, derrubando TODO bind que aponte para ele.
1219:             *-- PEMSTATUS porque VincularGradeLog tambem roda durante o
1220:             *-- ConfigurarPaginaDados, que cria o campo logo antes.
1221:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Fwget1", 5)
1222:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Fwget1.ControlSource = ;
1223:                     loc_cCursor + ".Transacaos"
1224:             ENDIF
1225: 
1226:             loc_lSucesso = .T.
1227:         CATCH TO loc_oErro
1228:             MsgErro(loc_oErro.Message + CHR(13) + ;
1229:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1230:                     "Procedure: " + loc_oErro.Procedure, ;
1231:                     "Erro ao Vincular a Grade do Log")
1232:         ENDTRY
1233: 
1234:         RETURN loc_lSucesso
1235:     ENDPROC
1236: 
1237:     *==========================================================================

*-- Linhas 1385 a 1426:
1385:     * resultado ANTES da consulta. Transcricao da PRIMEIRA linha do PROCEDURE
1386:     * processamento legado ("GrdLog.RecordSource = ''").
1387:     *
1388:     * Nao eh cosmetico: BuscarLog() faz USE IN + SQLEXEC sobre o MESMO alias,
1389:     * e SQLEXEC sobre o alias ligado a um Grid ZERA o ColumnCount - a grade
1390:     * vira um retangulo branco sem cabecalho e sem coluna, sem erro e sem log.
1391:     * Soltando antes e re-vinculando depois (VincularGradeLog), a grade
1392:     * sobrevive a troca de cursor.
1393:     *
1394:     * PUBLIC de proposito (regra CLAUDE.md #1/#51 - o harness da etapa 06b
1395:     * chama metodos do form de FORA da classe).
1396:     *==========================================================================
1397:     PROCEDURE DesvincularGradeLog()
1398:         LOCAL loc_oPag, loc_oGrid, loc_nCol
1399: 
1400:         loc_oPag  = THIS.pgf_4c_Paginas.Page2
1401:         loc_oGrid = loc_oPag.grd_4c_Dados
1402: 
1403:         *-- O fwget1 sai primeiro: ControlSource apontando para alias fechado
1404:         *-- nao sobrevive ao USE IN que BuscarLog() faz em seguida.
1405:         IF PEMSTATUS(loc_oPag, "txt_4c_Fwget1", 5)
1406:             loc_oPag.txt_4c_Fwget1.ControlSource = ""
1407:             loc_oPag.txt_4c_Fwget1.Value         = ""
1408:         ENDIF
1409: 
1410:         FOR loc_nCol = 1 TO loc_oGrid.ColumnCount
1411:             loc_oGrid.Columns(loc_nCol).ControlSource = ""
1412:         ENDFOR
1413: 
1414:         loc_oGrid.RecordSource = ""
1415:     ENDPROC
1416: 
1417:     *==========================================================================
1418:     * RepintarGradeLog - Posiciona no inicio do cursor e repinta a grade.
1419:     *
1420:     * Popular o cursor NAO repinta a grade sozinho, e Refresh em pagina
1421:     * OCULTA nao pinta (regra CLAUDE.md #21): por isso este metodo eh
1422:     * chamado DEPOIS de AlternarPagina(2), ou seja depois de a Page2 ja
1423:     * estar ativa, e eh o unico lugar que faz GO TOP + Refresh - FONTE
1424:     * UNICA da repintura, igual VincularGradeLog eh a do bind.
1425:     *
1426:     * PUBLIC de proposito (regra CLAUDE.md #1/#51).

*-- Linhas 1439 a 1457:
1439: 
1440:         loc_oPag.grd_4c_Dados.Refresh()
1441: 
1442:         *-- O fwget1 acompanha a linha corrente da grade (ControlSource no
1443:         *-- cursor): depois de reposicionar, ele tambem precisa repintar.
1444:         IF PEMSTATUS(loc_oPag, "txt_4c_Fwget1", 5)
1445:             loc_oPag.txt_4c_Fwget1.Refresh()
1446:         ENDIF
1447:     ENDPROC
1448: 
1449:     *==========================================================================
1450:     * BtnProcessarClick - Botao "Processar" (Buttons(1) do cmg_4c_Acoes,
1451:     * Command1/btnProcessar do cmdProcessar legado).
1452:     *
1453:     * Transcricao do Click legado, que eh SO a confirmacao mais a chamada do
1454:     * PROCEDURE processamento:
1455:     *
1456:     *   If (MessageBox('Confirma o Processamento?', 4+32+256, ...) = 6)
1457:     *       ThisForm.Processamento      && -> THIS.CarregarLog()

*-- Linhas 1504 a 1522:
1504:     *      "If Eof() / MessageBox / Return" e NAO muda de pagina)
1505:     *
1506:     * Ordem obrigatoria no caminho de sucesso: desvincular -> consultar ->
1507:     * re-vincular (o SQLEXEC recriou o alias) -> trocar de pagina ->
1508:     * repintar (Refresh em pagina oculta nao pinta - regra #21).
1509:     *
1510:     * NUNCA ha RETURN dentro do TRY/CATCH (regra CLAUDE.md #1): o early-exit
1511:     * eh a flag loc_lProsseguir e o RETURN unico fica DEPOIS do ENDTRY.
1512:     *
1513:     * PUBLIC de proposito: alvo do harness da etapa 06b, que chama os metodos
1514:     * de carga de FORA da classe (regra CLAUDE.md #3).
1515:     *==========================================================================
1516:     PROCEDURE CarregarLog()
1517:         LOCAL loc_lProsseguir, loc_oBO, loc_oErro
1518: 
1519:         loc_lProsseguir = .T.
1520:         loc_oBO         = THIS.this_oBusinessObject
1521: 
1522:         TRY

*-- Linhas 1645 a 1665:
1645:     *
1646:     * Transcricao do PROCEDURE Valid do GetPrg legado:
1647:     *   IF not IsEmpty(This.value)
1648:     *       ThisForm.PoDatamgr.SqlExecute([Select Distinct Programas
1649:     *                   From SigCdPrg Order By Programas],"crSigCdPrg")
1650:     *       SELECT crSigCdPrg / LOCATE FOR Programas = This.Value
1651:     *       If EOF()
1652:     *           xBrow = CreateObject('fwBuscaInt','crSigCdPrg','Programas',
1653:     *                                This.Value,'Progamas',.t.)
1654:     *           xBrow.mAddColuna('Programas','','Programa',.t.) / xBrow.Show
1655:     *       ENDIF
1656:     *       IF LASTKEY()<>27 / This.value = crSigCdPrg.Programas / ENDIF
1657:     *   ENDIF
1658:     *
1659:     * fwBuscaInt = browse sobre cursor LOCAL (ja populado), diferente do
1660:     * fwBuscaExt do GetUserSis, que consulta o SQL Server - por isso aqui o
1661:     * cursor eh populado ANTES (sigopclgBO.BuscarProgramas) e entregue ao
1662:     * FormBuscaAuxiliar pela API DefinirCursor, nao pelo Init com parametros.
1663:     *
1664:     * Wrapper fino com a guarda de reentrancia; o corpo fica no *Exec para
1665:     * a flag ser liberada mesmo nos RETURN antecipados dele (regra CLAUDE.md

*-- Linhas 1706 a 1728:
1706:             RETURN
1707:         ENDIF
1708: 
1709:         *-- "SELECT crSigCdPrg / LOCATE FOR Programas = This.Value" do
1710:         *-- legado. Comparacao com == sobre ALLTRIM/UPPER: o SET EXACT ON
1711:         *-- global (config.prg) faz o "=" exigir a chave inteira com o
1712:         *-- padding do char(15), e ai o LOCATE nunca casaria.
1713:         SELECT (loc_cCursor)
1714:         LOCATE FOR UPPER(ALLTRIM(Programas)) == UPPER(loc_cValor)
1715: 
1716:         IF FOUND()
1717:             *-- "This.value = crSigCdPrg.Programas" do legado
1718:             loc_oPag.txt_4c_Prg.Value = ALLTRIM(EVALUATE(loc_cCursor + ".Programas"))
1719:         ELSE
1720:             *-- "If EOF() ... xBrow.Show" do legado
1721:             THIS.ExibirPickerPrg()
1722:         ENDIF
1723:     ENDPROC
1724: 
1725:     *==========================================================================
1726:     * ExibirPickerPrg - browse de Programas sobre o cursor LOCAL ja populado
1727:     * (fwBuscaInt do legado). NAO exibe aviso e NAO apaga o codigo digitado
1728:     * quando o universo esta vazio: universo vazio nao eh erro, e apagar o

*-- Linhas 1744 a 1762:
1744: 
1745:         *-- O LOCATE que falhou deixou o ponteiro em EOF - o browse tem de
1746:         *-- comecar da primeira linha.
1747:         SELECT (loc_cCursor)
1748:         GO TOP
1749: 
1750:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1751: 
1752:         IF VARTYPE(loc_oBusca) != "O"
1753:             RETURN
1754:         ENDIF
1755: 
1756:         *-- Titulo "Progamas" transcrito LITERALMENTE do legado (o 5o
1757:         *-- argumento do CreateObject('fwBuscaInt',...) tem essa grafia no
1758:         *-- dump) - PILAR 1: o usuario nao deve perceber diferenca.
1759:         loc_oBusca.DefinirCursor(loc_cCursor, "Programas", "Programas", "Progamas")
1760: 
1761:         *-- SigCdPrg.Programas eh coluna UNICA - eh ao mesmo tempo codigo e
1762:         *-- descricao (mesma familia de SigCdOpe.Dopes). DefinirCursor sempre

*-- Linhas 1851 a 1869:
1851:     *
1852:     * fwBuscaExt consulta o SQL Server por conta propria, exatamente como o
1853:     * Init com parametros do FormBuscaAuxiliar - por isso aqui NAO ha
1854:     * SQLEXEC nem LOCATE no form (duplicar a checagem de existencia so cria
1855:     * um caminho para divergir - regra CLAUDE.md #37).
1856:     *
1857:     * PUBLIC: delegate de BINDEVENT (regra CLAUDE.md #3).
1858:     *==========================================================================
1859:     PROCEDURE ValidarUserSisLostFocus()
1860:         IF THIS.this_lEmLookup
1861:             RETURN
1862:         ENDIF
1863: 
1864:         THIS.this_lEmLookup = .T.
1865:         THIS.ValidarUserSisLostFocusExec()
1866:         THIS.this_lEmLookup = .F.
1867:     ENDPROC
1868: 
1869:     *==========================================================================

*-- Linhas 1919 a 1937:
1919:         *-- do legado: atribui SO sob a guarda de selecao. Atribuir fora dela
1920:         *-- ZERARIA o codigo que o usuario digitou (regra CLAUDE.md #37/#50).
1921:         IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
1922:             SELECT (loc_cCursor)
1923:             loc_cCodigo = ALLTRIM(EVALUATE(loc_cCursor + ".Usuarios"))
1924:             IF !EMPTY(loc_cCodigo)
1925:                 loc_oPag.txt_4c_UserSis.Value = loc_cCodigo
1926:             ENDIF
1927:         ENDIF
1928: 
1929:         loc_oBusca.Release()
1930: 
1931:         *-- Cursor do lookup eh descartavel: fechado aqui para a proxima
1932:         *-- consulta nascer limpa (o alias nao alimenta grade nenhuma).
1933:         IF USED(loc_cCursor)
1934:             IF CURSORGETPROP("Buffering", loc_cCursor) > 1
1935:                 TABLEREVERT(.T., loc_cCursor)
1936:             ENDIF
1937:             USE IN (loc_cCursor)


### BO (C:\4c\projeto\app\classes\sigopclgBO.prg):
*============================================================================
* sigopclgBO.prg - Business Object para Consulta do Log (SigOpLog)
*
* Tabela principal : SigOpLog (PK: cidchaves char(20))
* Form OPERACIONAL de consulta - o legado SIGOPCLG nao grava em tabela
* nenhuma: o PROCEDURE Processamento monta um SELECT dinamico conforme os
* filtros preenchidos e exibe o resultado na Page "Resultado".
*
* Lookups usados pelo form (nao persistidos nesta entidade):
*   GetPrg.Valid     -> SigCdPrg.Programas (lista de programas)
*   GetUserSis.Valid -> SigCdUsu.Usuarios  (usuario do sistema)
*
* Herda de: BusinessBase
* Fase 1: propriedades de filtro + Init + BuscarLog
* Fase 2: CarregarDoCursor (TODAS as colunas de SigOpLog), ObterChavePrimaria,
*         DescreverOperacao, LimparRegistro, LimparDados e BuscarProgramas
*============================================================================

DEFINE CLASS sigopclgBO AS BusinessBase

    *==========================================================================
    * Propriedades de filtro (espelham os campos da Page "Dados" do legado)
    *==========================================================================
    this_cUserRede = ""    && char(20) - Usuario de Rede (filtro SigOpLog.Usuaredes =)
    this_dDtIni    = {}    && date     - Periodo: data inicial (filtro SigOpLog.Datars >=)
    this_dDtFin    = {}    && date     - Periodo: data final (filtro SigOpLog.Datars <=)
    this_cHrIni    = ""    && char(4)  - Horario de Acesso inicial, HHMM (Format "R" + InputMask 99:99)
    this_cHrFin    = ""    && char(4)  - Horario de Acesso final, HHMM (Format "R" + InputMask 99:99)
    this_cPrg      = ""    && char(20) - Programa (filtro SigOpLog.Progs =; lookup SigCdPrg.Programas)
    this_cOperacao = ""    && char(20) - Operacao: "Liberacao"/"Entrada"/"Saida"/"Transacao" (filtro SigOpLog.Opers)
    this_cUserSis  = ""    && char(20) - Usuario do Sistema (filtro SigOpLog.Usuasis =; lookup SigCdUsu.Usuarios)
    this_cParam    = ""    && char(10) - Parametros (filtro SigOpLog.Parametros LIKE "valor%")
    this_cTrans    = ""    && char(100) - Transacao (filtro SigOpLog.Transacaos LIKE "valor%")

    *==========================================================================
    * Resultado da consulta (grid da Page "Resultado")
    *==========================================================================
    this_cCursorLog       = "cursor_4c_Log"        && Alias do cursor com o resultado da pesquisa
    this_cCursorProgramas = "cursor_4c_Programas"  && Alias do cursor do lookup de Programas (SigCdPrg)
    this_nQtdeLog         = 0                      && Quantidade de linhas retornadas pela ultima pesquisa

    *==========================================================================
    * Registro corrente do Log - TODAS as colunas de SigOpLog mais a descricao
    * calculada cOpers. Preenchidas por CarregarDoCursor() a partir da linha
    * corrente do cursor do grid (o legado usa o proprio cursor como
    * ControlSource das 7 colunas do GrdLog e do fwget1 da Transacao; estas
    * propriedades existem para o form ler o registro selecionado sem precisar
    * tocar o cursor direto).
    *
    * Os nomes espelham as colunas do schema (docs/schema.sql):
    *   usuaredes  char(20)  NOT NULL | datars     datetime NULL  | horas    char(8)  NOT NULL
    *   progs      char(20)  NOT NULL | opers      char(1)  NOT NULL | usuasis char(20) NOT NULL
    *   parametros char(10)  NOT NULL | transacaos char(100) NOT NULL| cversaos char(70) NOT NULL
    *   cidchaves  char(20)  NOT NULL | copias     bit      NOT NULL
    *==========================================================================
    this_cUsuaRedes    = ""    && usuaredes  - Usuario de rede que gerou o registro
    this_dDatars       = {}    && datars     - Data do acesso (a hora fica em this_cHoras)
    this_cHoras        = ""    && horas      - Hora do acesso, formato HH:MM:SS
    this_cProgs        = ""    && progs      - Programa acessado
    this_cOpers        = ""    && opers      - Codigo da operacao: E, S, L ou outro
    this_cUsuaSis      = ""    && usuasis    - Usuario do sistema
    this_cParametros   = ""    && parametros - Parametros da chamada
    this_cTransacaos   = ""    && transacaos - Transacao registrada
    this_cCVersaos     = ""    && cversaos   - Versao do executavel que gravou o log
    this_cCidChaves    = ""    && cidchaves  - Chave primaria do registro
    this_nCopias       = 0     && copias     - Coluna bit: 1 ou 0 (bit chega Logico ou Numerico conforme o driver)
    this_cOperacaoDesc = ""    && cOpers     - Descricao da operacao (Entrada/Saida/Liberacao/Transacao)

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigOpLog"
            THIS.this_cCampoChave = "cidchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BuscarLog - Monta a consulta dinamica do Log de Acessos conforme os
    * filtros preenchidos pelo usuario (equivalente ao PROCEDURE Processamento
    * do legado SIGOPCLG) e popula THIS.this_cCursorLog ("cursor_4c_Log").
    *
    * Cada filtro so entra no WHERE se a propriedade correspondente estiver
    * preenchida (mesma logica condicional do legado, transcrita literalmente -
    * inclusive o guard de "nenhum parametro preenchido" e o mapeamento de
    * Operacao para o codigo de 1 letra gravado em Opers).
    *
    * Retorna .T. quando a consulta foi executada (mesmo com zero linhas) e
    * .F. quando nenhum filtro foi informado ou o SQL falhou; nos dois casos
    * de falha THIS.this_cMensagemErro traz o motivo, para o form decidir
    * entre MsgAviso (validacao) e MsgErro (falha tecnica) - este BO nao
    * chama MsgAviso/MsgErro diretamente nesse caminho.
    *
    * Responsabilidade do FORM apos chamar este metodo (Problema 48): limpar
    * e reatribuir Grid.RecordSource + cada Column.ControlSource +
    * Column.Header1.Caption, porque o SQLEXEC recria o cursor a cada busca -
    * exatamente como o legado faz em Processamento (RecordSource = '' no
    * inicio do metodo, RecordSource + ControlSource de novo no fim).
    *==========================================================================
    PROCEDURE BuscarLog()
        LOCAL loc_lResultado, loc_cSQL, loc_cWhere, loc_cHrIniSQL, loc_cHrFinSQL
        LOCAL loc_cOperFiltro, loc_dDtFinCompleta, loc_nResultado, loc_oErro

        loc_lResultado = .F.
        THIS.this_cMensagemErro = ""
        THIS.this_nQtdeLog = 0

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cUserRede))  AND ;
               EMPTY(THIS.this_dDtIni)              AND ;
               EMPTY(THIS.this_dDtFin)              AND ;
               EMPTY(ALLTRIM(THIS.this_cHrIni))     AND ;
               EMPTY(ALLTRIM(THIS.this_cHrFin))     AND ;
               EMPTY(ALLTRIM(THIS.this_cPrg))       AND ;
               EMPTY(ALLTRIM(THIS.this_cOperacao))  AND ;
               EMPTY(ALLTRIM(THIS.this_cUserSis))   AND ;
               EMPTY(ALLTRIM(THIS.this_cParam))     AND ;
               EMPTY(ALLTRIM(THIS.this_cTrans))

                THIS.this_cMensagemErro = "Pesquisa n" + CHR(227) + "o pode ser realizada," + CHR(13) + ;
                    "Nenhum Parametro de Sele" + CHR(231) + CHR(227) + "o foi Preenchido"
                loc_lResultado = .F.

            ELSE

                *-- Monta o WHERE dinamico - so entra o que o usuario preencheu
                loc_cWhere = ""

                IF !EMPTY(ALLTRIM(THIS.this_cUserRede))
                    loc_cWhere = loc_cWhere + " UsuaRedes = " + EscaparSQL(ALLTRIM(THIS.this_cUserRede))
                ENDIF

                IF !EMPTY(THIS.this_dDtIni)
                    loc_cWhere = loc_cWhere + IIF(!EMPTY(loc_cWhere), " AND", "") + ;
                        " Datars >= " + FormatarDataSQL(THIS.this_dDtIni)
                ENDIF

                IF !EMPTY(THIS.this_dDtFin)
                    *-- Legado soma 23:59:59 ao fim do periodo (fDtoSQL(ldDtFin,'23:59:59'))
                    loc_dDtFinCompleta = DATETIME(YEAR(THIS.this_dDtFin), MONTH(THIS.this_dDtFin), ;
                        DAY(THIS.this_dDtFin), 23, 59, 59)
                    loc_cWhere = loc_cWhere + IIF(!EMPTY(loc_cWhere), " AND", "") + ;
                        " Datars <= " + FormatarDataSQL(loc_dDtFinCompleta)
                ENDIF

                IF !EMPTY(ALLTRIM(THIS.this_cHrIni))
                    loc_cHrIniSQL = PADL(ALLTRIM(THIS.this_cHrIni), 4, "0")
                    loc_cWhere = loc_cWhere + IIF(!EMPTY(loc_cWhere), " AND", "") + ;
                        " Horas >= " + EscaparSQL(SUBSTR(loc_cHrIniSQL, 1, 2) + ":" + SUBSTR(loc_cHrIniSQL, 3, 2) + ":00")
                ENDIF

                IF !EMPTY(ALLTRIM(THIS.this_cHrFin))
                    loc_cHrFinSQL = PADL(ALLTRIM(THIS.this_cHrFin), 4, "0")
                    loc_cWhere = loc_cWhere + IIF(!EMPTY(loc_cWhere), " AND", "") + ;
                        " Horas <= " + EscaparSQL(SUBSTR(loc_cHrFinSQL, 1, 2) + ":" + SUBSTR(loc_cHrFinSQL, 3, 2) + ":00")
                ENDIF

                IF !EMPTY(ALLTRIM(THIS.this_cPrg))
                    loc_cWhere = loc_cWhere + IIF(!EMPTY(loc_cWhere), " AND", "") + ;
                        " Progs = " + EscaparSQL(ALLTRIM(THIS.this_cPrg))
                ENDIF

                IF !EMPTY(ALLTRIM(THIS.this_cOperacao))
                    *-- Mapeamento identico ao legado: Entrada=E, Saida=S, Liberacao=L,
                    *-- qualquer outra opcao (Transacao) = nenhum dos tres codigos acima.
                    *-- Medido no VFP9 em 2026-10-29: UPPER() converte os acentos
                    *-- (CHR(231) -> CHR(199), CHR(227) -> CHR(195)), por isso a comparacao
                    *-- com "LIBERA" + CHR(199) + CHR(195) + "O" casa com a opcao acentuada
                    *-- escolhida no ComboBox, igual ao Upper(lcOperacao) do legado.
                    DO CASE
                        CASE UPPER(ALLTRIM(THIS.this_cOperacao)) == "ENTRADA"
                            loc_cOperFiltro = " Opers = 'E'"
                        CASE UPPER(ALLTRIM(THIS.this_cOperacao)) == "SAIDA"
                            loc_cOperFiltro = " Opers = 'S'"
                        CASE UPPER(ALLTRIM(THIS.this_cOperacao)) == "LIBERA" + CHR(199) + CHR(195) + "O"
                            loc_cOperFiltro = " Opers = 'L'"
                        OTHERWISE
                            loc_cOperFiltro = " Opers <> 'E' AND Opers <> 'S' AND Opers <> 'L'"
                    ENDCASE
                    loc_cWhere = loc_cWhere + IIF(!EMPTY(loc_cWhere), " AND", "") + loc_cOperFiltro
                ENDIF

                IF !EMPTY(ALLTRIM(THIS.this_cUserSis))
                    loc_cWhere = loc_cWhere + IIF(!EMPTY(loc_cWhere), " AND", "") + ;
                        " Usuasis = " + EscaparSQL(ALLTRIM(THIS.this_cUserSis))
                ENDIF

                IF !EMPTY(ALLTRIM(THIS.this_cParam))
                    loc_cWhere = loc_cWhere + IIF(!EMPTY(loc_cWhere), " AND", "") + ;
                        " Parametros LIKE " + EscaparSQL(ALLTRIM(THIS.this_cParam) + "%")
                ENDIF

                IF !EMPTY(ALLTRIM(THIS.this_cTrans))
                    loc_cWhere = loc_cWhere + IIF(!EMPTY(loc_cWhere), " AND", "") + ;
                        " Transacaos LIKE " + EscaparSQL(ALLTRIM(THIS.this_cTrans) + "%")
                ENDIF

                *-- Colunas: cOpers (descricao calculada) primeiro, depois TODAS as
                *-- colunas de SigOpLog - o legado faz [Select '          ' As cOpers, a.*].
                *-- A descricao sai de um CASE no proprio SELECT porque cursor de SQL
                *-- pass-through nasce somente-leitura no VFP e o
                *-- "Replace All cOpers With Iif(...)" do legado nao teria onde gravar;
                *-- o mapeamento eh o MESMO de THIS.DescreverOperacao().
                loc_cSQL = "SELECT " + ;
                    "CASE a.Opers " + ;
                        "WHEN 'E' THEN 'Entrada' " + ;
                        "WHEN 'S' THEN 'Saida' " + ;
                        "WHEN 'L' THEN 'Libera" + CHR(231) + CHR(227) + "o' " + ;
                        "ELSE 'Transa" + CHR(231) + CHR(227) + "o' " + ;
                    "END AS cOpers, " + ;
                    "a.UsuaRedes, a.Datars, a.Horas, a.Progs, a.Opers, a.Usuasis, " + ;
                    "a.Parametros, a.Transacaos, a.CVersaos, a.cidchaves, a.Copias " + ;
                    "FROM SigOpLog a " + ;
                    "WHERE " + loc_cWhere

                IF USED(THIS.this_cCursorLog)
                    IF CURSORGETPROP("Buffering", THIS.this_cCursorLog) > 1
                        TABLEREVERT(.T., THIS.this_cCursorLog)
                    ENDIF
                    USE IN (THIS.this_cCursorLog)
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorLog)

                IF loc_nResultado >= 0
                    SELECT (THIS.this_cCursorLog)
                    GO TOP
                    THIS.this_nQtdeLog = RECCOUNT()

                    IF THIS.this_nQtdeLog = 0
                        THIS.this_cMensagemErro = "Nenhum Registro Encontrado para Sele" + CHR(231) + CHR(227) + "o"
                        THIS.LimparRegistro()
                    ELSE
                        *-- Deixa o registro corrente do BO espelhando a 1a linha da grade
                        THIS.CarregarDoCursor(THIS.this_cCursorLog)
                    ENDIF

                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao executar a pesquisa do Log:" + CHR(13) + CapturarErroSQL()
                    loc_lResultado = .F.
                ENDIF

            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao executar a pesquisa do Log: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega a linha CORRENTE do cursor do resultado para
    * as propriedades do registro, mapeando TODAS as colunas de SigOpLog mais
    * a descricao calculada cOpers.
    *
    * par_cCursor eh opcional: sem ele usa THIS.this_cCursorLog.
    *
    * Chamado pelo form no AfterRowColChange do GrdLog - no legado esse evento
    * faz "ThisForm.PgfPagina.PgResultado.fwget1.Refresh", porque o fwget1 da
    * Transacao tem ControlSource no cursor; aqui o form le
    * THIS.this_cTransacaos depois desta chamada.
    *
    * O alias que estava selecionado eh restaurado no fim, para a chamada nao
    * mexer na area de trabalho corrente de quem chamou.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cCursor)
        LOCAL loc_lResultado, loc_cAlias, loc_cAliasAnterior, loc_uCopias, loc_oErro

        loc_lResultado = .F.
        loc_cAliasAnterior = ALIAS()
        THIS.this_cMensagemErro = ""

        TRY
            IF VARTYPE(par_cCursor) = "C" AND !EMPTY(ALLTRIM(par_cCursor))
                loc_cAlias = ALLTRIM(par_cCursor)
            ELSE
                loc_cAlias = THIS.this_cCursorLog
            ENDIF

            DO CASE
                CASE !USED(loc_cAlias)
                    THIS.this_cMensagemErro = "Cursor [" + loc_cAlias + "] n" + CHR(227) + ;
                        "o est" + CHR(225) + " aberto para leitura do Log."

                CASE RECCOUNT(loc_cAlias) = 0
                    THIS.this_cMensagemErro = "Cursor [" + loc_cAlias + "] n" + CHR(227) + ;
                        "o possui registros."
                    THIS.LimparRegistro()

                OTHERWISE
                    SELECT (loc_cAlias)

                    IF EOF() OR BOF()
                        GO TOP
                    ENDIF

                    THIS.this_cUsuaRedes  = ALLTRIM(TratarNulo(UsuaRedes, ""))
                    THIS.this_dDatars     = ConverterParaData(TratarNulo(Datars, {}))
                    THIS.this_cHoras      = ALLTRIM(TratarNulo(Horas, ""))
                    THIS.this_cProgs      = ALLTRIM(TratarNulo(Progs, ""))
                    THIS.this_cOpers      = TratarNulo(Opers, "")
                    THIS.this_cUsuaSis    = ALLTRIM(TratarNulo(Usuasis, ""))
                    THIS.this_cParametros = ALLTRIM(TratarNulo(Parametros, ""))
                    THIS.this_cTransacaos = ALLTRIM(TratarNulo(Transacaos, ""))
                    THIS.this_cCVersaos   = ALLTRIM(TratarNulo(CVersaos, ""))
                    THIS.this_cCidChaves  = ALLTRIM(TratarNulo(cidchaves, ""))

                    *-- copias eh coluna bit: conforme o driver chega Logico (.T./.F.)
                    *-- ou Numerico (0/1), por isso testar VARTYPE antes de usar o valor
                    loc_uCopias = NVL(Copias, 0)
                    IF VARTYPE(loc_uCopias) = "L"
                        THIS.this_nCopias = IIF(loc_uCopias, 1, 0)
                    ELSE
                        THIS.this_nCopias = loc_uCopias
                    ENDIF

                    *-- cOpers so existe no cursor vindo de BuscarLog(); vindo de outro
                    *-- lugar, a descricao sai do mesmo mapeamento usado pelo legado
                    IF TYPE(loc_cAlias + ".cOpers") == "C"
                        THIS.this_cOperacaoDesc = ALLTRIM(TratarNulo(cOpers, ""))
                    ELSE
                        THIS.this_cOperacaoDesc = THIS.DescreverOperacao(THIS.this_cOpers)
                    ENDIF

                    loc_lResultado = .T.
            ENDCASE
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar o registro do Log: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lResultado = .F.
        ENDTRY

        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * DescreverOperacao - Converte o codigo gravado em SigOpLog.Opers na
    * descricao exibida na coluna "Operacao" do grid.
    *
    * Transcricao do legado (PROCEDURE Processamento):
    *   Replace All cOpers With Iif(Opers='E','Entrada',Iif(Opers='S','Saida',
    *               Iif(Opers='L','Liberacao','Transacao')))
    *==========================================================================
    PROCEDURE DescreverOperacao(par_cOpers)
        LOCAL loc_cCodigo, loc_cDescricao

        IF VARTYPE(par_cOpers) = "C"
            loc_cCodigo = UPPER(ALLTRIM(par_cOpers))
        ELSE
            loc_cCodigo = ""
        ENDIF

        DO CASE
            CASE loc_cCodigo == "E"
                loc_cDescricao = "Entrada"
            CASE loc_cCodigo == "S"
                loc_cDescricao = "Saida"
            CASE loc_cCodigo == "L"
                loc_cDescricao = "Libera" + CHR(231) + CHR(227) + "o"
            OTHERWISE
                loc_cDescricao = "Transa" + CHR(231) + CHR(227) + "o"
        ENDCASE

        RETURN loc_cDescricao
    ENDPROC

    *==========================================================================
    * BuscarProgramas - Popula o cursor do lookup de Programas usado pelo
    * Valid do campo Programa (GetPrg) do legado:
    *   SqlExecute([Select Distinct Programas From SigCdPrg Order By Programas],
    *              "crSigCdPrg")
    *
    * par_cCursor eh opcional: sem ele usa THIS.this_cCursorProgramas.
    * Retorna .T. quando a consulta rodou (mesmo com zero linhas).
    *
    * Nos dois caminhos de falha (SQL e excecao) o motivo fica em
    * THIS.this_cMensagemErro e quem EXIBE eh o FORM - mesma convencao
    * documentada em BuscarLog, deste mesmo BO. A excecao NAO eh engolida: o
    * unico chamador (o lookup de Programa em Formsigopclg) reporta com
    * MsgErro, e exibir aqui TAMBEM empilharia dois dialogos sobre a mesma
    * falha (regra CLAUDE.md #20 - fonte unica de reporte).
    *==========================================================================
    PROCEDURE BuscarProgramas(par_cCursor)
        LOCAL loc_lResultado, loc_cAlias, loc_cSQL, loc_nResultado, loc_oErro

        loc_lResultado = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF VARTYPE(par_cCursor) = "C" AND !EMPTY(ALLTRIM(par_cCursor))
                loc_cAlias = ALLTRIM(par_cCursor)
            ELSE
                loc_cAlias = THIS.this_cCursorProgramas
            ENDIF

            loc_cSQL = "SELECT DISTINCT Programas FROM SigCdPrg ORDER BY Programas"

            IF USED(loc_cAlias)
                IF CURSORGETPROP("Buffering", loc_cAlias) > 1
                    TABLEREVERT(.T., loc_cAlias)
                ENDIF
                USE IN (loc_cAlias)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

            IF loc_nResultado >= 0
                SELECT (loc_cAlias)
                GO TOP
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao carregar a lista de Programas:" + CHR(13) + CapturarErroSQL()
                loc_lResultado = .F.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar a lista de Programas: " + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * LimparRegistro - Zera somente as propriedades do registro corrente do
    * Log, preservando os filtros digitados pelo usuario (usado quando a
    * pesquisa nao retorna linha nenhuma)
    *==========================================================================
    PROCEDURE LimparRegistro()
        THIS.this_cUsuaRedes    = ""
        THIS.this_dDatars       = {}
        THIS.this_cHoras        = ""
        THIS.this_cProgs        = ""
        THIS.this_cOpers        = ""
        THIS.this_cUsuaSis      = ""
        THIS.this_cParametros   = ""
        THIS.this_cTransacaos   = ""
        THIS.this_cCVersaos     = ""
        THIS.this_cCidChaves    = ""
        THIS.this_nCopias       = 0
        THIS.this_cOperacaoDesc = ""
    ENDPROC

    *==========================================================================
    * LimparDados - Zera filtros e registro corrente, deixando o BO como na
    * abertura da tela (o form chama este metodo ao voltar da Page "Resultado"
    * para a Page "Dados", para a consulta seguinte comecar limpa)
    *==========================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cUserRede = ""
        THIS.this_dDtIni    = {}
        THIS.this_dDtFin    = {}
        THIS.this_cHrIni    = ""
        THIS.this_cHrFin    = ""
        THIS.this_cPrg      = ""
        THIS.this_cOperacao = ""
        THIS.this_cUserSis  = ""
        THIS.this_cParam    = ""
        THIS.this_cTrans    = ""

        THIS.this_nQtdeLog = 0
        THIS.LimparRegistro()
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Chave do registro corrente (SigOpLog.cidchaves),
    * conforme THIS.this_cCampoChave definido no Init
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDPROC

    *==========================================================================
    * Este BO eh somente-leitura: SIGOPCLG eh um visualizador do Log de
    * Acessos e o legado nao tem gravacao nesta tela - o dump
    * sigopclg_form_codigo_fonte.txt nao tem nenhum TABLEUPDATE, nenhum
    * .AddCursor e nenhum Insert Into / Update / Delete From (o log eh gravado
    * por outros pontos da aplicacao). O comportamento padrao herdado de
    * BusinessBase - recusar a operacao preenchendo this_cMensagemErro, que o
    * Salvar()/Excluir() reportam pelo ExibirFalha() - ja eh o correto para
    * Inserir(), Atualizar() e ExecutarExclusao(), por isso eles ficam
    * herdados em vez de sobrescritos: sobrescrever exigiria inventar a lista
    * de colunas de um INSERT ou de um UPDATE que o legado nao faz, e a regra
    * #22 do CLAUDE.md manda tirar essa lista do schema, nunca de adivinhacao.
    * RegistrarAuditoria() tambem fica herdado de BusinessBase - ele eh
    * acionado por Inserir/Atualizar/ExecutarExclusao, que aqui nunca gravam -
    * e ObterChavePrimaria() acima ja devolve a chave certa (cidchaves) caso
    * alguma rotina de auditoria venha a ser acionada sobre este BO.
    *==========================================================================

ENDDEFINE

