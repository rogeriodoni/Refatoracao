# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPOS, CONTAS, SALDOS, MARCAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PLACEHOLDER' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPOS, CONTAS, SALDOS, MARCAS

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
Select CrSigMvCcr
Insert Into CrSigMvCcr ( VOpers, NOpers, NLancs, VLancs, Opers, Grupos,;
lcQuery = [Select a.emps, a.grupos, a.contas, a.moedas, a.saldos, b.Rclis, b.Situas, 0 as Flag, 0 as Marcas ]+;
		   [From SigMvSlc a, SigCdCli b ]+;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigMvSlc') < 1)
Select CrSigMvSlc
	.Column5.ControlSource = 'CrSigMvSlc.Marcas'
	.Column1.ControlSource = 'CrSigMvSlc.contas'
	.Column2.ControlSource = 'CrSigMvSlc.rclis'
	.Column3.ControlSource = 'CrSigMvSlc.moedas'
	.Column4.ControlSource = 'CrSigMvSlc.saldos'
		Select crSigMvCcr
		Select crSigMvCab
Update CrSigMvSlc Set Marcas = 0
Update CrSigMvSlc Set Marcas = 1
Select CrSigMvSlc
Select crSigMvCcr
Select crSigMvCab
Select CrSigMvSlc
	If !Seek(_Empr + lcDope,'CrSigMvCab','EmpDopNum')
		Insert Into CrSigMvCab ( Emps, Dopes, Numes, Usuars, Datars, Datas, MascNum, EmpDopNums, CidChaves, DtAlts ) ;
	Select CrSigMvCcr
Select CrSigMvCcr
If Not ThisForm.poDataMgr.Update('crSigMvCcr')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigMvCcr)')
	If Not ThisForm.poDataMgr.Update('crSigMvCab')
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigMvCab)')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpEnc.prg) - TRECHOS RELEVANTES PARA PASS SQL (1708 linhas total):

*-- Linhas 75 a 94:
75: * no bloco "Entrada CONTRA-PARTIDA", que troca Grupos/Contas/Opers pelos
76: * campos S* na mesma iteracao em que a entrada direta e montada - evita
77: * depender de releitura de "registro corrente" (que nesta arquitetura nao
78: * existe um cursor crSigMvCcr com Append Blank, e sim um INSERT INTO
79: * SigMvCcr por SQLEXEC).
80: *==============================================================================
81: 
82: DEFINE CLASS FormSigOpEnc AS FormBase
83: 
84:     Width        = 800
85:     Height       = 600
86:     AutoCenter   = .T.
87:     Caption      = "Encerramento de Contas"
88:     ShowWindow   = 1
89:     WindowType   = 1
90:     ControlBox   = .F.
91:     Closable     = .F.
92:     MaxButton    = .F.
93:     MinButton    = .F.
94:     TitleBar     = 0

