# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: QTDDFS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'LHOUVEINS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: QTDDFS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: QTDDFS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: QTDDFS

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
Select crSigOpDup
	Insert Into crSigOpDup (Dopes, CidChaves) Values (crSigCdOpe.Dopes,fUniqueIds())
Select crSigOpDup
		SELECT crSigOpDup
Select CrSigOpDup
	.Column1.ControlSource = 'crSigOpDup.QtddIs'
	.Column2.ControlSource = 'crSigOpDup.QtddFs'
	.Column3.ControlSource = 'crSigOpDup.Percs'
Select CrSigOpDup
Select CrSigOpDup
Select crSigOpDup
	Delete
	Select CrSigOpDup
	Delete For Empty(Dopes) or Empty(Qtddfs)
			m.lnErro1 = Iif(.poDataMgr.UpDate('crSigOpDup'),1,-1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpDpe.prg) - TRECHOS RELEVANTES PARA PASS SQL (2317 linhas total):

*-- Linhas 49 a 67:
49: *
50: * A operacao dona das faixas chega por PARAMETRO: o legado a lia de
51: * crSigCdOpe.Dopes porque fazia "Set DataSession to pnDataSes" para entrar na
52: * datasession do PAI. Aqui o BO faz o proprio SQLEXEC e a grade vive em
53: * cursor_4c_Dados nesta datasession, entao o acoplamento com os cursores do
54: * pai desaparece - fica so o valor (PILAR 3).
55: *
56: *------------------------------------------------------------------------------
57: * ESCOPO JA ENTREGUE
58: *
59: * Fase 1/8 (concluida) - SigOpDpeBO.prg: propriedades da linha de
60: * depreciacao (this_cCidChaves/this_cDopes/this_nQtddis/this_nQtddfs/
61: * this_nPercs) e Init().
62: *
63: * Fase 2/8 (concluida) - SigOpDpeBO.prg: ObterChavePrimaria, CarregarDoCursor,
64: * Inserir, Atualizar - CRUD completo por LINHA (uma faixa por vez), usado
65: * pelo contrato Salvar() da BusinessBase.
66: *
67: * Fase 3/8 (concluida) - estrutura base do Form: DEFINE CLASS + propriedades

*-- Linhas 170 a 188:
170: *
171: * DataSession = 2 fica DECLARADO (transcricao do dump), mas o acoplamento
172: * por "Set DataSession to pnDataSes" do legado NAO eh reproduzido: o BO
173: * (SigOpDpeBO) abre seu PROPRIO cursor via SQLEXEC nesta mesma datasession
174: * privada, entao nao ha necessidade de entrar na datasession do pai para
175: * ler crSigCdOpe.Dopes - o valor chega pronto pelo parametro par_cOperacao.
176: *
177: * this_lHouveIns/this_lHouveExcl (Thisform.lHouveIns/lHouveExcl do legado)
178: * ficam declarados no FORM, e nao no BO (ao contrario de SigOpCrdBO, que
179: * move o marcador equivalente para o BO): o dump de SIGOPDPE (RESERVED3 -
180: * ClassInfo) lista lhouveexcl/lhouveins como custom property de SIGOPDPE,
181: * ou seja, no legado elas JA SAO properties do FORM. O BO so manipula o
182: * CURSOR (InserirLinhaCursor/ExcluirLinhaCursor, sem flag); quem liga os
183: * marcadores eh o FORM (InserirLinhaCursor/CmdExcluirClick), e o guard "If
184: * (Thisform.lHouveExcl Or Thisform.lHouveIns)" do cmdSair.Click legado fica
185: * no CmdEncerrarClick do form, nao dentro de GravarFaixas.
186: *
187: * SIGOPDPE.Load (=fConfigGeral()) NAO eh reproduzido neste arquivo - mesma
188: * decisao do dialogo-irmao FormSigOpCrd.prg (e do FormSigOpCcl.prg). No

*-- Linhas 436 a 454:
436:             CASE EMPTY(ALLTRIM(THIS.this_cOperacao))
437:                 *-- Sem a operacao dona nao ha faixa a editar: o legado lia
438:                 *-- crSigCdOpe.Dopes da datasession do pai e sem isso o
439:                 *-- Insert Into SigOpDup (Dopes, ...) gravaria orfao.
440:                 THIS.this_cMotivoBloqueio = "Opera" + CHR(231) + CHR(227) + ;
441:                     "o inv" + CHR(225) + "lida. Selecione a opera" + CHR(231) + CHR(227) + ;
442:                     "o antes de editar a tabela de deprecia" + CHR(231) + CHR(227) + "o."
443:                 loc_lValido = .F.
444:         ENDCASE
445: 
446:         IF !loc_lValido
447:             MsgAviso(THIS.this_cMotivoBloqueio, "Aten" + CHR(231) + CHR(227) + "o")
448:         ENDIF
449: 
450:         RETURN loc_lValido
451:     ENDPROC
452: 
453: 
454:     *==========================================================================

*-- Linhas 469 a 492:
469: 
470:         TRY
471:             *-- Datasession privada (DataSession = 2) nasce com os SETs no
472:             *-- DEFAULT do VFP: o SET DELETED ON / SET EXACT ON do config.prg
473:             *-- ficou na sessao 1 e NAO eh herdado. FormBase.Init() repoe so
474:             *-- DATE/CENTURY. Repor os dois aqui garante o mesmo efeito do
475:             *-- SET DELETED ON global quando a grade (Fase 4) fizer DELETE
476:             *-- local na linha.
477:             SET DELETED ON
478:             SET EXACT ON
479: 
480:             *-- Business Object, com o contexto recebido do pai (operacao +
481:             *-- modo de edicao) - Fase 1/2 (CRUD por linha) + Fase 4 (cursor
482:             *-- da grade e gravacao em lote)
483:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpDpeBO", ;
484:                                                      THIS.this_cOperacao, ;
485:                                                      THIS.this_cEscolha)
486: 
487:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
488:                 *-- Titulo dinamico, como o legado:
489:                 *-- 'Tabela de Depreciacao da Operacao ' + AllTrim(Proper(Dopes))
490:                 THIS.AjustarCaption()
491: 
492:                 *-- Aparencia base do form (fundo)

