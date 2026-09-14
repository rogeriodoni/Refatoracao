# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (7)
- [GRID-SQL] Campo 'datas' usado em ControlSource de cursor_4c_Lista mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'solicits' usado em ControlSource de cursor_4c_Lista mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'operas' usado em ControlSource de cursor_4c_Lista mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'docs' usado em ControlSource de cursor_4c_Lista mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'valors' usado em ControlSource de cursor_4c_Lista mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'senhads' usado em ControlSource de cursor_4c_Lista mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'tipos' usado em ControlSource de cursor_4c_Lista mas NAO aparece no SELECT SQL

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
  ControlSource = "crSigPrSnd.operas"
  ControlSource = "crSigPrSnd.Valors"
  ControlSource = "crSigPrSnd.Solicits"
  ControlSource = "crSigPrSnd.Docs"
  ControlSource = "crSigPrSnd.Datas"
  ControlSource = "crSigPrSnd.Motivos"
  ControlSource = "crSigPrSnd.Fpags"
  ControlSource = "crSigPrSnd.Emps"
lcQrySend = [Select * From SigPrSnd Where cIdChaves = '] + pIds + [']
		Insert Into crSigPrSnd (Usuars, Datas, Tipos) Values (Usuar, Datetime(),Iif(ThisForm.Producao,1,0))
		lcSql = [Select SenhDEmps From SigCdPac ]
		ThisForm.Podatamgr.Sqlexecute(lcSql,'CrParac')
	lcSql = [Select nemps From SigCdEmp Where cEmps = ']+CrSigPrSnd.Emps+[']
	ThisForm.Podatamgr.Sqlexecute(lcSql,'CrEmp')
	lcSql = [Select nfpags From SigOpFp Where Fpags = ']+CrSigPrSnd.Fpags+[']
	ThisForm.Podatamgr.Sqlexecute(lcSql,'CrfPagto')
ThisForm.poDataMgr.Update('crSigPrSnd')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrSdd.prg) - TRECHOS RELEVANTES PARA PASS SQL (1668 linhas total):

*-- Linhas 447 a 465:
447:             .HighlightBackColor = RGB(255, 255, 255)
448:             .HighlightForeColor = RGB(15, 41, 104)
449:             .HighlightStyle     = 2
450:             .DeleteMark         = .F.
451:             .RecordMark         = .F.
452:             .RowHeight          = 16
453:             .ScrollBars         = 2
454:             .ColumnCount        = 8
455:             .ReadOnly           = .T.
456:             .Visible            = .T.
457:         ENDWITH
458:         loc_oGrid = loc_oPag1.grd_4c_Lista
459:         loc_oGrid.Column1.Width = 120
460:         loc_oGrid.Column2.Width = 90
461:         loc_oGrid.Column3.Width = 50
462:         loc_oGrid.Column4.Width = 170
463:         loc_oGrid.Column5.Width = 110
464:         loc_oGrid.Column6.Width = 110
465:         loc_oGrid.Column7.Width = 80

*-- Linhas 473 a 516:
473:         LOCAL loc_oGrid, loc_cSQL, loc_nRet, loc_oErro
474: 
475:         TRY
476:             loc_cSQL = "SELECT TOP 500 cidchaves, datas, solicits, emps, operas, " + ;
477:                        "docs, valors, senhads, tipos " + ;
478:                        "FROM SigPrSnd " + ;
479:                        "ORDER BY datas DESC"
480: 
481:             IF USED("cursor_4c_Lista")
482:                 TABLEREVERT(.T., "cursor_4c_Lista")
483:                 USE IN cursor_4c_Lista
484:             ENDIF
485: 
486:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Lista")
487: 
488:             IF loc_nRet > 0 AND USED("cursor_4c_Lista")
489:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
490: 
491:                 loc_oGrid.ColumnCount  = 8
492:                 loc_oGrid.RecordSource = "cursor_4c_Lista"
493: 
494:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Lista.datas"
495:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Lista.solicits"
496:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Lista.emps"
497:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Lista.operas"
498:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Lista.docs"
499:                 loc_oGrid.Column6.ControlSource = "cursor_4c_Lista.valors"
500:                 loc_oGrid.Column7.ControlSource = "cursor_4c_Lista.senhads"
501:                 loc_oGrid.Column8.ControlSource = "cursor_4c_Lista.tipos"
502: 
503:                 loc_oGrid.Column1.Header1.Caption = "Data/Hora"
504:                 loc_oGrid.Column2.Header1.Caption = "Solicitante"
505:                 loc_oGrid.Column3.Header1.Caption = "Empresa"
506:                 loc_oGrid.Column4.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
507:                 loc_oGrid.Column5.Header1.Caption = "Documento"
508:                 loc_oGrid.Column6.Header1.Caption = "Valor"
509:                 loc_oGrid.Column7.Header1.Caption = "Senha"
510:                 loc_oGrid.Column8.Header1.Caption = "Tipo"
511: 
512:                 loc_oGrid.Column1.Width = 120
513:                 loc_oGrid.Column2.Width = 90
514:                 loc_oGrid.Column3.Width = 50
515:                 loc_oGrid.Column4.Width = 170
516:                 loc_oGrid.Column5.Width = 110