*-- Linhas 815 a 863:
815:                     USE IN (loc_cCursor)
816:                 ENDIF
817: 
818:                 loc_cSQL = "SELECT " + par_cCampoCod + " AS Cods, " + par_cCampoDesc + " AS Descs" + ;
819:                     " FROM " + par_cTabela + ;
820:                     " WHERE " + par_cCampoCod + " = " + EscaparSQL(loc_cCod) + ;
821:                     IIF(EMPTY(par_cFiltroExtra), "", " AND (" + par_cFiltroExtra + ")")
822:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)
823: 
824:                 IF loc_nResult > 0 AND USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
825:                     SELECT (loc_cCursor)
826:                     par_oTxtDesc.Value = ALLTRIM(Descs)
827:                 ELSE
828:                     THIS.AbrirLookupCanonico(par_cTabela, par_cCampoCod, par_cCampoDesc, ;
829:                         par_cTitulo, loc_cCod, par_oTxtCod, par_oTxtDesc, par_cFiltroExtra)
830:                 ENDIF
831: 
832:                 IF USED(loc_cCursor)
833:                     USE IN (loc_cCursor)
834:                 ENDIF
835:             ELSE
836:                 IF !EMPTY(loc_cDesc)
837:                     IF USED(loc_cCursor)
838:                         USE IN (loc_cCursor)
839:                     ENDIF
840: 
841:                     loc_cSQL = "SELECT " + par_cCampoCod + " AS Cods, " + par_cCampoDesc + " AS Descs" + ;
842:                         " FROM " + par_cTabela + ;
843:                         " WHERE " + par_cCampoDesc + " = " + EscaparSQL(loc_cDesc) + ;
844:                         IIF(EMPTY(par_cFiltroExtra), "", " AND (" + par_cFiltroExtra + ")")
845:                     loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)
846: 
847:                     IF loc_nResult > 0 AND USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
848:                         SELECT (loc_cCursor)
849:                         par_oTxtCod.Value = ALLTRIM(Cods)
850:                     ELSE
851:                         THIS.AbrirLookupCanonico(par_cTabela, par_cCampoCod, par_cCampoDesc, ;
852:                             par_cTitulo, loc_cDesc, par_oTxtCod, par_oTxtDesc, par_cFiltroExtra)
853:                     ENDIF
854: 
855:                     IF USED(loc_cCursor)
856:                         USE IN (loc_cCursor)
857:                     ENDIF
858:                 ENDIF
859:             ENDIF
860:         CATCH TO loc_oErro
861:             MsgErro(loc_oErro.Message + CHR(13) + ;
862:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
863:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpEnc.ResolverCodigoDescricao")

*-- Linhas 1024 a 1042:
1024:     PROTECTED PROCEDURE FiltroGrupoParaConta()
1025:         LOCAL loc_cGrupo
1026:         loc_cGrupo = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Grupo.Value)
1027:         RETURN IIF(EMPTY(loc_cGrupo), "", "grupos = " + EscaparSQL(loc_cGrupo))
1028:     ENDPROC
1029: 
1030:     *==========================================================================
1031:     * GrupoCLostFocus / DGrupoCLostFocus / ContaCLostFocus / DContaCLostFocus
1032:     * - o que o Valid do legado faz ao sair de cada campo da Contra-Partida:
1033:     *
1034:     *   Get_GrupoC.Valid  -> fAcessoContab('C',...) / sem MontaTela()
1035:     *   Get_DgrupoC.Valid -> fAcessoContab('D',...) / sem MontaTela()
1036:     *   Get_contaC.Valid  -> fAcessoContas('C', Get_GrupoC.Value, ...) / sem MontaTela()
1037:     *   Get_DcontaC.Valid -> fAcessoContas('D', Get_GrupoC.Value, ...) / sem MontaTela()
1038:     *
1039:     * Nenhum dos quatro recarrega a grade - a Contra-Partida nao faz parte do
1040:     * filtro de saldos, so e usada no Processar (fase 7/8).
1041:     *
1042:     * O lookup fica no funil THIS.AbrirLookupGrupoC()/AbrirLookupContaC(),

