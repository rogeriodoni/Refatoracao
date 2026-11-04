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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpEnc.prg) - TRECHOS RELEVANTES PARA PASS SQL (1626 linhas total):

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

*-- Linhas 801 a 849:
801:                     USE IN (loc_cCursor)
802:                 ENDIF
803: 
804:                 loc_cSQL = "SELECT " + par_cCampoCod + " AS Cods, " + par_cCampoDesc + " AS Descs" + ;
805:                     " FROM " + par_cTabela + ;
806:                     " WHERE " + par_cCampoCod + " = " + EscaparSQL(loc_cCod) + ;
807:                     IIF(EMPTY(par_cFiltroExtra), "", " AND (" + par_cFiltroExtra + ")")
808:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)
809: 
810:                 IF loc_nResult > 0 AND USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
811:                     SELECT (loc_cCursor)
812:                     par_oTxtDesc.Value = ALLTRIM(Descs)
813:                 ELSE
814:                     THIS.AbrirLookupCanonico(par_cTabela, par_cCampoCod, par_cCampoDesc, ;
815:                         par_cTitulo, loc_cCod, par_oTxtCod, par_oTxtDesc, par_cFiltroExtra)
816:                 ENDIF
817: 
818:                 IF USED(loc_cCursor)
819:                     USE IN (loc_cCursor)
820:                 ENDIF
821:             ELSE
822:                 IF !EMPTY(loc_cDesc)
823:                     IF USED(loc_cCursor)
824:                         USE IN (loc_cCursor)
825:                     ENDIF
826: 
827:                     loc_cSQL = "SELECT " + par_cCampoCod + " AS Cods, " + par_cCampoDesc + " AS Descs" + ;
828:                         " FROM " + par_cTabela + ;
829:                         " WHERE " + par_cCampoDesc + " = " + EscaparSQL(loc_cDesc) + ;
830:                         IIF(EMPTY(par_cFiltroExtra), "", " AND (" + par_cFiltroExtra + ")")
831:                     loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)
832: 
833:                     IF loc_nResult > 0 AND USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
834:                         SELECT (loc_cCursor)
835:                         par_oTxtCod.Value = ALLTRIM(Cods)
836:                     ELSE
837:                         THIS.AbrirLookupCanonico(par_cTabela, par_cCampoCod, par_cCampoDesc, ;
838:                             par_cTitulo, loc_cDesc, par_oTxtCod, par_oTxtDesc, par_cFiltroExtra)
839:                     ENDIF
840: 
841:                     IF USED(loc_cCursor)
842:                         USE IN (loc_cCursor)
843:                     ENDIF
844:                 ENDIF
845:             ENDIF
846:         CATCH TO loc_oErro
847:             MsgErro(loc_oErro.Message + CHR(13) + ;
848:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
849:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpEnc.ResolverCodigoDescricao")

*-- Linhas 986 a 1004:
986:     PROTECTED PROCEDURE FiltroGrupoParaConta()
987:         LOCAL loc_cGrupo
988:         loc_cGrupo = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Grupo.Value)
989:         RETURN IIF(EMPTY(loc_cGrupo), "", "grupos = " + EscaparSQL(loc_cGrupo))
990:     ENDPROC
991: 
992:     *==========================================================================
993:     * GrupoCLostFocus / DGrupoCLostFocus / ContaCLostFocus / DContaCLostFocus
994:     * - o que o Valid do legado faz ao sair de cada campo da Contra-Partida:
995:     *
996:     *   Get_GrupoC.Valid  -> fAcessoContab('C',...) / sem MontaTela()
997:     *   Get_DgrupoC.Valid -> fAcessoContab('D',...) / sem MontaTela()
998:     *   Get_contaC.Valid  -> fAcessoContas('C', Get_GrupoC.Value, ...) / sem MontaTela()
999:     *   Get_DcontaC.Valid -> fAcessoContas('D', Get_GrupoC.Value, ...) / sem MontaTela()
1000:     *
1001:     * Nenhum dos quatro recarrega a grade - a Contra-Partida nao faz parte do
1002:     * filtro de saldos, so e usada no Processar (fase 7/8).
1003:     *
1004:     * O lookup fica no funil THIS.AbrirLookupGrupoC()/AbrirLookupContaC(),