*-- Linhas 563 a 622:
563: 
564:     *==========================================================================
565:     * BtnVisualizarClick - Carrega registro selecionado em modo visualizacao
566:     *==========================================================================
567:     PROCEDURE BtnVisualizarClick()
568:         IF !USED("cursor_4c_Lista") OR RECCOUNT("cursor_4c_Lista") = 0
569:             MsgAviso("Selecione um registro na lista.", "Aviso")
570:         ELSE
571:             THIS.this_cModoAtual = "VISUALIZAR"
572:             THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Lista")
573:             THIS.BOParaForm()
574:             THIS.HabilitarCampos("VISUALIZAR")
575:             THIS.AlternarPagina(2)
576:         ENDIF
577:     ENDPROC
578: 
579:     *==========================================================================
580:     * BtnAlterarClick - Carrega registro selecionado em modo edicao
581:     *==========================================================================
582:     PROCEDURE BtnAlterarClick()
583:         IF !USED("cursor_4c_Lista") OR RECCOUNT("cursor_4c_Lista") = 0
584:             MsgAviso("Selecione um registro na lista.", "Aviso")
585:         ELSE
586:             THIS.this_cModoAtual = "ALTERAR"
587:             THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Lista")
588:             THIS.BOParaForm()
589:             THIS.HabilitarCampos("ALTERAR")
590:             THIS.AlternarPagina(2)
591:         ENDIF
592:     ENDPROC
593: 
594:     *==========================================================================
595:     * BtnExcluirClick - Exclui registro selecionado apos confirmacao
596:     *==========================================================================
597:     PROCEDURE BtnExcluirClick()
598:         LOCAL loc_lConfirma, loc_lSucesso, loc_oErro
599: 
600:         loc_lConfirma = .F.
601:         loc_lSucesso  = .F.
602: 
603:         IF !USED("cursor_4c_Lista") OR RECCOUNT("cursor_4c_Lista") = 0
604:             MsgAviso("Selecione um registro na lista.", "Aviso")
605:         ELSE
606:             TRY
607:                 THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Lista")
608:                 loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", "Confirmar")
609:                 IF loc_lConfirma
610:                     loc_lSucesso = THIS.this_oBusinessObject.Excluir()
611:                     IF loc_lSucesso
612:                         THIS.CarregarLista()
613:                     ENDIF
614:                 ENDIF
615:             CATCH TO loc_oErro
616:                 MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
617:                         " PROC=" + loc_oErro.Procedure, "Erro ao Excluir")
618:             ENDTRY
619:         ENDIF
620:     ENDPROC
621: 
622:     *==========================================================================

*-- Linhas 1171 a 1192:
1171:     *==========================================================================
1172:     PROCEDURE Destroy()
1173:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1174:             THIS.this_oBusinessObject = .NULL.
1175:         ENDIF
1176:         IF USED("cursor_4c_Lista")
1177:             USE IN cursor_4c_Lista
1178:         ENDIF
1179:         DODEFAULT()
1180:     ENDPROC
1181: 
1182:     *==========================================================================
1183:     * BOParaForm - Popula campos do formulario a partir das propriedades do BO
1184:     * Usado em Visualizar/Alterar apos CarregarDoCursor
1185:     *==========================================================================
1186:     PROCEDURE BOParaForm()
1187:         LOCAL loc_oPag2, loc_oBO, loc_cSQL, loc_nRet, loc_oErro
1188: 
1189:         TRY
1190:             loc_oPag2 = THIS.pgf_4c_Paginas.Page2
1191:             loc_oBO   = THIS.this_oBusinessObject
1192: 