*-- Linhas 514 a 532:
514:                 THIS.TornarControlesVisiveis()
515: 
516:                 *-- Carga e bind da grade: so AQUI, nunca em
517:                 *-- ConfigurarPaginaLista. Column.ControlSource exige o cursor
518:                 *-- JA ABERTO, e quando a grade eh criada nao existe cursor
519:                 *-- nenhum - atribuir ali estoura "Alias ... is not found"
520:                 *-- dentro deste TRY, InicializarForm devolve .F. e a tela nao
521:                 *-- abre, sem erro visivel (regra #41).
522:                 THIS.CarregarLista()
523: 
524:                 *-- POR ULTIMO: TornarControlesVisiveis acabou de forcar
525:                 *-- Visible = .T. em cada controle, inclusive no Excluir que o
526:                 *-- legado ESCONDE quando o usuario nao tem acesso. Ajustar
527:                 *-- antes dele seria simplesmente apagado.
528:                 THIS.AjustarBotoesPorModo()
529: 
530:                 loc_lSucesso = .T.
531:             ELSE
532:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;

*-- Linhas 894 a 967:
894:     *==========================================================================
895:     * ConfigurarGrade - GradeSubN do legado (grd_4c_Dados)
896:     *
897:     * Dump: ColumnCount=3 FontName="Tahoma" FontSize=8 DeleteMark=.F.
898:     *       Top=104 Left=159 Width=281 Height=226 RowHeight=16
899:     *       ScrollBars=2 TabIndex=1 ForeColor=0,0,0 GridLineColor=238,238,238
900:     *
901:     * O TabIndex = 1 do dump NAO eh atribuido aqui: TabIndex tem de ser
902:     * aplicado DEPOIS de todos os AddObject, senao cada AddObject seguinte
903:     * renumera os irmaos. Mora em ConfigurarPaginaDados().
904:     *
905:     * Tahoma, e nao Verdana: Verdana eh o canonico da grade de LISTA do
906:     * frmcadastro, e esta tela nao eh um cadastro paginado - o dump declara
907:     * Tahoma 8 no proprio Grid.
908:     *
909:     * Sem compensacao de +29 no Top: sem PageFrame, os Top do dump sao
910:     * absolutos (os -29 do pgf_4c_Paginas nao existem aqui).
911:     *
912:     * RecordMark: o dump declara DeleteMark = .F. e eh SILENCIOSO sobre
913:     * RecordMark (que na BaseClass grid vale .T. por default). Mesmo assim
914:     * fica .F. aqui: eh a regra do projeto para grade de form OPERACIONAL, e
915:     * o CorretorAutomatico (#58/GridRecordMarkDeleteMark) injeta .F. quando a
916:     * propriedade esta ausente. Declarar explicitamente deixa a decisao
917:     * visivel no codigo em vez de ser acrescentada em silencio no proximo
918:     * sweep.
919:     *
920:     * Nada de RecordSource / ControlSource aqui - ver CarregarLista.
921:     *==========================================================================
922:     PROTECTED PROCEDURE ConfigurarGrade()
923:         THIS.AddObject("grd_4c_Dados", "Grid")
924:         WITH THIS.grd_4c_Dados
925:             .ColumnCount    = 3
926:             .Top            = 104
927:             .Left           = 159
928:             .Width          = 281
929:             .Height         = 226
930:             .FontName       = "Tahoma"
931:             .FontSize       = 8
932:             .RowHeight      = 16
933:             .ScrollBars     = 2
934:             .ForeColor      = RGB(0, 0, 0)
935:             .GridLineColor  = RGB(238, 238, 238)
936:             .RecordMark     = .F.
937:             .DeleteMark     = .F.
938:             .Visible        = .T.
939:         ENDWITH
940: 
941:         *-- Propriedades de COLUNA num metodo proprio: elas sao reaplicadas
942:         *-- depois de cada RecordSource (ver ConfigurarColunasGrade).
943:         THIS.ConfigurarColunasGrade()
944: 
945:         RETURN .T.
946:     ENDPROC
947: 
948: 
949:     *==========================================================================
950:     * ConfigurarColunasGrade - propriedades de COLUNA, reaplicaveis
951:     *
952:     * Mexer em RecordSource (e nos ControlSource) faz o VFP RECALCULAR as
953:     * larguras para o default 90 e devolver os cabecalhos a "Header1" -
954:     * silenciosamente. Por isso tudo que eh de coluna mora aqui e este metodo
955:     * eh chamado DUAS vezes: ao criar a grade (para ela ja nascer certa) e de
956:     * novo logo depois de cada bind, em VincularGrade.
957:     *
958:     * Dump, coluna por coluna:
959:     *   Column1 "Qtd Dias Inicial" Width=100 Movable=.F. Resizable=.F.
960:     *           InputMask="9999" ForeColor=0,0,0
961:     *   Column2 "Qtd Dias Final"   Width=100 Movable=.F. Resizable=.F.
962:     *           InputMask="9999"  ForeColor=0,0,0  Text1.ReadOnly=.F.
963:     *   Column3 "%"                Width=48  InputMask="999.99" ForeColor=0,0,0
964:     *           (NAO declara Movable/Resizable - ficam no default .T.)
965:     *   Header1 de todas: Tahoma 8, Alignment=2 (centralizado)
966:     *   Text1   de todas: Tahoma 8, BorderStyle=0, Margin=0,
967:     *                     ForeColor=0,0,0, BackColor=255,255,255

*-- Linhas 1203 a 1229:
1203:     *
1204:     * Transcricao do trecho de carga do Init legado:
1205:     *     With SigCdOpe.poDatamgr
1206:     *         .ReQuery('crSigOpDup') / SELECT crSigOpDup / Go Top
1207:     *     EndWith
1208:     *     Select CrSigOpDup / Goto Top
1209:     *     If Reccount() = 0 And InList(Thisform.PcEscolha,'INSERIR','ALTERAR')
1210:     *         ThisForm.inserelinha()
1211:     *     Endif
1212:     *     With Thisform.GradeSubN
1213:     *         .RecordSource          = 'crSigOpDup'
1214:     *         .Column1.ControlSource = 'crSigOpDup.QtddIs'
1215:     *         ... .Refresh
1216:     *     EndWith
1217:     *
1218:     * A ordem eh regra: carregar -> garantir a linha de digitacao -> LIGAR a
1219:     * grade -> repintar. Ligar antes de o cursor existir estoura o Init
1220:     * (regra #41), e repintar sem o GO TOP deixa a grade visualmente vazia
1221:     * com o cursor cheio (regra #21).
1222:     *
1223:     * Sem SetFocus na Column1 aqui, embora o inserelinha legado o faca: este
1224:     * caminho roda dentro do Init, com o form ainda invisivel, e SetFocus em
1225:     * controle de form nao mostrado falha. O foco inicial eh assunto do fluxo
1226:     * interativo de insercao de linha (ver InserirLinha).
1227:     *
1228:     * PUBLIC: o harness chama THIS.oForm.CarregarLista() de fora (regra #3).
1229:     *==========================================================================

*-- Linhas 1262 a 1353:
1262: 
1263:             *-- GO TOP + Refresh: popular o cursor NAO repinta a grade.
1264:             IF USED(loc_cAlias)
1265:                 SELECT (loc_cAlias)
1266:                 GO TOP
1267:             ENDIF
1268:             THIS.RepintarGrade()
1269:         CATCH TO loc_oErro
1270:             THIS.this_cMensagemErro = loc_oErro.Message
1271:             MsgErro("Erro ao carregar a tabela de deprecia" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
1272:                     loc_oErro.Message + CHR(13) + ;
1273:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1274:                     "Procedure: " + loc_oErro.Procedure, ;
1275:                     "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
1276:             loc_lSucesso = .F.
1277:         ENDTRY
1278: 
1279:         RETURN loc_lSucesso
1280:     ENDPROC
1281: 
1282: 
1283:     *==========================================================================
1284:     * VincularGrade - RecordSource + ControlSource das 3 colunas
1285:     *
1286:     * Transcricao do With Thisform.GradeSubN do Init legado, com os mesmos
1287:     * pares coluna/campo:
1288:     *     Column1 -> QtddIs    Column2 -> QtddFs    Column3 -> Percs
1289:     *
1290:     * ColumnCount eh reposto ANTES do RecordSource porque o cursor tem SEIS
1291:     * colunas (as cinco de SigOpDup mais o marcador lnovos) e sem ele a
1292:     * grade se auto-expande para todas - o usuario veria cidchaves, dopes e
1293:     * lnovos na tela. O guard IF != 3 existe porque atribuir ColumnCount
1294:     * RECRIA os objetos Column, descartando tudo o que foi posto neles;
1295:     * reatribuir o mesmo valor sem necessidade so cria risco.
1296:     *
1297:     * ConfigurarColunasGrade() por ULTIMO: RecordSource e ControlSource
1298:     * acabaram de devolver as larguras ao default 90 e os cabecalhos a
1299:     * "Header1".
1300:     *
1301:     * PUBLIC porque tambem eh o ponto de religacao quando o BO avisa, por
1302:     * this_lCursorRecriado, que FECHOU e recriou o alias - fechar o alias
1303:     * derruba o binding da grade EM SILENCIO.
1304:     *==========================================================================
1305:     PROCEDURE VincularGrade()
1306:         LOCAL loc_lSucesso, loc_cAlias, loc_oGrade, loc_oErro
1307: 
1308:         loc_lSucesso = .F.
1309: 
1310:         IF VARTYPE(THIS.this_oBusinessObject) != "O" ;
1311:            OR !PEMSTATUS(THIS, "grd_4c_Dados", 5)
1312:             RETURN .F.
1313:         ENDIF
1314: 
1315:         loc_cAlias = ALLTRIM(THIS.this_oBusinessObject.this_cCursorDados)
1316:         loc_oGrade = THIS.grd_4c_Dados
1317: 
1318:         IF !USED(loc_cAlias)
1319:             *-- Sem cursor nao ha o que ligar, e atribuir ControlSource agora
1320:             *-- estouraria "Alias ... is not found".
1321:             RETURN .F.
1322:         ENDIF
1323: 
1324:         TRY
1325:             *-- ColumnCount e RecordSource FORA do WITH: colunas recriadas por
1326:             *-- ColumnCount nao ficam disponiveis de forma confiavel dentro do
1327:             *-- mesmo bloco WITH que acabou de abrir, e o acesso a .ColumnN
1328:             *-- logo depois estouraria "Unknown member COLUMNN".
1329:             IF loc_oGrade.ColumnCount != 3
1330:                 loc_oGrade.ColumnCount = 3
1331:             ENDIF
1332: 
1333:             loc_oGrade.RecordSource = loc_cAlias
1334: 
1335:             WITH loc_oGrade
1336:                 .Column1.ControlSource = loc_cAlias + ".qtddis"
1337:                 .Column2.ControlSource = loc_cAlias + ".qtddfs"
1338:                 .Column3.ControlSource = loc_cAlias + ".percs"
1339:             ENDWITH
1340: 
1341:             *-- Larguras e cabecalhos DEPOIS do bind, sempre
1342:             THIS.ConfigurarColunasGrade()
1343: 
1344:             *-- Celulas com evento DEPOIS de ConfigurarColunasGrade: o
1345:             *-- ColumnCount acima pode ter RECRIADO os objetos Column, e com
1346:             *-- eles o CurrentControl e o TextBox instalado.
1347:             THIS.InstalarCelulasDpe(loc_oGrade)
1348: 
1349:             THIS.this_oBusinessObject.this_lCursorRecriado = .F.
1350: 
1351:             loc_lSucesso = .T.
1352:         CATCH TO loc_oErro
1353:             THIS.this_cMensagemErro = loc_oErro.Message

*-- Linhas 1584 a 1607:
1584:     *
1585:     * Legado, LITERAL:
1586:     *     PROCEDURE LostFocus
1587:     *     Select CrSigOpDup
1588:     *     Locate for Qtddfs = 0
1589:     *     If Eof()
1590:     *         Thisform.Inserelinha()
1591:     *     EndIf
1592:     *     Select CrSigOpDup
1593:     *
1594:     * % eh a ULTIMA coluna: ao sair dela o legado garante que exista sempre
1595:     * UMA linha em branco esperando digitacao - se nenhuma linha tem
1596:     * Qtddfs = 0, ele cria. Eh assim que o usuario acrescenta faixas sem
1597:     * nenhum botao de "inserir": preenche a linha e a proxima aparece.
1598:     *
1599:     * Esse LOCATE eh tambem o que, na pratica, liga o marcador de alteracao a
1600:     * gravar que o Encerrar consulta - as linhas vindas do servidor nunca tem
1601:     * Qtddfs = 0, entao InserirLinha roda e marca this_lHouveIns. Por isso
1602:     * adiar este handler deixaria a tela gravando MENOS do que o legado
1603:     * grava.
1604:     *
1605:     * O LOCATE roda sobre o CURSOR (nao sobre par_oTxt.Value): aqui a
1606:     * pergunta eh "existe linha em branco na grade?", nao "o que foi
1607:     * digitado?".

*-- Linhas 1639 a 1702:
1639:         ENDIF
1640: 
1641:         TRY
1642:             SELECT (loc_cAlias)
1643:             LOCATE FOR qtddfs = 0
1644: 
1645:             IF EOF()
1646:                 loc_lPrecisaLinha = .T.
1647:             ENDIF
1648: 
1649:             IF loc_lPrecisaLinha
1650:                 THIS.InserirLinha()
1651:             ENDIF
1652: 
1653:             *-- Select final do legado: o LOCATE pode ter deixado o alias
1654:             *-- corrente em outro lugar e o resto da tela conta com este.
1655:             IF USED(loc_cAlias)
1656:                 SELECT (loc_cAlias)
1657:             ENDIF
1658:         CATCH TO loc_oErro
1659:             THIS.this_cMensagemErro = loc_oErro.Message
1660:             MsgErro("Erro ao sair do campo %:" + CHR(13) + ;
1661:                     loc_oErro.Message + CHR(13) + ;
1662:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1663:                     "Procedure: " + loc_oErro.Procedure, ;
1664:                     "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
1665:         ENDTRY
1666: 
1667:         RETURN .T.
1668:     ENDPROC
1669: 
1670: 
1671:     *==========================================================================
1672:     * InserirLinhaCursor - marcador + delegacao da parte de DADOS do
1673:     * inserelinha legado
1674:     *
1675:     * Legado:
1676:     *     Thisform.lHouveIns = .T.
1677:     *     Select crSigOpDup
1678:     *     Locate for Qtddfs=0
1679:     *     If Eof()
1680:     *         Insert Into crSigOpDup (Dopes, CidChaves) ;
1681:     *             Values (crSigCdOpe.Dopes, fUniqueIds())
1682:     *     EndIf
1683:     *
1684:     * O marcador lHouveIns eh property do FORM (RESERVED3 do dump o lista
1685:     * como custom property de SIGOPDPE, nao do BO) e eh ligado
1686:     * INCONDICIONALMENTE, ANTES do LOCATE - vale mesmo quando a linha em
1687:     * branco ja existia e o INSERT nao roda. Transcrito como esta, e nao
1688:     * "corrigido", porque mexer nisso mudaria quais edicoes chegam a ser
1689:     * gravadas pelo Encerrar.
1690:     *
1691:     * Usado por DOIS chamadores: CarregarLista (carga inicial, sem
1692:     * navegacao de tela) e InserirLinha (fluxo interativo, com
1693:     * Keyboard/Refresh/SetFocus). Os dois precisam do MESMO marcador ligado,
1694:     * por isso ele mora aqui e nao soh no wrapper de tela.
1695:     *
1696:     * PUBLIC: chamado por CarregarLista, por InserirLinha e pelo harness.
1697:     *==========================================================================
1698:     PROCEDURE InserirLinhaCursor()
1699:         THIS.this_lHouveIns = .T.
1700: 
1701:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1702:             RETURN .F.

*-- Linhas 1712 a 1741:
1712:     * Legado COMPLETO:
1713:     *     PROCEDURE inserelinha
1714:     *     Thisform.lHouveIns = .T.
1715:     *     Select crSigOpDup
1716:     *     Locate for Qtddfs=0
1717:     *     If Eof()
1718:     *         Insert Into crSigOpDup (Dopes, CidChaves) ;
1719:     *             Values (crSigCdOpe.Dopes, fUniqueIds())
1720:     *     EndIf
1721:     *     Select crSigOpDup
1722:     *     Keyboard '{DNARROW}'
1723:     *     ThisForm.GradeSubN.Refresh
1724:     *     Thisform.GradeSubN.Column1.SetFocus
1725:     *
1726:     * A parte de DADOS (marcador + LOCATE + INSERT) esta em
1727:     * InserirLinhaCursor. Aqui ficam as TRES ultimas linhas, que sao de tela
1728:     * e que o migrador costuma descartar junto com o resto do handler - e sao
1729:     * elas que tornam a linha nova USAVEL: sem o Refresh a grade continua
1730:     * mostrando o cursor antigo (popular cursor NAO repinta a grade, regra
1731:     * #21a) e sem o SetFocus o usuario tem de ir com o mouse ate a primeira
1732:     * coluna da linha nova.
1733:     *
1734:     * O Keyboard '{DNARROW}' eh transcrito como esta: ele enfileira a tecla
1735:     * para DEPOIS deste metodo, e eh o que leva o cursor da grade para a
1736:     * linha recem-criada.
1737:     *
1738:     * SetFocus so com o form MOSTRADO: este metodo tambem eh alcancavel pelo
1739:     * caminho de carga via InserirLinhaCursor direto (CarregarLista NAO
1740:     * chama InserirLinha), onde o form ainda nao foi exibido e o SetFocus
1741:     * falharia.

*-- Linhas 1778 a 1809:
1778:     * CmdExcluirClick - cmdExcluir.Click do legado
1779:     *
1780:     * Legado:
1781:     *     Select crSigOpDup
1782:     *     If Not Eof()
1783:     *         Thisform.lHouveExcl = .T.
1784:     *         Delete / Skip / Skip - 1
1785:     *     Endif
1786:     *     ThisForm.GradeSubN.Refresh
1787:     *
1788:     * A parte de DADOS (DELETE e reposicionamento do ponteiro) mora em
1789:     * ExcluirLinhaCursor, no BO, que devolve .T. exatamente quando a mesma
1790:     * condicao "Not Eof()" do legado abriu o bloco - eh esse retorno que
1791:     * decide se o marcador do FORM (lHouveExcl) eh ligado. O Refresh vem FORA
1792:     * do IF, como no legado: ele repinta tambem quando nada foi excluido.
1793:     *
1794:     * A remocao eh LOCAL - no legado o DELETE so chega ao servidor junto com
1795:     * a gravacao do Encerrar, e eh isso que GravarFaixas (BO) reproduz. Nao
1796:     * ha confirmacao porque o legado nao pede nenhuma, e o Encerrar eh a
1797:     * ultima chance de desistir (fechar sem clicar nele descarta tudo).
1798:     *==========================================================================
1799:     PROCEDURE CmdExcluirClick()
1800:         LOCAL loc_lExcluiu
1801: 
1802:         loc_lExcluiu = .F.
1803: 
1804:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1805:             loc_lExcluiu = THIS.this_oBusinessObject.ExcluirLinhaCursor()
1806:         ENDIF
1807: 
1808:         IF loc_lExcluiu
1809:             THIS.this_lHouveExcl = .T.

*-- Linhas 1820 a 1840:
1820:     *
1821:     * Legado:
1822:     *     If ( Thisform.lHouveExcl Or Thisform.lHouveIns )
1823:     *         ... Delete For Empty(Dopes) or Empty(Qtddfs)
1824:     *         ... Replace CidChaves with fUniqueIds() For Empty(CidChaves)
1825:     *         ... poDataMgr.UpDate / Commit / RollBack
1826:     *         If Not m.lnErro1>0
1827:     *             = MessageBox('Erro na Gravacao dos Dados do Cadastro de Operacoes.',48)
1828:     *         EndIf
1829:     *     EndIf
1830:     *     Thisform.ParentForm.Enabled = .T.
1831:     *     ThisForm.Release
1832:     *
1833:     * O guard "Thisform.lHouveExcl Or Thisform.lHouveIns" eh property do
1834:     * FORM (ver cabecalho do arquivo) e fica AQUI, e nao no BO: sem
1835:     * insercao nem exclusao, o Encerrar apenas devolve o foco ao form pai e
1836:     * fecha, sem tocar no banco.
1837:     *
1838:     * TRANSCRICAO FIEL, inclusive no ponto incomodo: o legado LIBERA O PAI E
1839:     * FECHA A TELA MESMO QUANDO A GRAVACAO FALHA - o RollBack desfaz no
1840:     * servidor, a MessageBox avisa, e o que foi digitado se perde. Fica igual

*-- Linhas 1886 a 1904:
1886:     *==========================================================================
1887:     * FormParaBO - leva a LINHA CORRENTE da grade para as properties do BO
1888:     *
1889:     * Nesta tela nao ha campo solto: as tres colunas tem ControlSource, logo
1890:     * "o campo da tela" EH a linha do cursor. A transferencia tem, por isso,
1891:     * duas partes:
1892:     *
1893:     *   1. FLUSH da celula em edicao. O valor que o usuario acabou de digitar
1894:     *      vive em <celula>.Value e so chega ao cursor quando o foco SAI da
1895:     *      celula (regra #46). Sem este passo, gravar com o cursor ainda
1896:     *      dentro da celula perderia a ultima digitacao - sem erro e sem log.
1897:     *   2. CarregarDoCursor: a linha inteira (as tres colunas visiveis mais
1898:     *      cidchaves e dopes, que nao aparecem na tela) vai para o BO. A
1899:     *      lista de colunas fica, assim, em UM lugar so - o BO.
1900:     *
1901:     * ActiveColumn devolve 0 enquanto a grade nunca recebeu foco (property
1902:     * conferida em automation\propriedades_baseclasses.txt - regra #33); o
1903:     * guard de 1..3 cobre esse caso e tambem um ColumnCount diferente de 3.
1904:     *

*-- Linhas 1935 a 1953:
1935:         loc_oGrade = THIS.grd_4c_Dados
1936: 
1937:         TRY
1938:             SELECT (loc_cAlias)
1939: 
1940:             IF !EOF()
1941:                 loc_nAtiva = loc_oGrade.ActiveColumn
1942: 
1943:                 IF loc_nAtiva >= 1 AND loc_nAtiva <= 3 ;
1944:                    AND loc_nAtiva <= loc_oGrade.ColumnCount
1945:                     loc_oColuna   = loc_oGrade.Columns(loc_nAtiva)
1946:                     loc_cControle = ALLTRIM(NVL(loc_oColuna.CurrentControl, ""))
1947:                     loc_oCelula   = .NULL.
1948: 
1949:                     *-- Membro alcancado por NOME: EVALUATE na LEITURA, nunca
1950:                     *-- Controls(<nome>) - Controls eh indexado por NUMERO e o
1951:                     *-- nome estoura em runtime (regra #34).
1952:                     IF !EMPTY(loc_cControle) ;
1953:                        AND PEMSTATUS(loc_oColuna, loc_cControle, 5)

*-- Linhas 2004 a 2032:
2004:     * BOParaForm - escreve as properties do BO na LINHA CORRENTE da grade
2005:     *
2006:     * Sentido inverso do FormParaBO, com o MESMO par coluna/campo de
2007:     * VincularGrade. Como as colunas tem ControlSource, escrever no CURSOR eh
2008:     * escrever "no campo da tela" - nao existe .Value avulso a atualizar; o
2009:     * que falta depois eh so repintar, porque mexer no cursor NAO repinta a
2010:     * grade (regra #21).
2011:     *
2012:     * SO as TRES colunas visiveis sao escritas. cidchaves e dopes ficam de
2013:     * fora de proposito: eles sao a IDENTIDADE da linha (a chave gerada por
2014:     * fUniqueIds no InserirLinhaCursor e a operacao dona das faixas), nao
2015:     * campos de tela. Sobrescreve-los aqui trocaria a linha de registro - ou,
2016:     * pior, a deixaria com dopes vazio, que eh justamente o que o
2017:     * "Delete For Empty(Dopes)" do Encerrar legado joga fora.
2018:     *
2019:     * GUARDA DE IDENTIDADE: com this_cCidChaves preenchido, a escrita so
2020:     * acontece se a linha corrente for essa mesma. O BO eh carregado linha a
2021:     * linha pelo SCAN de GravarFaixas, entao sem essa conferencia uma chamada
2022:     * fora de hora escreveria os valores de uma faixa sobre outra. Com
2023:     * this_cCidChaves VAZIO (o que LimparDados produz) a guarda nao se
2024:     * aplica: ali a intencao eh justamente zerar a linha corrente.
2025:     *
2026:     * PROTECTED EXPLICITO pelo mesmo motivo do FormParaBO: FormBase declara
2027:     * PROTECTED PROCEDURE BOParaForm e o escopo vem da HERANCA - omitir o
2028:     * modificador nao alarga nada (regra #51).
2029:     *==========================================================================
2030:     PROTECTED PROCEDURE BOParaForm()
2031:         LOCAL loc_lSucesso, loc_cAlias, loc_oBO, loc_cChaveBO, loc_oErro
2032: 

*-- Linhas 2045 a 2063:
2045:         ENDIF
2046: 
2047:         TRY
2048:             SELECT (loc_cAlias)
2049: 
2050:             DO CASE
2051:             CASE EOF()
2052:                 *-- Sem linha corrente nao ha o que escrever.
2053:                 loc_lSucesso = .F.
2054: 
2055:             CASE !EMPTY(loc_cChaveBO) ;
2056:                  AND ALLTRIM(NVL(cidchaves, "")) != loc_cChaveBO
2057:                 *-- A linha corrente nao eh a que o BO carregou.
2058:                 loc_lSucesso = .F.
2059: 
2060:             OTHERWISE
2061:                 REPLACE qtddis WITH loc_oBO.this_nQtddis, ;
2062:                         qtddfs WITH loc_oBO.this_nQtddfs, ;
2063:                         percs  WITH loc_oBO.this_nPercs   ;

*-- Linhas 2172 a 2190:
2172:     *
2173:     * A linha em branco desta tela eh, por definicao do legado, a que tem
2174:     * qtddfs = 0: eh esse o criterio do "Locate for Qtddfs=0" do inserelinha,
2175:     * do LostFocus da Column3 e do "Delete For ... Empty(Qtddfs)" do
2176:     * Encerrar. Limpar a linha corrente eh, portanto, zerar as tres colunas
2177:     * visiveis - e eh exatamente o estado em que InserirLinhaCursor cria uma
2178:     * linha nova.
2179:     *
2180:     * Composto a partir dos dois hooks, sem duplicar a lista de campos: o BO
2181:     * zera as properties (LimparDados preserva this_cOperacao, entao dopes
2182:     * continua resolvido) e BOParaForm leva isso para a linha e repinta. Como
2183:     * LimparDados tambem esvazia this_cCidChaves, a guarda de identidade do
2184:     * BOParaForm fica fora de alcance e a escrita atinge a linha CORRENTE,
2185:     * que eh a intencao aqui.
2186:     *
2187:     * cidchaves e dopes da LINHA nao sao tocados - a linha continua sendo a
2188:     * mesma, so vazia. Zerar a chave faria a linha perder identidade e o
2189:     * Encerrar a trataria como lixo a descartar.
2190:     *


### BO (C:\4c\projeto\app\classes\SigOpDpeBO.prg):
*==============================================================================
* SigOpDpeBO.prg
*
* Business Object para a Tabela de Depreciacao da Operacao (dialogo modal
* aberto a partir da grade de operacoes do Cadastro de Operacoes - SigCdOpe),
* onde o usuario mantem as faixas de dias (Qtd Dias Inicial / Qtd Dias Final)
* e o percentual de depreciacao aplicado a cada faixa.
*
* Tabela gravada: SigOpDup (chave: cidchaves char(20)):
*
*    [cidchaves] char(20)      NOT NULL   (PK)
*    [dopes]     char(20)      NOT NULL   - operacao dona (SigCdOpe.dopes)
*    [qtddis]    numeric(4,0)  NOT NULL   - Column1 "Qtd Dias Inicial"
*    [qtddfs]    numeric(4,0)  NOT NULL   - Column2 "Qtd Dias Final"
*    [percs]     numeric(5,2)  NOT NULL   - Column3 "%"
*
*------------------------------------------------------------------------------
* MODELO DE GRAVACAO (transcrito do legado)
*
* A tela NAO grava linha a linha: ela acumula as alteracoes no cursor da
* grade (crSigOpDup no legado, cursor_4c_Dados aqui) e persiste TUDO de uma
* vez ao encerrar, no cmdSair.Click:
*
*    Select CrSigOpDup
*    Go Top
*    Delete For Empty(Dopes) or Empty(Qtddfs)
*    Replace CidChaves with fUniqueIds() For Empty(CidChaves)
*    ... poDataMgr.UpDate('crSigOpDup') / Commit() / RollBack()
*
* Os dois marcadores lHouveIns / lHouveExcl do legado SAO properties do FORM
* (RESERVED3 do dump lista lhouveexcl/lhouveins como custom property de
* SIGOPDPE, nao do BO) - por isso ficam em FormSigOpDpe (this_lHouveIns/
* this_lHouveExcl), e este BO so executa a manipulacao de DADOS: quem decide
* se a gravacao chega a ser tentada eh o CmdEncerrarClick do form.
*
* IMPORTANTE (regra #22): as CINCO colunas de SigOpDup sao NOT NULL e nenhuma
* tem DEFAULT (conferido em docs/schema.sql, UTF-16, lido com
* Get-Content -Raw). A gravacao cobre todas as cinco.
*
*------------------------------------------------------------------------------
* NOTA DE ARQUITETURA
*
* O legado nao tem botao de Alterar nem de Buscar: a grade ja abre editavel
* e o unico botao de acao, alem do Encerrar, eh o Excluir (apaga a linha
* corrente do cursor). A remocao definitiva no servidor acontece junto com a
* gravacao do Encerrar, por reconciliacao do conjunto de linhas da operacao,
* e nao por um DELETE disparado a cada clique: ExcluirLinhaCursor apenas marca
* a linha, e GravarFaixas traduz essa marca em DELETE no servidor, dentro do
* mesmo lote transacional dos INSERT e UPDATE. ExecutarExclusao existe e usa o
* MESMO montador de SQL, para o caso de apagar uma faixa isolada pelo
* Excluir() da BusinessBase - assim a lista de colunas e o criterio da chave
* nao podem divergir entre os dois caminhos.
*
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS SigOpDpeBO AS BusinessBase

	*--------------------------------------------------------------------------
	* PROPRIEDADES DA ENTIDADE - SigOpDup
	*--------------------------------------------------------------------------
	this_cCidChaves = ""   && cidchaves char(20)     - PK (fUniqueIds)
	this_cDopes     = ""   && dopes     char(20)     - operacao dona
	this_nQtddis    = 0    && qtddis    numeric(4,0) - Column1 "Qtd Dias Inicial"
	this_nQtddfs    = 0    && qtddfs    numeric(4,0) - Column2 "Qtd Dias Final"
	this_nPercs     = 0    && percs     numeric(5,2) - Column3 "%"

	*--------------------------------------------------------------------------
	* CONTEXTO RECEBIDO DO FORM PAI
	*
	* Legado: lcOperacao = crSigCdOpe.Dopes, lido no Init a partir do cursor
	* da operacao que o cadastro de Tipos de Operacao mantem aberto. Aqui o
	* valor chega por parametro e fica guardado nesta property, que eh a
	* FONTE UNICA da coluna dopes de toda linha nova.
	*--------------------------------------------------------------------------
	this_cOperacao = ""         && Dopes da operacao corrente (contexto)
	this_cEscolha  = "INSERIR"  && PcEscolha: INSERIR / ALTERAR / PROCURAR

	*--------------------------------------------------------------------------
	* PERMISSAO DE EXCLUSAO
	*
	* Legado: .cmdExcluir.Visible = fChecaAcesso('SigOpDup','EXCLUIR') And ;
	*                               InList(PcEscolha,'INSERIR','ALTERAR')
	* Resolvida uma vez e guardada aqui, para o form apenas espelhar no
	* Visible/Enabled do botao.
	*--------------------------------------------------------------------------
	this_lPodeExcluir = .F.

	*--------------------------------------------------------------------------
	* CURSORES DE TRABALHO
	*
	* this_cCursorDados eh o alias ligado ao RecordSource da grade - o mesmo
	* papel do crSigOpDup legado. NUNCA receber SQLEXEC direto: SQLEXEC sobre
	* o alias de um Grid fecha e recria o alias, zerando ColumnCount e
	* deixando a grade um retangulo branco. A carga passa por
	* this_cCursorTemp e eh transferida com ZAP + APPEND FROM DBF().
	*
	* A grade tem coluna EDITAVEL, portanto o cursor de dados precisa ser
	* READWRITE - cursor de SQL pass-through nasce somente-leitura e o
	* REPLACE da edicao estouraria.
	*--------------------------------------------------------------------------
	this_cCursorDados = "cursor_4c_Dados"       && alias do Grid (READWRITE)
	this_cCursorTemp  = "cursor_4c_DadosTmp"    && destino do SQLEXEC

	*--------------------------------------------------------------------------
	* ACOMPANHAMENTO DA GRAVACAO
	*--------------------------------------------------------------------------
	this_nRegistrosInseridos   = 0
	this_nRegistrosAtualizados = 0
	this_nRegistrosExcluidos   = 0

	*--------------------------------------------------------------------------
	* LOTE DE COMANDOS SQL
	*
	* A gravacao do Encerrar abrange varias linhas e tem de ser ATOMICA, como
	* o par Update/Commit-RollBack do poDataMgr legado. Os comandos sao
	* acumulados aqui e executados num unico bloco transacional.
	*--------------------------------------------------------------------------
	this_cLoteGravacao = ""

	*--------------------------------------------------------------------------
	* COLUNAS DO CURSOR DA GRADE - fonte UNICA
	*
	* lnovos NAO eh coluna de SigOpDup: eh o marcador de linha ainda nao
	* gravada no servidor. O legado obtinha essa distincao de graca, porque o
	* crSigOpDup era cursor REMOTO e o poDataMgr.UpDate sabia separar INSERT
	* de UPDATE de DELETE. Aqui a grade vive num CREATE CURSOR comum, logo a
	* distincao tem de ser carregada explicitamente.
	*--------------------------------------------------------------------------
	this_cColunasTabela = "cidchaves,dopes,qtddis,qtddfs,percs"
	this_cColunaNovos   = "lnovos"

	*--------------------------------------------------------------------------
	* CONTROLE DA TRANSACAO DO LOTE
	*
	* BEGIN/COMMIT enviados em SQLEXEC separados NAO protegem nada neste
	* ambiente: a conexao nasce com Transactions = 2 e @@TRANCOUNT ja vale 1,
	* portanto um BEGIN proprio apenas ANINHA e o COMMIT correspondente volta
	* para 1 sem efetivar. Dai o SAVE TRANSACTION com nome proprio quando ja
	* ha transacao aberta e o THROW no CATCH, que faz o erro chegar ao
	* retorno do SQLEXEC e deixa CapturarErroSQL() com o texto real do SQL
	* Server.
	*--------------------------------------------------------------------------
	this_cNomeSavepoint = "SigOpDpe4c"

	*--------------------------------------------------------------------------
	* this_lCursorRecriado - avisa ao form que o alias do Grid foi FECHADO e
	* criado de novo, e que portanto RecordSource e os ControlSource das
	* Columns precisam ser religados.
	*--------------------------------------------------------------------------
	this_lCursorRecriado = .F.

	*==========================================================================
	* Init - Inicializa Business Object
	*
	* par_cOperacao - Dopes da operacao dona das faixas (crSigCdOpe.Dopes no
	*                 legado). Opcional: o form pode informar depois, pela
	*                 property this_cOperacao, antes da primeira carga.
	* par_cEscolha  - PcEscolha herdado do form pai. Vazio equivale a
	*                 "INSERIR", como o IIF(EMPTY(...)) do legado.
	*==========================================================================
	PROCEDURE Init(par_cOperacao, par_cEscolha)
		LOCAL loc_lSucesso, loc_cOperacao, loc_cEscolha, loc_oErro
		loc_lSucesso = .F.

		TRY
			DODEFAULT()

			THIS.this_cTabela     = "SigOpDup"
			THIS.this_cCampoChave = "cidchaves"

			loc_cOperacao = ""
			IF VARTYPE(par_cOperacao) = "C"
				loc_cOperacao = ALLTRIM(par_cOperacao)
			ENDIF
			THIS.this_cOperacao = loc_cOperacao
			THIS.this_cDopes    = loc_cOperacao

			loc_cEscolha = ""
			IF VARTYPE(par_cEscolha) = "C"
				loc_cEscolha = UPPER(ALLTRIM(par_cEscolha))
			ENDIF
			IF EMPTY(loc_cEscolha)
				loc_cEscolha = "INSERIR"
			ENDIF
			THIS.this_cEscolha = loc_cEscolha

			*-- Permissao de exclusao: fChecaAcesso + modo editavel (legado)
			THIS.this_lPodeExcluir = fChecaAcesso("SigOpDup", "EXCLUIR") ;
									  AND INLIST(THIS.this_cEscolha, "INSERIR", "ALTERAR")

			THIS.this_nRegistrosInseridos   = 0
			THIS.this_nRegistrosAtualizados = 0
			THIS.this_nRegistrosExcluidos   = 0
			THIS.this_cLoteGravacao         = ""

			loc_lSucesso = .T.
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "SigOpDpeBO.Init")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* InicializarValoresPadrao - defaults da LINHA NOVA
	*
	* Transcricao do Insert Into do inserelinha legado:
	*    Insert Into crSigOpDup (Dopes, CidChaves) ;
	*        Values (crSigCdOpe.Dopes, fUniqueIds())
	*==========================================================================
	PROTECTED PROCEDURE InicializarValoresPadrao()
		THIS.this_cCidChaves = fUniqueIds()
		THIS.this_cDopes     = ALLTRIM(NVL(THIS.this_cOperacao, ""))
		THIS.this_nQtddis    = 0
		THIS.this_nQtddfs    = 0
		THIS.this_nPercs     = 0

		RETURN .T.
	ENDPROC

	*==========================================================================
	* ObterChavePrimaria - Retorna a chave (cidchaves) da faixa para
	* auditoria (regra #51 - PROTECTED, so o Excluir()/Salvar() da base
	* chamam)
	*==========================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(NVL(THIS.this_cCidChaves, ""))
	ENDPROC


	*==========================================================================
	* CriarCursorDados - prepara o cursor READWRITE ligado ao Grid
	*
	* O cursor TEM de ser READWRITE: a grade desta tela eh editavel e cursor
	* de SQL pass-through nasce SOMENTE-LEITURA - o REPLACE da edicao
	* estouraria. Por isso o alias da grade nunca recebe SQLEXEC: a carga
	* passa pelo cursor temporario (ver CarregarFaixas).
	*
	* Ponto UNICO de CREATE CURSOR desta tela. A ordem e a grafia das colunas
	* tem de ser identicas em todo lugar que mencione o cursor, porque o
	* APPEND FROM DBF() casa por NOME.
	*
	* Larguras conferidas em docs/schema.sql: numeric(4,0) sem decimal eh
	* N(4,0); numeric(5,2) sao 3 digitos + 2 decimais, que em VFP (onde a
	* largura inclui o ponto) eh N(6,2). Batem com os InputMask do SCX
	* legado ("9999" e "999.99").
	*
	* par_lForcarRecriar - .T. derruba e recria o alias mesmo que ele exista.
	*                      Quem chamar assim fica responsavel por religar o
	*                      Grid; this_lCursorRecriado avisa que eh o caso.
	*==========================================================================
	PROCEDURE CriarCursorDados(par_lForcarRecriar)
		LOCAL loc_lSucesso, loc_lRecriar, loc_cAlias, loc_oErro

		loc_lSucesso = .F.
		loc_cAlias   = ALLTRIM(THIS.this_cCursorDados)

		THIS.this_lCursorRecriado = .F.

		TRY
			loc_lRecriar = .T.

			IF USED(loc_cAlias)
				loc_lRecriar = .F.

				IF VARTYPE(par_lForcarRecriar) = "L" AND par_lForcarRecriar
					loc_lRecriar = .T.
				ENDIF

				*-- Alias herdado de outra tela com estrutura diferente eh pior
				*-- que alias ausente: o ZAP apaga as linhas mas PRESERVA as
				*-- colunas do dono anterior, e o APPEND seguinte falha por
				*-- coluna que esta tela nem conhece.
				IF !loc_lRecriar
					IF !THIS.CursorTemEstruturaEsperada(loc_cAlias)
						loc_lRecriar = .T.
					ENDIF
				ENDIF

				IF loc_lRecriar
					USE IN (loc_cAlias)
				ENDIF
			ENDIF

			IF loc_lRecriar
				CREATE CURSOR (loc_cAlias) ( ;
					cidchaves C(20), ;
					dopes     C(20), ;
					qtddis    N(4, 0), ;
					qtddfs    N(4, 0), ;
					percs     N(6, 2), ;
					lnovos    L )

				THIS.this_lCursorRecriado = .T.
			ENDIF

			*-- SET DELETED eh escopado por data session e o form eh
			*-- DataSession = 2: o SET DELETED ON do config.prg roda na sessao
			*-- 1 e NAO alcanca a sessao privada, que nasce com DELETED OFF.
			*-- Sem repor aqui, o DELETE do botao Excluir apenas MARCA a linha
			*-- e ela continua aparecendo na grade - o usuario clica Excluir e
			*-- nada some, sem erro e sem log.
			SET DELETED ON

			loc_lSucesso = .T.
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro("Erro ao preparar o cursor da tabela de deprecia" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
				loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* CursorTemEstruturaEsperada - confere se o alias tem as colunas desta tela
	*
	* PEMSTATUS NAO serve para isto: o primeiro argumento tem de ser OBJETO, e
	* passar nome de cursor dispara "Function argument value, type, or count
	* is invalid.". Campo de cursor se confere com TYPE(alias + ".campo").
	*==========================================================================
	PROTECTED FUNCTION CursorTemEstruturaEsperada(par_cAlias)
		LOCAL loc_lOk, loc_cLista, loc_cAlias, loc_cCampo, loc_nI, loc_nTotal

		loc_lOk    = .T.
		loc_cAlias = ALLTRIM(NVL(par_cAlias, ""))
		loc_cLista = ALLTRIM(THIS.this_cColunasTabela) + "," + ALLTRIM(THIS.this_cColunaNovos)

		IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
			loc_lOk = .F.
		ELSE
			loc_nTotal = OCCURS(",", loc_cLista) + 1

			FOR loc_nI = 1 TO loc_nTotal
				loc_cCampo = ALLTRIM(GETWORDNUM(loc_cLista, loc_nI, ","))

				IF !EMPTY(loc_cCampo)
					IF TYPE(loc_cAlias + "." + loc_cCampo) = "U"
						loc_lOk = .F.
						EXIT
					ENDIF
				ENDIF
			ENDFOR
		ENDIF

		RETURN loc_lOk
	ENDFUNC

	*==========================================================================
	* CarregarFaixas - traz as faixas de depreciacao da operacao corrente
	*
	* Equivale ao trecho de carga do Init legado:
	*     With SigCdOpe.poDatamgr
	*         .ReQuery('crSigOpDup') / SELECT crSigOpDup / Go Top
	*     EndWith
	*
	* O SELECT vai para um cursor TEMPORARIO e o conteudo eh transferido com
	* ZAP + APPEND FROM DBF(). SQLEXEC direto sobre o alias do Grid FECHA e
	* RECRIA o alias, zerando ColumnCount: a grade viraria um retangulo
	* branco sem cabecalho e sem coluna, e nada a religaria depois.
	*
	* Filtro por dopes, como o cursor parametrizado do legado - esta tela
	* edita as faixas de UMA operacao. Sem operacao no contexto, cursor vazio
	* eh o resultado CERTO.
	*==========================================================================
	PROCEDURE CarregarFaixas()
		LOCAL loc_lSucesso, loc_lProsseguir, loc_cAlias, loc_cAliasTmp
		LOCAL loc_cSQL, loc_nResultado, loc_cSafety, loc_oErro

		loc_lSucesso    = .F.
		loc_lProsseguir = .T.
		loc_cAlias      = ALLTRIM(THIS.this_cCursorDados)
		loc_cAliasTmp   = ALLTRIM(THIS.this_cCursorTemp)
		loc_cSafety     = ""

		THIS.this_cMensagemErro = ""

		TRY
			IF !THIS.CriarCursorDados()
				loc_lProsseguir = .F.
			ENDIF

			IF loc_lProsseguir
				IF EMPTY(ALLTRIM(NVL(THIS.this_cOperacao, "")))
					*-- Grade vazia com a estrutura pronta: nao eh falha.
					loc_lProsseguir = .F.
					loc_lSucesso    = .T.
				ENDIF
			ENDIF

			IF loc_lProsseguir
				IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
					*-- Sem conexao (modo de teste / validacao de UI) a grade
					*-- abre vazia, e isso tambem nao eh falha.
					loc_lProsseguir = .F.
					loc_lSucesso    = .T.
				ENDIF
			ENDIF

			IF loc_lProsseguir
				*-- Comparacao sem RTRIM de proposito: dopes eh char(20) e o
				*-- SQL Server compara char com preenchimento de brancos
				*-- (ANSI), entao o = casa e o indice segue utilizavel.
				loc_cSQL = "SELECT cidchaves, dopes, qtddis, qtddfs, percs" + ;
						   " FROM SigOpDup" + ;
						   " WHERE dopes = " + EscaparSQL(ALLTRIM(THIS.this_cOperacao)) + ;
						   " ORDER BY qtddis, qtddfs"

				IF USED(loc_cAliasTmp)
					USE IN (loc_cAliasTmp)
				ENDIF

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAliasTmp)

				IF loc_nResultado < 0
					THIS.this_cMensagemErro = "Erro ao carregar a tabela de deprecia" + CHR(231) + CHR(227) + ;
						"o da opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL()
					MsgErro(THIS.this_cMensagemErro, "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
					THIS.this_lErroExibido = .T.
					loc_lProsseguir = .F.
				ENDIF
			ENDIF

			IF loc_lProsseguir
				*-- SET SAFETY tambem eh escopado por data session: com
				*-- DataSession = 2 vale ON mesmo com o SET SAFETY OFF do
				*-- main.prg, e ai o ZAP abre o dialogo modal "Are you sure?"
				*-- e CONGELA a tela esperando um clique que ninguem ve.
				loc_cSafety = SET("SAFETY")
				SET SAFETY OFF

				SELECT (loc_cAlias)
				ZAP

				IF loc_cSafety = "ON"
					SET SAFETY ON
				ENDIF
				loc_cSafety = ""

				*-- lnovos chega .F. em toda linha do servidor, porque o APPEND
				*-- casa por NOME e o cursor temporario nao tem essa coluna -
				*-- que eh exatamente o desejado: linha vinda do banco eh
				*-- UPDATE na gravacao, nunca INSERT.
				SELECT (loc_cAlias)
				APPEND FROM DBF(loc_cAliasTmp)

				SELECT (loc_cAlias)
				GO TOP

				IF USED(loc_cAliasTmp)
					USE IN (loc_cAliasTmp)
				ENDIF

				loc_lSucesso = .T.
			ENDIF
		CATCH TO loc_oErro
			IF loc_cSafety = "ON"
				SET SAFETY ON
			ENDIF

			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro("Erro ao carregar a tabela de deprecia" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
				loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* InserirLinhaCursor - acrescenta a linha EM BRANCO de digitacao
	*
	* Transcricao da parte de DADOS do inserelinha legado:
	*     Select crSigOpDup
	*     Locate for Qtddfs=0
	*     If Eof()
	*         Insert Into crSigOpDup (Dopes, CidChaves) ;
	*             Values (crSigCdOpe.Dopes, fUniqueIds())
	*     EndIf
	*     Select crSigOpDup
	*
	* O marcador Thisform.lHouveIns = .T. do legado eh property do FORM (ver
	* cabecalho) e fica em FormSigOpDpe.InserirLinhaCursor, NAO aqui - este
	* metodo so cuida do CURSOR.
	*
	* O Keyboard '{DNARROW}', o GradeSubN.Refresh e o Column1.SetFocus do
	* legado sao da TELA e ficam no form.
	*
	* A linha nasce so com dopes e cidchaves; a coluna qtddfs fica no valor em
	* branco do cursor, que eh zero - e eh justamente qtddfs = 0 que marca a
	* linha como "em branco", tanto para o LOCATE daqui quanto para o
	* descarte da gravacao.
	*==========================================================================
	PROCEDURE InserirLinhaCursor()
		LOCAL loc_lSucesso, loc_cAlias, loc_oErro

		loc_lSucesso = .F.
		loc_cAlias   = ALLTRIM(THIS.this_cCursorDados)

		THIS.this_cMensagemErro = ""

		TRY
			IF !USED(loc_cAlias)
				THIS.this_cMensagemErro = "O cursor da tabela de deprecia" + CHR(231) + CHR(227) + ;
					"o n" + CHR(227) + "o est" + CHR(225) + " aberto."
				MsgErro(THIS.this_cMensagemErro, "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
				THIS.this_lErroExibido = .T.
			ELSE
				SELECT (loc_cAlias)
				LOCATE FOR qtddfs = 0

				IF EOF()
					INSERT INTO (loc_cAlias) (cidchaves, dopes, lnovos) ;
						VALUES (LEFT(fUniqueIds(), 20), ;
								LEFT(ALLTRIM(NVL(THIS.this_cOperacao, "")), 20), ;
								.T.)
				ENDIF

				SELECT (loc_cAlias)
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro("Erro ao inserir a linha da tabela de deprecia" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
				loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* ExcluirLinhaCursor - remove a linha corrente da grade (cmdExcluir.Click)
	*
	* Transcricao da parte de DADOS do cmdExcluir.Click legado:
	*     Select crSigOpDup
	*     If Not Eof()
	*         Thisform.lHouveExcl = .T.
	*         Delete
	*         Skip
	*         Skip - 1
	*     Endif
	*
	* O marcador lHouveExcl eh property do FORM (ver cabecalho) - este metodo
	* devolve .T. quando de fato excluiu (a mesma condicao "Not Eof()" que
	* abre o bloco legado), e o form decide ligar o marcador a partir disso.
	*
	* A remocao eh LOCAL: no legado o DELETE so chega ao servidor junto com a
	* gravacao do Encerrar - o poDataMgr.UpDate propaga INSERT, UPDATE e
	* DELETE do cursor remoto de uma vez. GravarFaixas reproduz isso.
	*
	* O par Skip / Skip -1 reposiciona o ponteiro no registro visivel mais
	* proximo e depende de SET DELETED ON, reposto em CriarCursorDados.
	*==========================================================================
	PROCEDURE ExcluirLinhaCursor()
		LOCAL loc_lSucesso, loc_cAlias, loc_oErro

		loc_lSucesso = .F.
		loc_cAlias   = ALLTRIM(THIS.this_cCursorDados)

		THIS.this_cMensagemErro = ""

		TRY
			IF !USED(loc_cAlias)
				THIS.this_cMensagemErro = "O cursor da tabela de deprecia" + CHR(231) + CHR(227) + ;
					"o n" + CHR(227) + "o est" + CHR(225) + " aberto."
				MsgErro(THIS.this_cMensagemErro, "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
				THIS.this_lErroExibido = .T.
			ELSE
				SELECT (loc_cAlias)

				IF !EOF()
					loc_lSucesso = .T.
					DELETE
					SKIP
					SKIP -1
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro("Erro ao excluir a linha da tabela de deprecia" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
				loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* GravarFaixas - persiste TODAS as faixas de uma vez (cmdSair.Click legado)
	*
	* Transcricao do cmdSair.Click legado:
	*     Select CrSigOpDup
	*     Go Top
	*     Delete For Empty(Dopes) or Empty(Qtddfs)
	*     Replace CidChaves with fUniqueIds() For Empty(CidChaves)
	*     ... poDataMgr.UpDate / Commit / RollBack ...
	*     erro -> MessageBox de "Erro na Gravacao dos Dados do Cadastro de Operacoes."
	*
	* O poDataMgr.UpDate de um cursor REMOTO propaga as tres operacoes de uma
	* vez: INSERT das linhas acrescentadas, UPDATE das alteradas e DELETE das
	* marcadas. Aqui a grade vive num CREATE CURSOR comum, entao a
	* reconciliacao eh explicita - e eh para isso que lnovos existe:
	*
	*     linha marcada DELETED, lnovos = .F.  -> DELETE no servidor
	*     linha marcada DELETED, lnovos = .T.  -> nada (nunca foi gravada)
	*     linha viva, lnovos = .T.             -> INSERT
	*     linha viva, lnovos = .F.             -> UPDATE
	*
	* O GUARD "Thisform.lHouveExcl Or Thisform.lHouveIns" do legado mora no
	* CmdEncerrarClick do form (ele eh property do form) - este metodo roda
	* incondicionalmente, varrendo o cursor.
	*==========================================================================
	PROCEDURE GravarFaixas()
		LOCAL loc_lSucesso, loc_lProsseguir, loc_cAlias, loc_cAliasAnterior
		LOCAL loc_cDeleted, loc_nRecnoAnterior, loc_cComando, loc_oErro

		loc_lSucesso       = .T.
		loc_lProsseguir    = .T.
		loc_cAlias         = ALLTRIM(THIS.this_cCursorDados)
		loc_cAliasAnterior = ALIAS()
		loc_cDeleted       = ""
		loc_nRecnoAnterior = 0

		THIS.this_cMensagemErro = ""
		THIS.this_lErroExibido  = .F.
		THIS.this_cLoteGravacao = ""

		THIS.this_nRegistrosInseridos   = 0
		THIS.this_nRegistrosAtualizados = 0
		THIS.this_nRegistrosExcluidos   = 0

		TRY
			IF !USED(loc_cAlias)
				THIS.this_cMensagemErro = "O cursor da tabela de deprecia" + CHR(231) + CHR(227) + ;
					"o n" + CHR(227) + "o est" + CHR(225) + " aberto."
				MsgErro(THIS.this_cMensagemErro, "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
				THIS.this_lErroExibido = .T.
				loc_lProsseguir = .F.
				loc_lSucesso    = .F.
			ENDIF

			IF loc_lProsseguir
				*-- RECNO guardado junto com o alias: o SCAN abaixo varre o
				*-- cursor inteiro e deixa o ponteiro em EOF. Repor so o alias
				*-- devolveria a area de trabalho certa com a LINHA errada, e
				*-- a grade do usuario mudaria de registro sozinha.
				loc_nRecnoAnterior = RECNO(loc_cAlias)

				*-- Descarte do legado: linha sem operacao, ou com qtd dias
				*-- final zerada (a linha "em branco" de digitacao), nao eh
				*-- gravada.
				SELECT (loc_cAlias)
				GO TOP
				DELETE FOR EMPTY(dopes) OR qtddfs = 0

				*-- A PK eh gerada por LINHA. Cada registro recebe um valor
				*-- proprio porque o VFP reavalia a expressao do WITH a cada
				*-- registro - chave repetida colidiria no indice unico a
				*-- partir da segunda linha.
				REPLACE cidchaves WITH LEFT(fUniqueIds(), 20) ;
					FOR EMPTY(cidchaves) IN (loc_cAlias)

				*-- DELETED OFF para o SCAN VER as linhas marcadas: sao elas
				*-- que viram DELETE no servidor. Reposto apos a varredura.
				loc_cDeleted = SET("DELETED")
				SET DELETED OFF

				SELECT (loc_cAlias)
				GO TOP

				SCAN
					loc_cComando = ""

					IF DELETED()
						*-- Linha removida da grade. Se nunca foi gravada, nao
						*-- existe no servidor e nada ha a apagar la.
						IF !lnovos AND !EMPTY(cidchaves)
							THIS.CarregarDoCursor(loc_cAlias)
							loc_cComando = THIS.MontarDeleteLinha()

							IF EMPTY(loc_cComando)
								MsgErro(THIS.this_cMensagemErro, "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
								THIS.this_lErroExibido = .T.
								loc_lProsseguir = .F.
								loc_lSucesso    = .F.
								EXIT
							ENDIF

							THIS.AcrescentarAoLote(loc_cComando)
							THIS.AcrescentarAoLote(THIS.MontarInsertAuditoria("DELETE"))
							THIS.this_nRegistrosExcluidos = THIS.this_nRegistrosExcluidos + 1
						ENDIF
					ELSE
						THIS.CarregarDoCursor(loc_cAlias)

						*-- Depois do descarte acima nenhuma linha viva deveria
						*-- reprovar. Se reprovar, a gravacao INTEIRA para com
						*-- a mensagem: pular a linha calada gravaria o resto e
						*-- perderia essa sem o usuario saber.
						IF !THIS.ValidarDados()
							MsgErro(THIS.this_cMensagemErro, "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
							THIS.this_lErroExibido = .T.
							loc_lProsseguir = .F.
							loc_lSucesso    = .F.
							EXIT
						ENDIF

						IF lnovos
							loc_cComando = THIS.MontarInsertLinha()
						ELSE
							loc_cComando = THIS.MontarUpdateLinha()
						ENDIF

						IF EMPTY(loc_cComando)
							MsgErro(THIS.this_cMensagemErro, "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
							THIS.this_lErroExibido = .T.
							loc_lProsseguir = .F.
							loc_lSucesso    = .F.
							EXIT
						ENDIF

						THIS.AcrescentarAoLote(loc_cComando)

						IF lnovos
							THIS.AcrescentarAoLote(THIS.MontarInsertAuditoria("INSERT"))
							THIS.this_nRegistrosInseridos = THIS.this_nRegistrosInseridos + 1
						ELSE
							THIS.AcrescentarAoLote(THIS.MontarInsertAuditoria("UPDATE"))
							THIS.this_nRegistrosAtualizados = THIS.this_nRegistrosAtualizados + 1
						ENDIF
					ENDIF
				ENDSCAN

				IF loc_cDeleted = "ON"
					SET DELETED ON
				ENDIF
				loc_cDeleted = ""
			ENDIF

			IF loc_lProsseguir
				IF EMPTY(ALLTRIM(THIS.this_cLoteGravacao))
					*-- Nada sobrou: as linhas em aberto eram todas em branco e
					*-- cairam no mesmo descarte do legado.
					loc_lSucesso = .T.
				ELSE
					loc_lSucesso = THIS.ExecutarLoteGravacao()
				ENDIF
			ENDIF

			IF USED(loc_cAlias)
				IF loc_lProsseguir AND loc_lSucesso
					*-- Gravou: as linhas marcadas saem FISICAMENTE do cursor e
					*-- as novas deixam de ser novas. Sem isso, uma segunda
					*-- gravacao reenviaria os mesmos DELETE e repetiria os
					*-- INSERT, colidindo na chave primaria.
					SELECT (loc_cAlias)
					PACK
					REPLACE ALL lnovos WITH .F. IN (loc_cAlias)
					GO TOP IN (loc_cAlias)
				ELSE
					IF BETWEEN(loc_nRecnoAnterior, 1, RECCOUNT(loc_cAlias))
						GO loc_nRecnoAnterior IN (loc_cAlias)
					ENDIF
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			IF loc_cDeleted = "ON"
				SET DELETED ON
			ENDIF

			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro("Erro na Grava" + CHR(231) + CHR(227) + "o dos Dados do Cadastro de " + ;
				"Opera" + CHR(231) + CHR(245) + "es." + CHR(13) + ;
				loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
			SELECT (loc_cAliasAnterior)
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* AcrescentarAoLote - enfileira um comando no lote transacional
	*==========================================================================
	PROTECTED FUNCTION AcrescentarAoLote(par_cComando)
		LOCAL loc_lOk, loc_cComando

		loc_lOk      = .F.
		loc_cComando = ALLTRIM(NVL(par_cComando, ""))

		IF !EMPTY(loc_cComando)
			THIS.this_cLoteGravacao = THIS.this_cLoteGravacao + loc_cComando + ;
				";" + CHR(13) + CHR(10)
			loc_lOk = .T.
		ENDIF

		RETURN loc_lOk
	ENDFUNC

	*==========================================================================
	* ExecutarLoteGravacao - manda o lote num SQLEXEC unico e ATOMICO
	*==========================================================================
	PROTECTED FUNCTION ExecutarLoteGravacao()
		LOCAL loc_lOk, loc_cSQL, loc_cCRLF, loc_cSavepoint
		LOCAL loc_nResultado, loc_lManual

		loc_lOk   = .F.
		loc_cCRLF = CHR(13) + CHR(10)

		IF EMPTY(ALLTRIM(NVL(THIS.this_cLoteGravacao, "")))
			THIS.this_cMensagemErro = "Nada para gravar."
			RETURN .F.
		ENDIF

		IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
			THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
			MsgErro(THIS.this_cMensagemErro, "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
			THIS.this_lErroExibido = .T.
			RETURN .F.
		ENDIF

		loc_cSavepoint = ALLTRIM(THIS.this_cNomeSavepoint)

		*-- Medido: com a conexao em auto-commit o par fica inerte. IF
		*-- ANINHADO mais abaixo de proposito - VFP9 nao faz curto-circuito
		*-- em AND e chamaria o SQLCOMMIT de qualquer jeito.
		loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)

		loc_cSQL = "SET NOCOUNT ON;" + loc_cCRLF + ;
			"DECLARE @nivel int = @@TRANCOUNT;" + loc_cCRLF + ;
			"IF @nivel = 0 BEGIN TRANSACTION" + loc_cCRLF + ;
			"ELSE SAVE TRANSACTION " + loc_cSavepoint + ";" + loc_cCRLF + ;
			"BEGIN TRY" + loc_cCRLF + ;
			THIS.this_cLoteGravacao + ;
			"IF @nivel = 0 COMMIT TRANSACTION;" + loc_cCRLF + ;
			"END TRY" + loc_cCRLF + ;
			"BEGIN CATCH" + loc_cCRLF + ;
			"IF @nivel = 0 BEGIN IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION; END" + loc_cCRLF + ;
			"ELSE BEGIN IF XACT_STATE() = 1 ROLLBACK TRANSACTION " + loc_cSavepoint + "; END;" + loc_cCRLF + ;
			"THROW;" + loc_cCRLF + ;
			"END CATCH"

		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

		IF loc_nResultado < 0
			THIS.this_cMensagemErro = "Erro na Grava" + CHR(231) + CHR(227) + ;
				"o dos Dados do Cadastro de Opera" + CHR(231) + CHR(245) + "es." + ;
				CHR(13) + CapturarErroSQL()
			loc_lOk = .F.
		ELSE
			loc_lOk = .T.
		ENDIF

		IF loc_lManual
			IF loc_lOk
				= SQLCOMMIT(gnConnHandle)
			ENDIF
		ENDIF

		THIS.this_cLoteGravacao = ""

		IF !loc_lOk
			MsgErro(THIS.this_cMensagemErro, "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
			THIS.this_lErroExibido = .T.
		ENDIF

		RETURN loc_lOk
	ENDFUNC

	*==========================================================================
	* CarregarDoCursor - Carrega as propriedades da faixa a partir de uma
	* linha do cursor crSigOpDup/cursor_4c_Dados
	* REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
	*
	* par_cAliasCursor - alias a ler. Omitido, usa o cursor da grade.
	*
	* GUARDA DE EOF obrigatoria: em VFP ler campo com o ponteiro em EOF NAO
	* da erro - devolve o valor EM BRANCO do tipo. Sem o IF EOF() abaixo este
	* metodo zerava as cinco properties e ainda devolvia .T., ou seja relatava
	* SUCESSO sem haver linha nenhuma. Dois estragos, os dois silenciosos:
	*   - this_cCidChaves e this_cDopes ficavam VAZIOS, e a gravacao seguinte
	*     tentaria persistir uma faixa sem chave e sem operacao;
	*   - com this_cCidChaves vazio, a GUARDA DE IDENTIDADE do
	*     FormSigOpDpe.BOParaForm (que compara a chave do BO com a da linha
	*     corrente) deixa de valer e a escrita passa a atingir QUALQUER linha.
	* Medido no VFP9 em 2026-10-31 (automation\Probe724F8.prg, item 8): com o
	* ponteiro em EOF o metodo devolvia .T. Mesma forma do BO do dialogo-irmao
	* SigOpCrdBO.CarregarDoCursor.
	*==========================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso, loc_cAlias, loc_oErro
		loc_lSucesso = .F.

		loc_cAlias = ALLTRIM(THIS.this_cCursorDados)
		IF VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(ALLTRIM(par_cAliasCursor))
			loc_cAlias = ALLTRIM(par_cAliasCursor)
		ENDIF

		TRY
			IF !USED(loc_cAlias)
				THIS.this_cMensagemErro = "O cursor [" + loc_cAlias + "] n" + CHR(227) + ;
					"o est" + CHR(225) + " aberto."
			ELSE
				SELECT (loc_cAlias)

				IF EOF()
					*-- Sem linha corrente nao ha o que carregar. As properties
					*-- ficam COMO ESTAVAM de proposito: zera-las aqui
					*-- destruiria a faixa que o chamador ja tinha em maos.
					THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + ;
						" linha corrente para carregar."
				ELSE
					THIS.this_cCidChaves = TratarNulo(cidchaves, "")
					THIS.this_cDopes     = TratarNulo(dopes,     "")
					THIS.this_nQtddis    = TratarNulo(qtddis,    0)
					THIS.this_nQtddfs    = TratarNulo(qtddfs,    0)
					THIS.this_nPercs     = TratarNulo(percs,     0)

					loc_lSucesso = .T.
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loc_oErro.Message, "SigOpDpeBO.CarregarDoCursor")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* ValidarDados - criterio de aceitacao de UMA faixa
	*
	* O legado NAO tem validacao de tela aqui: a unica regra que ele aplica eh
	* o descarte do cmdSair.Click,
	*     Delete For Empty(Dopes) or Empty(Qtddfs)
	* mais a exigencia implicita de chave,
	*     Replace CidChaves with fUniqueIds() For Empty(CidChaves)
	*
	* Sao essas as tres condicoes conferidas aqui, e NADA ALEM - em especial
	* NAO se exige qtddis <= qtddfs nem percs > 0: o legado aceita tudo isso,
	* e inventar a regra bloquearia gravacao que hoje funciona.
	*==========================================================================
	PROCEDURE ValidarDados()
		LOCAL loc_lValido

		loc_lValido = .F.
		THIS.this_cMensagemErro = ""

		DO CASE
		CASE EMPTY(ALLTRIM(NVL(THIS.this_cDopes, "")))
			THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
				"o da tabela de deprecia" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada."

		CASE THIS.this_nQtddfs = 0
			THIS.this_cMensagemErro = "Qtd Dias Final n" + CHR(227) + "o informada."

		CASE EMPTY(ALLTRIM(NVL(THIS.this_cCidChaves, "")))
			THIS.this_cMensagemErro = "Chave da tabela de deprecia" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o gerada."

		OTHERWISE
			loc_lValido = .T.
		ENDCASE

		RETURN loc_lValido
	ENDPROC

	*==========================================================================
	* MontarInsertLinha - INSERT da faixa corrente, com as CINCO colunas
	*
	* As cinco colunas de SigOpDup sao NOT NULL e nenhuma tem DEFAULT
	* (conferido em docs/schema.sql, UTF-16, lido com Get-Content -Raw). O
	* legado grava o registro INTEIRO - AddCursor sem query eh SELECT * +
	* TABLEUPDATE - entao as duas colunas que nao aparecem na tela (cidchaves
	* e dopes) continuam sendo gravadas.
	*
	* LEFT(...,20) nas duas colunas char: a largura vem do SCHEMA, nunca do
	* tamanho do controle na tela.
	*==========================================================================
	PROTECTED FUNCTION MontarInsertLinha()
		LOCAL loc_cChave, loc_cDopes

		loc_cChave = LEFT(ALLTRIM(NVL(THIS.this_cCidChaves, "")), 20)
		loc_cDopes = LEFT(ALLTRIM(NVL(THIS.this_cDopes, "")), 20)

		IF EMPTY(loc_cChave) OR EMPTY(loc_cDopes)
			THIS.this_cMensagemErro = "Faixa da tabela de deprecia" + CHR(231) + CHR(227) + ;
				"o sem chave ou sem opera" + CHR(231) + CHR(227) + "o - inclus" + CHR(227) + "o cancelada."
			RETURN ""
		ENDIF

		RETURN "INSERT INTO SigOpDup" + ;
			" (cidchaves, dopes, qtddis, qtddfs, percs)" + ;
			" VALUES (" + EscaparSQL(loc_cChave) + ", " + ;
			EscaparSQL(loc_cDopes) + ", " + ;
			FormatarNumeroSQL(THIS.this_nQtddis, 0) + ", " + ;
			FormatarNumeroSQL(THIS.this_nQtddfs, 0) + ", " + ;
			FormatarNumeroSQL(THIS.this_nPercs, 2) + ")"
	ENDFUNC

	*==========================================================================
	* MontarUpdateLinha - UPDATE da faixa corrente, pela chave primaria
	*
	* dopes entra no SET junto com as duas numericas porque eh coluna de
	* DADOS do registro (e NOT NULL), nao parte da chave: a PK de SigOpDup eh
	* so cidchaves (constraint sigopdup_cidchaves).
	*==========================================================================
	PROTECTED FUNCTION MontarUpdateLinha()
		LOCAL loc_cChave, loc_cDopes

		loc_cChave = LEFT(ALLTRIM(NVL(THIS.this_cCidChaves, "")), 20)
		loc_cDopes = LEFT(ALLTRIM(NVL(THIS.this_cDopes, "")), 20)

		IF EMPTY(loc_cChave) OR EMPTY(loc_cDopes)
			THIS.this_cMensagemErro = "Faixa da tabela de deprecia" + CHR(231) + CHR(227) + ;
				"o sem chave ou sem opera" + CHR(231) + CHR(227) + "o - altera" + CHR(231) + CHR(227) + ;
				"o cancelada."
			RETURN ""
		ENDIF

		RETURN "UPDATE SigOpDup SET" + ;
			" dopes = " + EscaparSQL(loc_cDopes) + "," + ;
			" qtddis = " + FormatarNumeroSQL(THIS.this_nQtddis, 0) + "," + ;
			" qtddfs = " + FormatarNumeroSQL(THIS.this_nQtddfs, 0) + "," + ;
			" percs = " + FormatarNumeroSQL(THIS.this_nPercs, 2) + ;
			" WHERE cidchaves = " + EscaparSQL(loc_cChave)
	ENDFUNC

	*==========================================================================
	* MontarDeleteLinha - DELETE da faixa corrente, pela chave primaria
	*==========================================================================
	PROTECTED FUNCTION MontarDeleteLinha()
		LOCAL loc_cChave

		loc_cChave = LEFT(ALLTRIM(NVL(THIS.this_cCidChaves, "")), 20)

		IF EMPTY(loc_cChave)
			THIS.this_cMensagemErro = "Faixa da tabela de deprecia" + CHR(231) + CHR(227) + ;
				"o sem chave - exclus" + CHR(227) + "o cancelada."
			RETURN ""
		ENDIF

		RETURN "DELETE FROM SigOpDup WHERE cidchaves = " + EscaparSQL(loc_cChave)
	ENDFUNC

	*==========================================================================
	* MontarInsertAuditoria - comando de auditoria para entrar no MESMO lote
	*
	* Vai junto com a operacao no lote transacional, e nao por SQLEXEC a
	* parte: assim o log nunca registra uma gravacao que foi desfeita.
	*
	* DataHora recebe GETDATE() literal, funcao do servidor - NUNCA
	* GETDATE(), que devolveria a string "NULL" e o INSERT
	* quebraria na coluna NOT NULL.
	*
	* Larguras de LogAuditoria no schema: Tabela varchar(100),
	* Operacao varchar(10), ChaveRegistro varchar(100), Usuario varchar(50).
	*==========================================================================
	PROTECTED FUNCTION MontarInsertAuditoria(par_cOperacao)
		LOCAL loc_cOperacao, loc_cChave, loc_cUsuario

		loc_cOperacao = UPPER(ALLTRIM(NVL(par_cOperacao, "")))
		loc_cChave    = ALLTRIM(NVL(THIS.ObterChavePrimaria(), ""))
		loc_cUsuario  = "SISTEMA"

		IF TYPE("gc_4c_UsuarioLogado") = "C"
			IF !EMPTY(ALLTRIM(gc_4c_UsuarioLogado))
				loc_cUsuario = ALLTRIM(gc_4c_UsuarioLogado)
			ENDIF
		ENDIF

		*-- Sem operacao ou sem chave nao ha o que auditar. Devolver vazio eh
		*-- inocuo: AcrescentarAoLote ignora comando vazio e a gravacao do
		*-- DADO, que eh o que importa, segue adiante.
		IF EMPTY(loc_cOperacao) OR EMPTY(loc_cChave)
			RETURN ""
		ENDIF

		RETURN "INSERT INTO LogAuditoria" + ;
			" (Tabela, Operacao, ChaveRegistro, Usuario, DataHora)" + ;
			" VALUES (" + EscaparSQL(LEFT(ALLTRIM(THIS.this_cTabela), 100)) + ", " + ;
			EscaparSQL(LEFT(loc_cOperacao, 10)) + ", " + ;
			EscaparSQL(LEFT(loc_cChave, 100)) + ", " + ;
			EscaparSQL(LEFT(loc_cUsuario, 50)) + ", GETDATE())"
	ENDFUNC

	*==========================================================================
	* Inserir - grava UMA faixa de depreciacao (caminho do Salvar da
	* BusinessBase). O caminho normal desta tela eh a gravacao em LOTE do
	* Encerrar (GravarFaixas) - este metodo cumpre o contrato Salvar() ->
	* Inserir() da BusinessBase e compartilha o MESMO montador de SQL, para
	* que a lista de colunas nao possa divergir entre os dois caminhos.
	*
	* cidchaves = PK Fortyus (fUniqueIds) - NUNCA string vazia (regra #22),
	* senao a segunda faixa incluida colide na chave primaria.
	*==========================================================================
	PROCEDURE Inserir()
		LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro
		loc_lSucesso = .F.
		THIS.this_cMensagemErro = ""

		TRY
			IF EMPTY(ALLTRIM(NVL(THIS.this_cCidChaves, "")))
				THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)
			ENDIF

			IF EMPTY(ALLTRIM(NVL(THIS.this_cDopes, "")))
				THIS.this_cDopes = LEFT(ALLTRIM(NVL(THIS.this_cOperacao, "")), 20)
			ENDIF

			loc_cSQL = THIS.MontarInsertLinha()

			IF EMPTY(loc_cSQL)
				loc_lSucesso = .F.
			ELSE
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

				IF loc_nResultado >= 0
					THIS.RegistrarAuditoria("INSERT")
					THIS.this_nRegistrosInseridos = THIS.this_nRegistrosInseridos + 1
					loc_lSucesso = .T.
				ELSE
					THIS.this_cMensagemErro = "Erro ao inserir a faixa de deprecia" + CHR(231) + CHR(227) + ;
						"o:" + CHR(13) + CapturarErroSQL()
					MsgErro(THIS.this_cMensagemErro, "Erro SQL")
					THIS.this_lErroExibido = .T.
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = "Erro ao inserir:" + CHR(13) + loc_oErro.Message
			MsgErro(THIS.this_cMensagemErro + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "SigOpDpeBO.Inserir")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* Atualizar - grava a alteracao de UMA faixa (contrato do Salvar)
	* WHERE por cidchaves, a PK real da linha (dopes identifica a operacao
	* proprietaria, nao a faixa individual)
	*==========================================================================
	PROCEDURE Atualizar()
		LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro
		loc_lSucesso = .F.
		THIS.this_cMensagemErro = ""

		TRY
			loc_cSQL = THIS.MontarUpdateLinha()

			IF EMPTY(loc_cSQL)
				loc_lSucesso = .F.
			ELSE
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

				IF loc_nResultado >= 0
					THIS.RegistrarAuditoria("UPDATE")
					THIS.this_nRegistrosAtualizados = THIS.this_nRegistrosAtualizados + 1
					loc_lSucesso = .T.
				ELSE
					THIS.this_cMensagemErro = "Erro ao atualizar a faixa de deprecia" + CHR(231) + CHR(227) + ;
						"o:" + CHR(13) + CapturarErroSQL()
					MsgErro(THIS.this_cMensagemErro, "Erro SQL")
					THIS.this_lErroExibido = .T.
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = "Erro ao atualizar:" + CHR(13) + loc_oErro.Message
			MsgErro(THIS.this_cMensagemErro + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "SigOpDpeBO.Atualizar")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* ExecutarExclusao - apaga UMA faixa no servidor, pela chave primaria
	*
	* PROTECTED de proposito (regra #51): de fora, sempre Excluir() da
	* BusinessBase, que valida o estado, roda os hooks e garante que a falha
	* nunca eh muda.
	*
	* No fluxo da TELA a remocao eh local (ExcluirLinhaCursor) e so chega ao
	* servidor junto com a gravacao do Encerrar, por reconciliacao - que eh o
	* que o poDataMgr.UpDate do cursor remoto fazia. Os dois caminhos usam o
	* MESMO montador de SQL.
	*==========================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro
		loc_lSucesso = .F.
		THIS.this_cMensagemErro = ""

		TRY
			loc_cSQL = THIS.MontarDeleteLinha()

			IF EMPTY(loc_cSQL)
				loc_lSucesso = .F.
			ELSE
				*-- Auditoria ANTES do DELETE: ObterChavePrimaria le a
				*-- property, que o LimparDados do Excluir() zera depois.
				THIS.RegistrarAuditoria("DELETE")

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

				IF loc_nResultado >= 0
					THIS.this_nRegistrosExcluidos = THIS.this_nRegistrosExcluidos + 1
					loc_lSucesso = .T.
				ELSE
					THIS.this_cMensagemErro = "Erro ao excluir a faixa de deprecia" + CHR(231) + CHR(227) + ;
						"o:" + CHR(13) + CapturarErroSQL()
					MsgErro(THIS.this_cMensagemErro, "Erro SQL")
					THIS.this_lErroExibido = .T.
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = "Erro ao excluir:" + CHR(13) + loc_oErro.Message
			MsgErro(THIS.this_cMensagemErro + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "SigOpDpeBO.ExecutarExclusao")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* LimparDados - devolve as propriedades ao estado de registro novo
	*
	* dopes volta para a operacao do CONTEXTO, nao para vazio: toda faixa
	* desta tela pertence a operacao que o form pai esta editando.
	*==========================================================================
	PROCEDURE LimparDados()
		DODEFAULT()

		THIS.this_cCidChaves = ""
		THIS.this_cDopes     = ALLTRIM(NVL(THIS.this_cOperacao, ""))
		THIS.this_nQtddis    = 0
		THIS.this_nQtddfs    = 0
		THIS.this_nPercs     = 0

		THIS.this_cLoteGravacao = ""

		RETURN .T.
	ENDPROC

	*==========================================================================
	* Destroy - fecha os cursores desta tela
	*
	* USE IN fecha o alias mesmo com buffer sujo, e por isso NAO ha
	* TABLEREVERT aqui: TABLEREVERT exige buffering e, sobre cursor criado por
	* CREATE CURSOR (que nasce com Buffering = 1), dispara o erro 1586
	* "Function requires row or table buffering mode."
	*==========================================================================
	PROCEDURE Destroy()
		IF USED(ALLTRIM(THIS.this_cCursorTemp))
			USE IN (ALLTRIM(THIS.this_cCursorTemp))
		ENDIF

		IF USED(ALLTRIM(THIS.this_cCursorDados))
			USE IN (ALLTRIM(THIS.this_cCursorDados))
		ENDIF

		DODEFAULT()
	ENDPROC

ENDDEFINE