*-- Linhas 1093 a 1111:
1093:     PROTECTED PROCEDURE FiltroGrupoCParaConta()
1094:         LOCAL loc_cGrupo
1095:         loc_cGrupo = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrupoC.Value)
1096:         RETURN IIF(EMPTY(loc_cGrupo), "", "grupos = " + EscaparSQL(loc_cGrupo))
1097:     ENDPROC
1098: 
1099:     *==========================================================================
1100:     * AplicarFiltro - funil UNICO do MontaTela() legado no que diz respeito ao
1101:     * filtro: le os dois codigos digitados, guarda-os no BO (de onde o
1102:     * CarregarSaldos monta o WHERE a.grupos / a.contas) e recarrega a grade.
1103:     *
1104:     * So recarrega quando o par Grupo/Conta MUDOU em relacao ao que o BO ja
1105:     * tem: mesma consulta devolveria o mesmo resultado, e o LostFocus dispara
1106:     * a cada saida de campo, inclusive em Tab de passagem. A semantica do
1107:     * legado e preservada - o que muda e so a consulta repetida.
1108:     *
1109:     * O ALLTRIM aqui e no par descricao e seguro porque o WHERE compara
1110:     * coluna char com literal (blank-padding ANSI do SQL Server); nao e chave
1111:     * posicional concatenada (regra CLAUDE.md #42).

*-- Linhas 1251 a 1289:
1251:     *==========================================================================
1252:     * CriarCursorSaldosPlaceholder - Cursor vazio com a mesma estrutura que a
1253:     * carga por SQL vai popular depois (equivalente ao
1254:     * Select a.emps, a.grupos, a.contas, a.moedas, a.saldos, b.Rclis,
1255:     * b.Situas, 0 as Flag, 0 as Marcas do MontaTela() legado, sobre
1256:     * SigMvSlc/SigCdCli). Indices iguais aos do legado (Index On Rclis /
1257:     * Index On Contas), que o Ingrid1 das colunas 1/2 usava para busca
1258:     * incremental.
1259:     *==========================================================================
1260:     PROTECTED PROCEDURE CriarCursorSaldosPlaceholder()
1261:         LOCAL loc_cCursor
1262:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorSaldos
1263: 
1264:         IF USED(loc_cCursor)
1265:             USE IN (loc_cCursor)
1266:         ENDIF
1267: 
1268:         SET NULL ON
1269:         CREATE CURSOR (loc_cCursor) ;
1270:             (emps C(3), grupos C(10), contas C(10), moedas C(3), ;
1271:              saldos N(13,2), rclis C(50), situas C(3), flag N(1,0), marcas N(1,0))
1272:         SET NULL OFF
1273: 
1274:         SELECT (loc_cCursor)
1275:         INDEX ON contas TAG Contas
1276:         INDEX ON rclis TAG Rclis
1277:     ENDPROC
1278: 
1279:     *==========================================================================
1280:     * ConfigurarGridSaldo - grd_saldo do legado: Conta/Descricao/Moeda/Saldo
1281:     * mais a coluna de marcacao (Column5.Check1 do dump, ligada direto a
1282:     * Marcas - sem handler extra, o proprio binding da Column grava no
1283:     * cursor ao clicar, igual ao legado). DynamicBackColor verde claro
1284:     * destaca a linha ja processada (Flag = 1), igual ao SetAll do
1285:     * MontaTela().
1286:     *==========================================================================
1287:     PROTECTED PROCEDURE ConfigurarGridSaldo()
1288:         LOCAL loc_cCursor
1289:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorSaldos

*-- Linhas 1306 a 1371:
1306:             .Height        = 244
1307:             .FontName      = "Tahoma"
1308:             .FontSize      = 8
1309:             .DeleteMark    = .F.
1310:             .RecordMark    = .F.
1311:             .RowHeight     = 16
1312:             .ScrollBars    = 2
1313:             .GridLineColor = RGB(238, 238, 238)
1314: 
1315:             .Column1.ControlSource     = loc_cCursor + ".contas"
1316:             .Column1.Width             = 80
1317:             .Column1.Movable           = .F.
1318:             .Column1.Resizable         = .F.
1319:             .Column1.ReadOnly          = .T.
1320:             .Column1.Header1.Caption   = "Conta"
1321:             .Column1.Header1.Alignment = 2
1322: 
1323:             .Column2.ControlSource     = loc_cCursor + ".rclis"
1324:             .Column2.Width             = 320
1325:             .Column2.Movable           = .F.
1326:             .Column2.Resizable         = .F.
1327:             .Column2.ReadOnly          = .T.
1328:             .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1329:             .Column2.Header1.Alignment = 2
1330: 
1331:             .Column3.ControlSource     = loc_cCursor + ".moedas"
1332:             .Column3.Alignment         = 3
1333:             .Column3.Width             = 40
1334:             .Column3.Movable           = .F.
1335:             .Column3.Resizable         = .F.
1336:             .Column3.ReadOnly          = .T.
1337:             .Column3.Header1.Caption   = "Moeda"
1338:             .Column3.Header1.Alignment = 2
1339: 
1340:             .Column4.ControlSource      = loc_cCursor + ".saldos"
1341:             .Column4.Width              = 94
1342:             .Column4.Movable            = .F.
1343:             .Column4.Resizable          = .F.
1344:             .Column4.ReadOnly           = .T.
1345:             .Column4.Text1.InputMask    = "999,999,999.99"
1346:             .Column4.Header1.Caption    = "Saldo"
1347:             .Column4.Header1.Alignment  = 2
1348: 
1349:             .Column5.AddObject("Check1", "CheckBox")
1350:             .Column5.Check1.Caption    = ""
1351:             .Column5.Check1.Value      = 0
1352:             .Column5.CurrentControl    = "Check1"
1353:             .Column5.Sparse            = .F.
1354:             .Column5.ReadOnly          = .F.
1355:             .Column5.Width             = 21
1356:             .Column5.ControlSource     = loc_cCursor + ".marcas"
1357:             .Column5.Header1.Caption   = ""
1358: 
1359:             .SetAll("DynamicBackColor", ;
1360:                 "IIF(" + loc_cCursor + ".Flag = 1, RGB(220,255,220), RGB(255,255,255))", ;
1361:                 "Column")
1362: 
1363:             .Visible = .T.
1364:         ENDWITH
1365:     ENDPROC
1366: 
1367:     *==========================================================================
1368:     * ConfigurarBotoesAcao - SelTudo/Apaga (manipulam o cursor_4c_Saldos),
1369:     * cmd_4c_CmdProcessa (cmdProcessa.Click do legado) e cmd_4c_Encerrar
1370:     * (cmdGprocessa.cmdSair do legado). O CommandGroup de 1 botao do dump
1371:     * (BackStyle=0, BorderStyle=0 - sem efeito visual nenhum) foi achatado

*-- Linhas 1473 a 1491:
1473:     * consulta.
1474:     *
1475:     * O cursor da grade NAO e fechado nem reaberto: o BO recarrega por
1476:     * ZAP + APPEND FROM DBF(), entao RecordSource, ControlSource, Width,
1477:     * Header, DynamicBackColor e o Check1 da Column5 sobrevivem - por isso
1478:     * aqui nao se repete o rebind que o legado faz no fim do MontaTela()
1479:     * (ele rebinda porque FECHA e RECRIA o cursor; refazer o bind aqui
1480:     * destruiria o Check1 posto por AddObject - regra #18/#41).
1481:     *
1482:     * O GO TOP + Refresh e obrigatorio: popular o cursor NAO repinta a grade
1483:     * (regra #21a) - sem ele a grade fica visualmente vazia com o cursor
1484:     * cheio, e o sintoma ("a tela nao traz dados") manda o diagnostico para
1485:     * SQL/permissao.
1486:     *
1487:     * PUBLIC (sem PROTECTED) de proposito: o harness de teste chama os
1488:     * metodos de carga direto no objeto do form, de FORA da classe (regra #3).
1489:     *==========================================================================
1490:     PROCEDURE CarregarDados()
1491:         LOCAL loc_cCursor, loc_nLinhas, loc_lSucesso, loc_oErro

*-- Linhas 1503 a 1583:
1503:             loc_nLinhas = 0
1504:             IF USED(loc_cCursor)
1505:                 loc_nLinhas = RECCOUNT(loc_cCursor)
1506:                 SELECT (loc_cCursor)
1507:                 GO TOP
1508:             ENDIF
1509: 
1510:             *-- MontaTela(): If Reccount('CrSigMvSlc') > 0 /
1511:             *-- CmdProcessa.Enabled = .t. / Else / .Enabled = .f. / EndIf
1512:             THIS.cmd_4c_CmdProcessa.Enabled = (loc_nLinhas > 0)
1513: 
1514:             THIS.grd_4c_Dados.Refresh()
1515:         CATCH TO loc_oErro
1516:             MsgErro(loc_oErro.Message + CHR(13) + ;
1517:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1518:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpEnc.CarregarDados")
1519:         ENDTRY
1520: 
1521:         RETURN loc_lSucesso
1522:     ENDPROC
1523: 
1524:     *==========================================================================
1525:     * BtnSelTudoClick - Marca todas as linhas da grade (equivalente a
1526:     * Update CrSigMvSlc Set Marcas = 1 do legado)
1527:     *==========================================================================
1528:     PROCEDURE BtnSelTudoClick()
1529:         LOCAL loc_oErro
1530: 
1531:         TRY
1532:             IF USED(THIS.this_oBusinessObject.this_cCursorSaldos)
1533:                 UPDATE (THIS.this_oBusinessObject.this_cCursorSaldos) SET marcas = 1
1534:                 THIS.grd_4c_Dados.Refresh()
1535:             ENDIF
1536:         CATCH TO loc_oErro
1537:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1538:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnSelTudoClick")
1539:         ENDTRY
1540:     ENDPROC
1541: 
1542:     *==========================================================================
1543:     * BtnApagaClick - Desmarca todas as linhas da grade (equivalente a
1544:     * Update CrSigMvSlc Set Marcas = 0 do legado)
1545:     *==========================================================================
1546:     PROCEDURE BtnApagaClick()
1547:         LOCAL loc_oErro
1548: 
1549:         TRY
1550:             IF USED(THIS.this_oBusinessObject.this_cCursorSaldos)
1551:                 UPDATE (THIS.this_oBusinessObject.this_cCursorSaldos) SET marcas = 0
1552:                 THIS.grd_4c_Dados.Refresh()
1553:             ENDIF
1554:         CATCH TO loc_oErro
1555:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1556:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnApagaClick")
1557:         ENDTRY
1558:     ENDPROC
1559: 
1560:     *==========================================================================
1561:     * BtnProcessarClick - cmdProcessa.Click do legado: os 4 guards do topo
1562:     * (With ThisForm.Container1 / If Empty(...) / MessageBox / Return 0),
1563:     * depois a checagem "Nenhuma Conta Selecionada" (Select CrSigMvSlc /
1564:     * Count To x For Marcas = 1) e, so entao, o SCAN que gera os dois
1565:     * lancamentos de encerramento por conta marcada - delegado a
1566:     * THIS.this_oBusinessObject.ProcessarEncerramento(), que concentra o que
1567:     * no legado era FazContra/fGerUniqueKey/fBuscarCotacao/fRecalculaS e o
1568:     * Update/Commit/RollBack de ThisForm.poDataMgr.
1569:     *
1570:     * Os 4 guards ficam no FORM (lem textbox, nao property de BO) - mesmas
1571:     * mensagens do legado, na mesma ordem. Guardados numa unica variavel
1572:     * (loc_cErro) em vez de 4 IFs encaixados, para nao passar de 3 niveis de
1573:     * aninhamento (regra de legibilidade; a ordem de avaliacao e idêntica aos
1574:     * 4 "If Empty(...) / Return 0" sequenciais do legado).
1575:     *
1576:     * Sucesso encerra igual ao legado (ThisForm.Iniciar() no fim do Click):
1577:     * THIS.LimparFiltro() zera os 8 campos do Container1 e recarrega a grade
1578:     * (que fica vazia, porque o sentinela de grupo vazio nao casa nada -
1579:     * regra CLAUDE.md #35a).
1580:     *==========================================================================
1581:     PROCEDURE BtnProcessarClick()
1582:         LOCAL loc_cGrupo, loc_cGrupoC, loc_cContaC, loc_cDope, loc_cErro, ;
1583:             loc_nSelecionadas, loc_oErro

*-- Linhas 1610 a 1628:
1610:                 loc_nSelecionadas = 0
1611: 
1612:                 IF USED(THIS.this_oBusinessObject.this_cCursorSaldos)
1613:                     SELECT (THIS.this_oBusinessObject.this_cCursorSaldos)
1614:                     COUNT TO loc_nSelecionadas FOR marcas = 1
1615:                 ENDIF
1616: 
1617:                 IF loc_nSelecionadas = 0
1618:                     MsgAviso("Nenhuma Conta Selecionada!", "Aten" + CHR(231) + CHR(227) + "o")
1619:                 ELSE
1620:                     THIS.this_oBusinessObject.this_nContasSelecionadas = loc_nSelecionadas
1621: 
1622:                     IF THIS.this_oBusinessObject.ProcessarEncerramento(loc_cGrupo, loc_cGrupoC, loc_cContaC, loc_cDope)
1623:                         MsgInfo("Encerramento processado com sucesso!", "Confirmar")
1624:                         THIS.LimparFiltro()
1625:                     ELSE
1626:                         IF !THIS.this_oBusinessObject.this_lErroExibido
1627:                             MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel processar o encerramento.", "Confirmar")
1628:                         ENDIF