*-- Linhas 1224 a 1249:
1224:                PEMSTATUS(loc_oPag2, "txt_4c_Ds_Empresa", 5) AND ;
1225:                !EMPTY(ALLTRIM(loc_oPag2.txt_4c_Cd_Empresa.Value))
1226: 
1227:                 loc_cSQL = "SELECT TOP 1 Cemps, Razas FROM SigCdEmp " + ;
1228:                            "WHERE RTRIM(Cemps) = " + ;
1229:                            EscaparSQL(ALLTRIM(loc_oPag2.txt_4c_Cd_Empresa.Value))
1230:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmpBO")
1231: 
1232:                 IF loc_nRet > 0 AND USED("cursor_4c_BuscaEmpBO") AND ;
1233:                    RECCOUNT("cursor_4c_BuscaEmpBO") > 0
1234:                     SELECT cursor_4c_BuscaEmpBO
1235:                     loc_oPag2.txt_4c_Ds_Empresa.Value = ALLTRIM(NVL(Razas, ""))
1236:                 ENDIF
1237:                 IF USED("cursor_4c_BuscaEmpBO")
1238:                     USE IN cursor_4c_BuscaEmpBO
1239:                 ENDIF
1240:             ENDIF
1241:         CATCH TO loc_oErro
1242:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1243:                     " PROC=" + loc_oErro.Procedure, "Erro BOParaForm")
1244:         ENDTRY
1245:     ENDPROC
1246: 
1247:     *==========================================================================
1248:     * LimparCampos - Limpa todos os campos do formulario para novo registro
1249:     *==========================================================================

*-- Linhas 1308 a 1332:
1308:                 RETURN
1309:             ENDIF
1310: 
1311:             loc_cSQL = "SELECT TOP 1 Cemps, Razas FROM SigCdEmp " + ;
1312:                        "WHERE RTRIM(Cemps) = " + EscaparSQL(loc_cCodigo)
1313:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmp")
1314: 
1315:             IF loc_nRet > 0 AND USED("cursor_4c_BuscaEmp") AND ;
1316:                RECCOUNT("cursor_4c_BuscaEmp") > 0
1317:                 SELECT cursor_4c_BuscaEmp
1318:                 loc_oPag2.txt_4c_Cd_Empresa.Value = ALLTRIM(NVL(Cemps, ""))
1319:                 loc_oPag2.txt_4c_Ds_Empresa.Value = ALLTRIM(NVL(Razas, ""))
1320:             ELSE
1321:                 THIS.AbrirLookupEmpresaNomePicker()
1322:             ENDIF
1323: 
1324:             IF USED("cursor_4c_BuscaEmp")
1325:                 USE IN cursor_4c_BuscaEmp
1326:             ENDIF
1327:         CATCH TO loc_oErro
1328:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1329:                     " PROC=" + loc_oErro.Procedure, "Erro Lookup Empresa C" + CHR(243) + "digo")
1330:         ENDTRY
1331:     ENDPROC
1332: 

*-- Linhas 1366 a 1384:
1366:             loc_oBusca.Show()
1367: 
1368:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
1369:                 SELECT cursor_4c_BuscaEmp
1370:                 loc_oPag2.txt_4c_Cd_Empresa.Value = ALLTRIM(NVL(Cemps, ""))
1371:                 loc_oPag2.txt_4c_Ds_Empresa.Value = ALLTRIM(NVL(Razas, ""))
1372:             ENDIF
1373: 
1374:             IF USED("cursor_4c_BuscaEmp")
1375:                 USE IN cursor_4c_BuscaEmp
1376:             ENDIF
1377:             loc_oBusca.Release()
1378:         CATCH TO loc_oErro
1379:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1380:                     " PROC=" + loc_oErro.Procedure, "Erro Lookup Empresa Nome")
1381:         ENDTRY
1382:     ENDPROC
1383: 
1384:     *==========================================================================