*-- Linhas 1031 a 1049:
1031:     PROTECTED PROCEDURE FiltroGrupoCParaConta()
1032:         LOCAL loc_cGrupo
1033:         loc_cGrupo = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrupoC.Value)
1034:         RETURN IIF(EMPTY(loc_cGrupo), "", "grupos = " + EscaparSQL(loc_cGrupo))
1035:     ENDPROC
1036: 
1037:     *==========================================================================
1038:     * AplicarFiltro - funil UNICO do MontaTela() legado no que diz respeito ao
1039:     * filtro: le os dois codigos digitados, guarda-os no BO (de onde o
1040:     * CarregarSaldos monta o WHERE a.grupos / a.contas) e recarrega a grade.
1041:     *
1042:     * So recarrega quando o par Grupo/Conta MUDOU em relacao ao que o BO ja
1043:     * tem: mesma consulta devolveria o mesmo resultado, e o LostFocus dispara
1044:     * a cada saida de campo, inclusive em Tab de passagem. A semantica do
1045:     * legado e preservada - o que muda e so a consulta repetida.
1046:     *
1047:     * O ALLTRIM aqui e no par descricao e seguro porque o WHERE compara
1048:     * coluna char com literal (blank-padding ANSI do SQL Server); nao e chave
1049:     * posicional concatenada (regra CLAUDE.md #42).

*-- Linhas 1177 a 1215:
1177:     *==========================================================================
1178:     * CriarCursorSaldosPlaceholder - Cursor vazio com a mesma estrutura que a
1179:     * carga por SQL vai popular depois (equivalente ao
1180:     * Select a.emps, a.grupos, a.contas, a.moedas, a.saldos, b.Rclis,
1181:     * b.Situas, 0 as Flag, 0 as Marcas do MontaTela() legado, sobre
1182:     * SigMvSlc/SigCdCli). Indices iguais aos do legado (Index On Rclis /
1183:     * Index On Contas), que o Ingrid1 das colunas 1/2 usava para busca
1184:     * incremental.
1185:     *==========================================================================
1186:     PROTECTED PROCEDURE CriarCursorSaldosPlaceholder()
1187:         LOCAL loc_cCursor
1188:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorSaldos
1189: 
1190:         IF USED(loc_cCursor)
1191:             USE IN (loc_cCursor)
1192:         ENDIF
1193: 
1194:         SET NULL ON
1195:         CREATE CURSOR (loc_cCursor) ;
1196:             (emps C(3), grupos C(10), contas C(10), moedas C(3), ;
1197:              saldos N(13,2), rclis C(50), situas C(3), flag N(1,0), marcas N(1,0))
1198:         SET NULL OFF
1199: 
1200:         SELECT (loc_cCursor)
1201:         INDEX ON contas TAG Contas
1202:         INDEX ON rclis TAG Rclis
1203:     ENDPROC
1204: 
1205:     *==========================================================================
1206:     * ConfigurarGridSaldo - grd_saldo do legado: Conta/Descricao/Moeda/Saldo
1207:     * mais a coluna de marcacao (Column5.Check1 do dump, ligada direto a
1208:     * Marcas - sem handler extra, o proprio binding da Column grava no
1209:     * cursor ao clicar, igual ao legado). DynamicBackColor verde claro
1210:     * destaca a linha ja processada (Flag = 1), igual ao SetAll do
1211:     * MontaTela().
1212:     *==========================================================================
1213:     PROTECTED PROCEDURE ConfigurarGridSaldo()
1214:         LOCAL loc_cCursor
1215:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorSaldos

*-- Linhas 1222 a 1289:
1222:             .Height        = 244
1223:             .FontName      = "Tahoma"
1224:             .FontSize      = 8
1225:             .DeleteMark    = .F.
1226:             .RecordMark    = .F.
1227:             .RowHeight     = 16
1228:             .ScrollBars    = 2
1229:             .GridLineColor = RGB(238, 238, 238)
1230:             .ColumnCount   = 5
1231:             .RecordSource  = loc_cCursor
1232: 
1233:             .Column1.ControlSource     = loc_cCursor + ".contas"
1234:             .Column1.Width             = 80
1235:             .Column1.Movable           = .F.
1236:             .Column1.Resizable         = .F.
1237:             .Column1.ReadOnly          = .T.
1238:             .Column1.Header1.Caption   = "Conta "
1239:             .Column1.Header1.Alignment = 2
1240: 
1241:             .Column2.ControlSource     = loc_cCursor + ".rclis"
1242:             .Column2.Width             = 320
1243:             .Column2.Movable           = .F.
1244:             .Column2.Resizable         = .F.
1245:             .Column2.ReadOnly          = .T.
1246:             .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1247:             .Column2.Header1.Alignment = 2
1248: 
1249:             .Column3.ControlSource     = loc_cCursor + ".moedas"
1250:             .Column3.Alignment         = 3
1251:             .Column3.Width             = 40
1252:             .Column3.Movable           = .F.
1253:             .Column3.Resizable         = .F.
1254:             .Column3.ReadOnly          = .T.
1255:             .Column3.Header1.Caption   = "Moeda"
1256:             .Column3.Header1.Alignment = 2
1257: 
1258:             .Column4.ControlSource      = loc_cCursor + ".saldos"
1259:             .Column4.Width              = 94
1260:             .Column4.Movable            = .F.
1261:             .Column4.Resizable          = .F.
1262:             .Column4.ReadOnly           = .T.
1263:             .Column4.Text1.InputMask    = "999,999,999.99"
1264:             .Column4.Header1.Caption    = "Saldo"
1265:             .Column4.Header1.Alignment  = 2
1266: 
1267:             .Column5.AddObject("Check1", "CheckBox")
1268:             .Column5.Check1.Caption    = ""
1269:             .Column5.Check1.Value      = 0
1270:             .Column5.CurrentControl    = "Check1"
1271:             .Column5.Sparse            = .F.
1272:             .Column5.ReadOnly          = .F.
1273:             .Column5.Width             = 21
1274:             .Column5.ControlSource     = loc_cCursor + ".marcas"
1275:             .Column5.Header1.Caption   = ""
1276: 
1277:             .SetAll("DynamicBackColor", ;
1278:                 "IIF(" + loc_cCursor + ".Flag = 1, RGB(220,255,220), RGB(255,255,255))", ;
1279:                 "Column")
1280: 
1281:             .Visible = .T.
1282:         ENDWITH
1283:     ENDPROC
1284: 
1285:     *==========================================================================
1286:     * ConfigurarBotoesAcao - SelTudo/Apaga (manipulam o cursor_4c_Saldos),
1287:     * cmd_4c_CmdProcessa (cmdProcessa.Click do legado) e cmd_4c_Encerrar
1288:     * (cmdGprocessa.cmdSair do legado). O CommandGroup de 1 botao do dump
1289:     * (BackStyle=0, BorderStyle=0 - sem efeito visual nenhum) foi achatado

*-- Linhas 1391 a 1409:
1391:     * consulta.
1392:     *
1393:     * O cursor da grade NAO e fechado nem reaberto: o BO recarrega por
1394:     * ZAP + APPEND FROM DBF(), entao RecordSource, ControlSource, Width,
1395:     * Header, DynamicBackColor e o Check1 da Column5 sobrevivem - por isso
1396:     * aqui nao se repete o rebind que o legado faz no fim do MontaTela()
1397:     * (ele rebinda porque FECHA e RECRIA o cursor; refazer o bind aqui
1398:     * destruiria o Check1 posto por AddObject - regra #18/#41).
1399:     *
1400:     * O GO TOP + Refresh e obrigatorio: popular o cursor NAO repinta a grade
1401:     * (regra #21a) - sem ele a grade fica visualmente vazia com o cursor
1402:     * cheio, e o sintoma ("a tela nao traz dados") manda o diagnostico para
1403:     * SQL/permissao.
1404:     *
1405:     * PUBLIC (sem PROTECTED) de proposito: o harness de teste chama os
1406:     * metodos de carga direto no objeto do form, de FORA da classe (regra #3).
1407:     *==========================================================================
1408:     PROCEDURE CarregarDados()
1409:         LOCAL loc_cCursor, loc_nLinhas, loc_lSucesso, loc_oErro

*-- Linhas 1421 a 1501:
1421:             loc_nLinhas = 0
1422:             IF USED(loc_cCursor)
1423:                 loc_nLinhas = RECCOUNT(loc_cCursor)
1424:                 SELECT (loc_cCursor)
1425:                 GO TOP
1426:             ENDIF
1427: 
1428:             *-- MontaTela(): If Reccount('CrSigMvSlc') > 0 /
1429:             *-- CmdProcessa.Enabled = .t. / Else / .Enabled = .f. / EndIf
1430:             THIS.cmd_4c_CmdProcessa.Enabled = (loc_nLinhas > 0)
1431: 
1432:             THIS.grd_4c_Dados.Refresh()
1433:         CATCH TO loc_oErro
1434:             MsgErro(loc_oErro.Message + CHR(13) + ;
1435:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1436:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpEnc.CarregarDados")
1437:         ENDTRY
1438: 
1439:         RETURN loc_lSucesso
1440:     ENDPROC
1441: 
1442:     *==========================================================================
1443:     * BtnSelTudoClick - Marca todas as linhas da grade (equivalente a
1444:     * Update CrSigMvSlc Set Marcas = 1 do legado)
1445:     *==========================================================================
1446:     PROCEDURE BtnSelTudoClick()
1447:         LOCAL loc_oErro
1448: 
1449:         TRY
1450:             IF USED(THIS.this_oBusinessObject.this_cCursorSaldos)
1451:                 UPDATE (THIS.this_oBusinessObject.this_cCursorSaldos) SET marcas = 1
1452:                 THIS.grd_4c_Dados.Refresh()
1453:             ENDIF
1454:         CATCH TO loc_oErro
1455:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1456:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnSelTudoClick")
1457:         ENDTRY
1458:     ENDPROC
1459: 
1460:     *==========================================================================
1461:     * BtnApagaClick - Desmarca todas as linhas da grade (equivalente a
1462:     * Update CrSigMvSlc Set Marcas = 0 do legado)
1463:     *==========================================================================
1464:     PROCEDURE BtnApagaClick()
1465:         LOCAL loc_oErro
1466: 
1467:         TRY
1468:             IF USED(THIS.this_oBusinessObject.this_cCursorSaldos)
1469:                 UPDATE (THIS.this_oBusinessObject.this_cCursorSaldos) SET marcas = 0
1470:                 THIS.grd_4c_Dados.Refresh()
1471:             ENDIF
1472:         CATCH TO loc_oErro
1473:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1474:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnApagaClick")
1475:         ENDTRY
1476:     ENDPROC
1477: 
1478:     *==========================================================================
1479:     * BtnProcessarClick - cmdProcessa.Click do legado: os 4 guards do topo
1480:     * (With ThisForm.Container1 / If Empty(...) / MessageBox / Return 0),
1481:     * depois a checagem "Nenhuma Conta Selecionada" (Select CrSigMvSlc /
1482:     * Count To x For Marcas = 1) e, so entao, o SCAN que gera os dois
1483:     * lancamentos de encerramento por conta marcada - delegado a
1484:     * THIS.this_oBusinessObject.ProcessarEncerramento(), que concentra o que
1485:     * no legado era FazContra/fGerUniqueKey/fBuscarCotacao/fRecalculaS e o
1486:     * Update/Commit/RollBack de ThisForm.poDataMgr.
1487:     *
1488:     * Os 4 guards ficam no FORM (lem textbox, nao property de BO) - mesmas
1489:     * mensagens do legado, na mesma ordem. Guardados numa unica variavel
1490:     * (loc_cErro) em vez de 4 IFs encaixados, para nao passar de 3 niveis de
1491:     * aninhamento (regra de legibilidade; a ordem de avaliacao e idêntica aos
1492:     * 4 "If Empty(...) / Return 0" sequenciais do legado).
1493:     *
1494:     * Sucesso encerra igual ao legado (ThisForm.Iniciar() no fim do Click):
1495:     * THIS.LimparFiltro() zera os 8 campos do Container1 e recarrega a grade
1496:     * (que fica vazia, porque o sentinela de grupo vazio nao casa nada -
1497:     * regra CLAUDE.md #35a).
1498:     *==========================================================================
1499:     PROCEDURE BtnProcessarClick()
1500:         LOCAL loc_cGrupo, loc_cGrupoC, loc_cContaC, loc_cDope, loc_cErro, ;
1501:             loc_nSelecionadas, loc_oErro

*-- Linhas 1528 a 1546:
1528:                 loc_nSelecionadas = 0
1529: 
1530:                 IF USED(THIS.this_oBusinessObject.this_cCursorSaldos)
1531:                     SELECT (THIS.this_oBusinessObject.this_cCursorSaldos)
1532:                     COUNT TO loc_nSelecionadas FOR marcas = 1
1533:                 ENDIF
1534: 
1535:                 IF loc_nSelecionadas = 0
1536:                     MsgAviso("Nenhuma Conta Selecionada!", "Aten" + CHR(231) + CHR(227) + "o")
1537:                 ELSE
1538:                     THIS.this_oBusinessObject.this_nContasSelecionadas = loc_nSelecionadas
1539: 
1540:                     IF THIS.this_oBusinessObject.ProcessarEncerramento(loc_cGrupo, loc_cGrupoC, loc_cContaC, loc_cDope)
1541:                         MsgInfo("Encerramento processado com sucesso!", "Confirmar")
1542:                         THIS.LimparFiltro()
1543:                     ELSE
1544:                         IF !THIS.this_oBusinessObject.this_lErroExibido
1545:                             MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel processar o encerramento.", "Confirmar")
1546:                         ENDIF