*-- Linhas 1430 a 1448:
1430:             loc_oBusca.Show()
1431: 
1432:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOp")
1433:                 SELECT cursor_4c_BuscaOp
1434:                 IF THIS.this_lProducao
1435:                     loc_oPag2.txt_4c_Operacao.Value = ALLTRIM(NVL(Dopps, ""))
1436:                 ELSE
1437:                     loc_oPag2.txt_4c_Operacao.Value = ALLTRIM(NVL(Dopes, ""))
1438:                 ENDIF
1439:             ENDIF
1440: 
1441:             IF USED("cursor_4c_BuscaOp")
1442:                 USE IN cursor_4c_BuscaOp
1443:             ENDIF
1444:             loc_oBusca.Release()
1445:         CATCH TO loc_oErro
1446:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1447:                     " PROC=" + loc_oErro.Procedure, "Erro Lookup Opera" + CHR(231) + CHR(227) + "o")
1448:         ENDTRY

*-- Linhas 1485 a 1503:
1485:             loc_oBusca.Show()
1486: 
1487:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFpg")
1488:                 SELECT cursor_4c_BuscaFpg
1489:                 loc_oPag2.txt_4c_Fpg.Value = ALLTRIM(NVL(Fpags, ""))
1490:             ENDIF
1491: 
1492:             IF USED("cursor_4c_BuscaFpg")
1493:                 USE IN cursor_4c_BuscaFpg
1494:             ENDIF
1495:             loc_oBusca.Release()
1496:         CATCH TO loc_oErro
1497:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1498:                     " PROC=" + loc_oErro.Procedure, "Erro Lookup Forma Pagamento")
1499:         ENDTRY
1500:     ENDPROC
1501: 
1502:     *==========================================================================
1503:     * FormParaBO - Transfere valores dos campos do formulario para o BO

*-- Linhas 1639 a 1659:
1639:     *==========================================================================
1640:     PROCEDURE AjustarBotoesPorModo()
1641:         LOCAL loc_oPag1, loc_lTemRegistro
1642: 
1643:         loc_oPag1        = THIS.pgf_4c_Paginas.Page1
1644:         loc_lTemRegistro = USED("cursor_4c_Lista") AND RECCOUNT("cursor_4c_Lista") > 0
1645: 
1646:         IF PEMSTATUS(loc_oPag1, "cnt_4c_Botoes", 5)
1647:             WITH loc_oPag1.cnt_4c_Botoes
1648:                 IF PEMSTATUS(.cmd_4c_Incluir, "Enabled", 5)
1649:                     .cmd_4c_Incluir.Enabled    = .T.
1650:                 ENDIF
1651:                 IF PEMSTATUS(.cmd_4c_Visualizar, "Enabled", 5)
1652:                     .cmd_4c_Visualizar.Enabled = loc_lTemRegistro
1653:                 ENDIF
1654:                 IF PEMSTATUS(.cmd_4c_Alterar, "Enabled", 5)
1655:                     .cmd_4c_Alterar.Enabled    = loc_lTemRegistro
1656:                 ENDIF
1657:                 IF PEMSTATUS(.cmd_4c_Excluir, "Enabled", 5)
1658:                     .cmd_4c_Excluir.Enabled    = loc_lTemRegistro
1659:                 ENDIF


### BO (C:\4c\projeto\app\classes\SigPrSddBO.prg):
*==============================================================================
* SigPrSddBO.prg - Business Object para Senha do Dia
* Herda de BusinessBase
* Tabela principal: SigPrSnd
* Fase 1/8: Propriedades e Init
*==============================================================================

DEFINE CLASS SigPrSddBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Configuracao da entidade
    *--------------------------------------------------------------------------
    this_cTabela     = "SigPrSnd"
    this_cCampoChave = "cIdChaves"

    *--------------------------------------------------------------------------
    * Propriedades de dados - SigPrSnd (todas as colunas)
    *--------------------------------------------------------------------------
    this_cIdChaves   = ""  && cidchaves  char(20)  PK
    this_dDatas      = {}  && datas      datetime  NULL
    this_nDocs       = 0   && docs       numeric(10,0)
    this_cHoras      = ""  && horas      char(8)
    this_cMotivos    = ""  && motivos    char(40)
    this_cOperas     = ""  && operas     char(20)
    this_cSenhads    = ""  && senhads    char(6)
    this_cSolicits   = ""  && solicits   char(10)
    this_cUsuars     = ""  && usuars     char(10)
    this_nValors     = 0   && valors     numeric(11,2)
    this_nTipos      = 0   && tipos      numeric(1,0)
    this_cEmps       = ""  && emps       char(3)
    this_cFpags      = ""  && fpags      char(12)
    this_cEmpdopnums = ""  && empdopnums char(29)
    this_nPerlimite  = 0   && perlimite  numeric(5,2)

    *--------------------------------------------------------------------------
    * Propriedades auxiliares (nao persistidas em SigPrSnd)
    *--------------------------------------------------------------------------
    this_lProducao   = .F. && modo producao (parametro recebido pelo form)
    this_lSenhDEmps  = .F. && flag SigCdPac.senhdemps (bit -> logical)
    this_cDsEmpresa  = ""  && descricao empresa (SigCdEmp.Razas, exibida em Get_Ds_Empresa)

    *==========================================================================
    * Init - Configura tabela principal e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            THIS.this_cTabela     = "SigPrSnd"
            THIS.this_cCampoChave = "cIdChaves"

            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrSddBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna cIdChaves como chave primaria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN RTRIM(THIS.this_cIdChaves)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    * par_cAliasCursor: alias do cursor com dados de SigPrSnd
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cIdChaves   = TratarNulo(cidchaves,   "C")
                THIS.this_dDatas      = IIF(VARTYPE(datas) = "T", datas, IIF(VARTYPE(datas) = "D", DATETIME(YEAR(datas), MONTH(datas), DAY(datas)), DATETIME()))
                THIS.this_nDocs       = TratarNulo(docs,        "N")
                THIS.this_cHoras      = TratarNulo(horas,       "C")
                THIS.this_cMotivos    = TratarNulo(motivos,     "C")
                THIS.this_cOperas     = TratarNulo(operas,      "C")
                THIS.this_cSenhads    = TratarNulo(senhads,     "C")
                THIS.this_cSolicits   = TratarNulo(solicits,    "C")
                THIS.this_cUsuars     = TratarNulo(usuars,      "C")
                THIS.this_nValors     = TratarNulo(valors,      "N")
                THIS.this_nTipos      = TratarNulo(tipos,       "N")
                THIS.this_cEmps       = TratarNulo(emps,        "C")
                THIS.this_cFpags      = TratarNulo(fpags,       "C")
                THIS.this_cEmpdopnums = TratarNulo(empdopnums,  "C")
                THIS.this_nPerlimite  = TratarNulo(perlimite,   "N")

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida campos obrigatorios antes de salvar
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_cMensagem

        loc_cMensagem = ""

        IF EMPTY(ALLTRIM(THIS.this_cSolicits))
            loc_cMensagem = "Informe o Nome do Solicitante."
        ENDIF
        IF EMPTY(loc_cMensagem) AND EMPTY(ALLTRIM(THIS.this_cEmps))
            loc_cMensagem = "Informe a Empresa."
        ENDIF
        IF EMPTY(loc_cMensagem) AND EMPTY(ALLTRIM(THIS.this_cOperas))
            loc_cMensagem = "Informe a Opera" + CHR(231) + CHR(227) + "o."
        ENDIF
        IF EMPTY(loc_cMensagem) AND THIS.this_nDocs = 0
            loc_cMensagem = "Informe o N" + CHR(250) + "mero do Documento."
        ENDIF
        IF EMPTY(loc_cMensagem) AND !THIS.this_lProducao AND THIS.this_nValors = 0
            loc_cMensagem = "Informe o Valor."
        ENDIF
        IF EMPTY(loc_cMensagem) AND EMPTY(ALLTRIM(THIS.this_cMotivos))
            loc_cMensagem = "Informe o Motivo."
        ENDIF

        THIS.this_cMensagemErro = loc_cMensagem
        RETURN EMPTY(loc_cMensagem)
    ENDPROC

    *==========================================================================
    * Inserir - INSERT completo em SigPrSnd
    * Chamado apos GeraSenha preencher cIdChaves, Senhads e Horas
    *==========================================================================
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigPrSnd " + ;
                       "(cidchaves, datas, docs, horas, motivos, operas, senhads, " + ;
                       " solicits, usuars, valors, tipos, emps, fpags, empdopnums, perlimite) " + ;
                       "VALUES (" + ;
                       EscaparSQL(LEFT(THIS.this_cIdChaves,   20)) + ", " + ;
                       "GETDATE(), " + ;
                       FormatarNumeroSQL(THIS.this_nDocs,     0)   + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cHoras,       8)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cMotivos,    40)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cOperas,     20)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cSenhads,     6)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cSolicits,   10)) + ", " + ;
                       EscaparSQL(LEFT(gc_4c_UsuarioLogado,   10)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nValors,    2)  + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTipos,     0)  + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cEmps,        3)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cFpags,      12)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPerlimite, 2)  + ;
                       ")"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("I")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro ao Inserir Senha do Dia")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Atualizar - UPDATE em SigPrSnd por cIdChaves
    *==========================================================================
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigPrSnd SET " + ;
                       "datas        = GETDATE(), " + ;
                       "docs         = " + FormatarNumeroSQL(THIS.this_nDocs,     0) + ", " + ;
                       "horas        = " + EscaparSQL(LEFT(THIS.this_cHoras,       8)) + ", " + ;
                       "motivos      = " + EscaparSQL(LEFT(THIS.this_cMotivos,    40)) + ", " + ;
                       "operas       = " + EscaparSQL(LEFT(THIS.this_cOperas,     20)) + ", " + ;
                       "senhads      = " + EscaparSQL(LEFT(THIS.this_cSenhads,     6)) + ", " + ;
                       "solicits     = " + EscaparSQL(LEFT(THIS.this_cSolicits,   10)) + ", " + ;
                       "usuars       = " + EscaparSQL(LEFT(gc_4c_UsuarioLogado,   10)) + ", " + ;
                       "valors       = " + FormatarNumeroSQL(THIS.this_nValors,    2)  + ", " + ;
                       "tipos        = " + FormatarNumeroSQL(THIS.this_nTipos,     0)  + ", " + ;
                       "emps         = " + EscaparSQL(LEFT(THIS.this_cEmps,        3)) + ", " + ;
                       "fpags        = " + EscaparSQL(LEFT(THIS.this_cFpags,      12)) + ", " + ;
                       "empdopnums   = " + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ", " + ;
                       "perlimite    = " + FormatarNumeroSQL(THIS.this_nPerlimite, 2)  + " " + ;
                       "WHERE cidchaves = " + EscaparSQL(LEFT(THIS.this_cIdChaves, 20))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("A")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro ao Atualizar Senha do Dia")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * RegistrarAuditoria - Registra operacao na LogAuditoria
    * par_cOperacao: "I" inserir, "A" alterar, "E" excluir
    *==========================================================================
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_nRet

        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, ChavePrimaria, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SigPrSnd")                           + ", " + ;
                       EscaparSQL(par_cOperacao)                        + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cIdChaves, 20))        + ", " + ;
                       EscaparSQL(LEFT(gc_4c_UsuarioLogado, 50))        + ", " + ;
                       "GETDATE()" + ;
                       ")"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            && auditoria nao pode bloquear operacao principal
        ENDTRY
    ENDPROC

    *==========================================================================
    * GeraSenha - Gera senha diaria e persiste em SigPrSnd
    * Retorna a senha gerada ou "" em caso de erro
    * Deve ser chamado apos ValidarDados() retornar .T.
    *==========================================================================
    FUNCTION GeraSenha()
        LOCAL loc_lSucesso, loc_lSenhDEmps, loc_nNum, loc_cSenha, loc_lValido

        loc_lSucesso   = .F.
        loc_lSenhDEmps = .F.
        loc_lValido    = .F.
        loc_nNum       = 0
        loc_cSenha     = ""

        TRY
            loc_lValido = THIS.ValidarDados()

            IF loc_lValido
                loc_lSenhDEmps = THIS.BuscarSenhDEmps()

                IF loc_lSenhDEmps
                    loc_nNum = THIS.BuscarNumeroEmpresa()
                    loc_nNum = loc_nNum + THIS.BuscarNumeroFpag()
                    loc_nNum = loc_nNum + (THIS.this_nValors * 100)
                ENDIF

                *-- Gerar senha pelo algoritmo legado
                loc_cSenha = fGerPswDiario(THIS.this_nDocs, THIS.this_dDatas, loc_nNum)

                *-- Preencher campos gerados antes de inserir
                THIS.this_cSenhads    = LEFT(loc_cSenha, 6)
                THIS.this_cHoras      = LEFT(TIME(), 8)
                THIS.this_cIdChaves   = fUniqueIds()
                THIS.this_nTipos      = IIF(THIS.this_lProducao, 1, 0)
                THIS.this_cEmpdopnums = SPACE(29)
                THIS.this_nPerlimite  = 0
                THIS.this_cUsuars     = LEFT(gc_4c_UsuarioLogado, 10)

                IF THIS.Inserir()
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro GeraSenha")
            loc_cSenha = ""
        ENDTRY

        RETURN IIF(loc_lSucesso, loc_cSenha, "")
    ENDFUNC

    *==========================================================================
    * BuscarSenhDEmps - Consulta flag SigCdPac.senhdemps
    * Retorna .T. se a senha depende de empresa+pagamento
    *==========================================================================
    PROTECTED FUNCTION BuscarSenhDEmps()
        LOCAL loc_lSenhDEmps, loc_nRet

        loc_lSenhDEmps = .F.

        TRY
            loc_nRet = SQLEXEC(gnConnHandle, "SELECT senhdemps FROM SigCdPac", "cursor_4c_Pac")
            IF loc_nRet > 0 AND USED("cursor_4c_Pac") AND !EOF("cursor_4c_Pac")
                SELECT cursor_4c_Pac
                loc_lSenhDEmps = cursor_4c_Pac.senhdemps
            ENDIF
            IF USED("cursor_4c_Pac")
                USE IN cursor_4c_Pac
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BuscarSenhDEmps")
        ENDTRY

        RETURN loc_lSenhDEmps
    ENDFUNC

    *==========================================================================
    * BuscarNumeroEmpresa - Busca SigCdEmp.nemps pelo codigo da empresa
    * Retorna valor numerico de nemps (0 se nao encontrar)
    *==========================================================================
    PROTECTED FUNCTION BuscarNumeroEmpresa()
        LOCAL loc_nEmps, loc_nRet, loc_cSQL

        loc_nEmps = 0

        TRY
            loc_cSQL = "SELECT nemps FROM SigCdEmp WHERE Cemps = " + ;
                       EscaparSQL(LEFT(THIS.this_cEmps, 3))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp")
            IF loc_nRet > 0 AND USED("cursor_4c_Emp") AND !EOF("cursor_4c_Emp")
                SELECT cursor_4c_Emp
                loc_nEmps = NVL(cursor_4c_Emp.nemps, 0)
            ENDIF
            IF USED("cursor_4c_Emp")
                USE IN cursor_4c_Emp
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BuscarNumeroEmpresa")
        ENDTRY

        RETURN loc_nEmps
    ENDFUNC

    *==========================================================================
    * BuscarNumeroFpag - Busca SigOpFp.nfpags pelo codigo de pagamento
    * Retorna valor numerico de nfpags (0 se nao encontrar)
    *==========================================================================
    PROTECTED FUNCTION BuscarNumeroFpag()
        LOCAL loc_nFpags, loc_nRet, loc_cSQL

        loc_nFpags = 0

        TRY
            IF !EMPTY(ALLTRIM(THIS.this_cFpags))
                loc_cSQL = "SELECT nfpags FROM SigOpFp WHERE Fpags = " + ;
                           EscaparSQL(LEFT(THIS.this_cFpags, 12))

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Fpag")
                IF loc_nRet > 0 AND USED("cursor_4c_Fpag") AND !EOF("cursor_4c_Fpag")
                    SELECT cursor_4c_Fpag
                    loc_nFpags = NVL(cursor_4c_Fpag.nfpags, 0)
                ENDIF
                IF USED("cursor_4c_Fpag")
                    USE IN cursor_4c_Fpag
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BuscarNumeroFpag")
        ENDTRY

        RETURN loc_nFpags
    ENDFUNC

ENDDEFINE

