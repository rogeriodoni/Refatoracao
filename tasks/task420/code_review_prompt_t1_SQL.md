# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: IMPS, ORDEMS, NCODFINZS, DESCRS

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
  ControlSource = "crSigFiNal.ordems"
  ControlSource = "crSigFiNal.descrs"
  ControlSource = "crSigFiNal.nfixos"
  ControlSource = "crSigFiNal.ncodfinzs"
  ControlSource = "crSigFiNal.vincs"
  ControlSource = "crSigFiNal.nRelGers"
  ControlSource = "crSigFiNal.descs"
  ControlSource = "crSigFiNal.imps"
lcQryFinal = [Select a.*, b.Descrs As Descs from SigFiNal a ] + ;
             [Left Join SigFiRlg b on a.nRelGers = b.Ordems And a.Imps = b.Imps]
select CrSigFiNal
Select CrSigFiNal
		lcSql = [Select * From SigFiNal Where Imps = ']+CrSigFiNal.Imps+[' And Ordems = ]+Str(.Get_ordem.Value)
		If ThisForm.Podatamgr.SqlExecute(lcSql,'CrTmpFinal') > 0 And Reccount('CrTmpFinal') > 0
		lcSql = [Select * From SigFiNal Where Imps = ']+CrSigFiNal.Imps+[' And ncodfinzs = ]+Str(.Get_Finalz.Value)
		If ThisForm.Podatamgr.SqlExecute(lcSql,'CrTmpFinal') > 0 And Reccount('CrTmpFinal') > 0
	ThisForm.poDatamgr.SqlExecute([Select * From SigFiRlg Where Imps = '] + Alltrim(This.Parent.Cmb_Imp.Value) + ['], [csTmpRelg])
	SELECT csTmpRelg
	ThisForm.poDatamgr.SqlExecute([Select * From SigFiRlg Where Imps = '] + Alltrim(This.Parent.Cmb_Imp.Value) + ['], [csTmpRelg])
	SELECT csTmpRelg

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formfnl.prg) - TRECHOS RELEVANTES PARA PASS SQL (1603 linhas total):

*-- Linhas 342 a 360:
342:             .HighlightBackColor = RGB(255, 255, 255)
343:             .HighlightForeColor = RGB(15, 41, 104)
344:             .HighlightStyle     = 2
345:             .DeleteMark         = .F.
346:             .RecordMark         = .F.
347:             .RowHeight          = 16
348:             .ScrollBars         = 2
349:             .Visible            = .T.
350:         ENDWITH
351: 
352:         *-- BINDEVENTs dos botoes CRUD
353:         WITH loc_oPagina.cnt_4c_Botoes
354:             BINDEVENT(.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
355:             BINDEVENT(.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
356:             BINDEVENT(.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
357:             BINDEVENT(.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
358:             BINDEVENT(.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
359:             .Visible     = .T.
360:         ENDWITH

*-- Linhas 587 a 605:
587:         ENDWITH
588: 
589:         *-- OptionGroup Fixo (Opc_fixo original: top=225, left=249 -> +29: top=254)
590:         *-- Value=2 default = "Nao". ControlSource era crSigFiNal.nfixos (1=Sim, 2=Nao)
591:         loc_oPagina.AddObject("opt_4c_Opc_fixo", "OptionGroup")
592:         WITH loc_oPagina.opt_4c_Opc_fixo
593:             .ButtonCount = 2
594:             .Value       = 2
595:             .Top         = 254
596:             .Left        = 249
597:             .BackStyle   = 0
598:             .BorderStyle = 0
599:             .AutoSize    = .T.
600:             .Visible     = .T.
601:         ENDWITH
602:         WITH loc_oPagina.opt_4c_Opc_fixo.Buttons(1)
603:             .Caption   = "Sim"
604:             .Left      = 5
605:             .Top       = 5

*-- Linhas 714 a 763:
714: 
715:     *===========================================================================
716:     * CarregarLista - Carrega dados no Grid da Page1 via BO
717:     * Cursor: crSigFiNal (SigFiNal LEFT JOIN SigFiRlg)
718:     * Colunas: imps, ordems, descrs, descs
719:     *===========================================================================
720:     PROCEDURE CarregarLista()
721:         LOCAL loc_lResultado, loc_oGrid
722:         loc_lResultado = .F.
723: 
724:         TRY
725:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
726:                 loc_lResultado = .T.
727:             ELSE
728:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
729:                 IF THIS.this_oBusinessObject.Buscar("")
730:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
731: 
732:                     loc_oGrid.RecordSource = "crSigFiNal"
733:                     loc_oGrid.ColumnCount  = 4
734: 
735:                     WITH loc_oGrid
736:                         .Column1.ControlSource   = "crSigFiNal.imps"
737:                         .Column1.Width           = 160
738:                         .Column1.Header1.Caption = "Impressora"
739: 
740:                         .Column2.ControlSource   = "crSigFiNal.ordems"
741:                         .Column2.Width           = 80
742:                         .Column2.Header1.Caption = "Ordem"
743: 
744:                         .Column3.ControlSource   = "crSigFiNal.descrs"
745:                         .Column3.Width           = 350
746:                         .Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
747: 
748:                         .Column4.ControlSource   = "crSigFiNal.descs"
749:                         .Column4.Width           = 250
750:                         .Column4.Header1.Caption = "Rel. Gerencial"
751:                     ENDWITH
752: 
753:                     THIS.FormatarGridLista(loc_oGrid)
754:                     loc_lResultado = .T.
755:                 ENDIF
756:                 ENDIF
757:             ENDIF
758: 
759:         CATCH TO loException
760:             MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message, ;
761:                 "Formfnl.CarregarLista")
762:             loc_lResultado = .F.
763:         ENDTRY

*-- Linhas 852 a 870:
852:             RETURN
853:         ENDIF
854: 
855:         SELECT crSigFiNal
856:         loc_cCidChaves = ALLTRIM(crSigFiNal.cidchaves)
857: 
858:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
859:             RETURN
860:         ENDIF
861: 
862:         THIS.BOParaForm()
863:         THIS.this_cModoAtual = "VISUALIZAR"
864:         THIS.HabilitarCampos(.F.)
865:         THIS.AjustarBotoesPorModo()
866:         THIS.AlternarPagina(2)
867:     ENDPROC
868: 
869:     *===========================================================================
870:     * BtnAlterarClick - Abre Page2 para edicao do registro selecionado

*-- Linhas 878 a 896:
878:             RETURN
879:         ENDIF
880: 
881:         SELECT crSigFiNal
882:         loc_cCidChaves = ALLTRIM(crSigFiNal.cidchaves)
883: 
884:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
885:             RETURN
886:         ENDIF
887: 
888:         THIS.this_oBusinessObject.EditarRegistro()
889:         THIS.BOParaForm()
890:         THIS.this_cModoAtual = "ALTERAR"
891:         THIS.HabilitarCampos(.T.)
892:         THIS.AjustarBotoesPorModo()
893:         THIS.AlternarPagina(2)
894:         IF VARTYPE(THIS.pgf_4c_Paginas.Page2.txt_4c_Ordem) = "O"
895:             THIS.pgf_4c_Paginas.Page2.txt_4c_Ordem.SetFocus
896:         ENDIF

*-- Linhas 909 a 927:
909:             RETURN
910:         ENDIF
911: 
912:         SELECT crSigFiNal
913:         loc_cCidChaves = ALLTRIM(crSigFiNal.cidchaves)
914:         loc_cDescrs    = ALLTRIM(crSigFiNal.descrs)
915: 
916:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o de:" + CHR(13) + loc_cDescrs, "Excluir")
917:             RETURN
918:         ENDIF
919: 
920:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
921:             RETURN
922:         ENDIF
923: 
924:         IF THIS.this_oBusinessObject.Excluir()
925:             MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Excluir")
926:             THIS.CarregarLista()
927:         ENDIF

*-- Linhas 942 a 963:
942:     ENDPROC
943: 
944:     *===========================================================================
945:     * BtnSalvarClick - Salva o registro (INSERT ou UPDATE)
946:     * Validacoes: Impressora obrigatoria, Ordem obrigatoria,
947:     *             Ordem nao duplicada (INSERT), Codigo nao duplicado (INSERT)
948:     * Gera: cidchaves (INSERT), ncodfinzs se 0 (INSERT)
949:     *===========================================================================
950:     PROCEDURE BtnSalvarClick()
951:         LOCAL loc_lSucesso, loc_oPg2, loc_cImps, loc_nOrdems, loc_nFinalz
952:         loc_lSucesso = .F.
953:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
954:         loc_cImps   = ""
955:         loc_nOrdems = 0
956:         loc_nFinalz = 0
957: 
958:         *-- Validacoes FORA do TRY para permitir RETURN direto
959:         IF VARTYPE(loc_oPg2.cbo_4c_Cmb_Imp) = "O"
960:             loc_cImps = ALLTRIM(loc_oPg2.cbo_4c_Cmb_Imp.Value)
961:         ENDIF
962: 
963:         IF EMPTY(loc_cImps)

*-- Linhas 1315 a 1338:
1315:             RETURN
1316:         ENDIF
1317: 
1318:         loc_cSQL    = "SELECT Ordems, Descrs FROM SigFiRlg WHERE Imps = " + ;
1319:             EscaparSQL(loc_cImps)
1320:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "csTmpRelgBusca")
1321: 
1322:         IF loc_nResult > 0 AND USED("csTmpRelgBusca")
1323:             SELECT csTmpRelgBusca
1324:             LOCATE FOR Ordems = loc_nCod
1325: 
1326:             IF !EOF("csTmpRelgBusca")
1327:                 IF VARTYPE(loc_oPg2.txt_4c_DesRelGer) = "O"
1328:                     loc_oPg2.txt_4c_DesRelGer.Value = ALLTRIM(csTmpRelgBusca.Descrs)
1329:                 ENDIF
1330:             ELSE
1331:                 IF USED("csTmpRelgBusca")
1332:                     USE IN csTmpRelgBusca
1333:                 ENDIF
1334:                 THIS.AbrirLookupRelGerPorCodigo()
1335:                 THIS.AtualizarEstadoDesRelGer()
1336:                 RETURN
1337:             ENDIF
1338:         ENDIF

*-- Linhas 1385 a 1408:
1385:             RETURN
1386:         ENDIF
1387: 
1388:         loc_cSQL    = "SELECT Ordems, Descrs FROM SigFiRlg WHERE Imps = " + ;
1389:             EscaparSQL(loc_cImps)
1390:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "csTmpRelgBusca")
1391: 
1392:         IF loc_nResult > 0 AND USED("csTmpRelgBusca")
1393:             SELECT csTmpRelgBusca
1394:             LOCATE FOR UPPER(ALLTRIM(Descrs)) = UPPER(loc_cDes)
1395: 
1396:             IF !EOF("csTmpRelgBusca")
1397:                 IF VARTYPE(loc_oPg2.txt_4c_CodRelGer) = "O"
1398:                     loc_oPg2.txt_4c_CodRelGer.Value = csTmpRelgBusca.Ordems
1399:                 ENDIF
1400:                 IF VARTYPE(loc_oPg2.txt_4c_DesRelGer) = "O"
1401:                     loc_oPg2.txt_4c_DesRelGer.Value = ALLTRIM(csTmpRelgBusca.Descrs)
1402:                 ENDIF
1403:             ELSE
1404:                 IF USED("csTmpRelgBusca")
1405:                     USE IN csTmpRelgBusca
1406:                 ENDIF
1407:                 THIS.AbrirLookupRelGerPorDescricao()
1408:                 THIS.AtualizarEstadoDesRelGer()

*-- Linhas 1440 a 1481:
1440:             RETURN
1441:         ENDIF
1442: 
1443:         loc_cSQL    = "SELECT Ordems, Descrs FROM SigFiRlg WHERE Imps = " + ;
1444:             EscaparSQL(loc_cImps)
1445:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "csTmpRelgLkp")
1446: 
1447:         IF loc_nResult <= 0 OR !USED("csTmpRelgLkp") OR RECCOUNT("csTmpRelgLkp") = 0
1448:             IF USED("csTmpRelgLkp")
1449:                 USE IN csTmpRelgLkp
1450:             ENDIF
1451:             MsgAviso("Nenhum Relat" + CHR(243) + "rio Gerencial para a impressora selecionada.", ;
1452:                 "Lookup")
1453:             RETURN
1454:         ENDIF
1455: 
1456:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1457: 
1458:         IF VARTYPE(loc_oBusca) = "O"
1459:             loc_oBusca.this_cCursorDestino = "csTmpRelgLkp"
1460:             loc_oBusca.this_cTitulo        = "Rel. Gerencial"
1461:             loc_oBusca.mAddColuna("Ordems", "", "C" + CHR(243) + "digo")
1462:             loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
1463:             loc_oBusca.Show()
1464: 
1465:             IF loc_oBusca.this_lSelecionou AND USED("csTmpRelgLkp")
1466:                 SELECT csTmpRelgLkp
1467:                 IF VARTYPE(loc_oPg2.txt_4c_CodRelGer) = "O"
1468:                     loc_oPg2.txt_4c_CodRelGer.Value = csTmpRelgLkp.Ordems
1469:                 ENDIF
1470:                 IF VARTYPE(loc_oPg2.txt_4c_DesRelGer) = "O"
1471:                     loc_oPg2.txt_4c_DesRelGer.Value = ALLTRIM(csTmpRelgLkp.Descrs)
1472:                 ENDIF
1473:             ELSE
1474:                 IF !loc_oBusca.this_lSelecionou
1475:                 IF VARTYPE(loc_oPg2.txt_4c_CodRelGer) = "O"
1476:                     loc_oPg2.txt_4c_CodRelGer.Value = 0
1477:                 ENDIF
1478:                 IF VARTYPE(loc_oPg2.txt_4c_DesRelGer) = "O"
1479:                     loc_oPg2.txt_4c_DesRelGer.Value = ""
1480:                 ENDIF
1481:                 ENDIF

*-- Linhas 1513 a 1554:
1513:             RETURN
1514:         ENDIF
1515: 
1516:         loc_cSQL    = "SELECT Ordems, Descrs FROM SigFiRlg WHERE Imps = " + ;
1517:             EscaparSQL(loc_cImps)
1518:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "csTmpRelgLkp")
1519: 
1520:         IF loc_nResult <= 0 OR !USED("csTmpRelgLkp") OR RECCOUNT("csTmpRelgLkp") = 0
1521:             IF USED("csTmpRelgLkp")
1522:                 USE IN csTmpRelgLkp
1523:             ENDIF
1524:             MsgAviso("Nenhum Relat" + CHR(243) + "rio Gerencial para a impressora selecionada.", ;
1525:                 "Lookup")
1526:             RETURN
1527:         ENDIF
1528: 
1529:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1530: 
1531:         IF VARTYPE(loc_oBusca) = "O"
1532:             loc_oBusca.this_cCursorDestino = "csTmpRelgLkp"
1533:             loc_oBusca.this_cTitulo        = "Rel. Gerencial"
1534:             loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
1535:             loc_oBusca.mAddColuna("Ordems", "", "C" + CHR(243) + "digo")
1536:             loc_oBusca.Show()
1537: 
1538:             IF loc_oBusca.this_lSelecionou AND USED("csTmpRelgLkp")
1539:                 SELECT csTmpRelgLkp
1540:                 IF VARTYPE(loc_oPg2.txt_4c_CodRelGer) = "O"
1541:                     loc_oPg2.txt_4c_CodRelGer.Value = csTmpRelgLkp.Ordems
1542:                 ENDIF
1543:                 IF VARTYPE(loc_oPg2.txt_4c_DesRelGer) = "O"
1544:                     loc_oPg2.txt_4c_DesRelGer.Value = ALLTRIM(csTmpRelgLkp.Descrs)
1545:                 ENDIF
1546:             ELSE
1547:                 IF !loc_oBusca.this_lSelecionou
1548:                 IF VARTYPE(loc_oPg2.txt_4c_CodRelGer) = "O"
1549:                     loc_oPg2.txt_4c_CodRelGer.Value = 0
1550:                 ENDIF
1551:                 IF VARTYPE(loc_oPg2.txt_4c_DesRelGer) = "O"
1552:                     loc_oPg2.txt_4c_DesRelGer.Value = ""
1553:                 ENDIF
1554:                 ENDIF


### BO (C:\4c\projeto\app\classes\fnlBO.prg):
*==============================================================================
* fnlBO.prg - Business Object para Tabela de Finalizacoes (SigFiNal)
* Herda de: BusinessBase
* Tabela: SigFiNal (PK: cidchaves)
*==============================================================================

DEFINE CLASS fnlBO AS BusinessBase

    *-- Propriedades da tabela SigFiNal
    this_cCidChaves  = ""   && char(20) PK - chave unica interna
    this_cImps       = ""   && char(20) - Impressora
    this_nOrdems     = 0    && numeric(2,0) - Ordem finalizadora
    this_cDescrs     = ""   && char(40) - Descricao
    this_nCodFinzs   = 0    && numeric(2,0) - Codigo finalizador
    this_nFixos      = 2    && numeric(1,0) - Fixo (1=Sim, 2=Nao)
    this_cVincs      = "N"  && char(1) - Vinculado (S/N)
    this_nRelGers    = 0    && numeric(1,0) - FK SigFiRlg.ordems
    this_cDescs      = ""   && alias SigFiRlg.descrs (nao coluna real - lookup display)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigFiNal"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves  = TratarNulo(cidchaves,  "C")
            THIS.this_cImps       = TratarNulo(imps,       "C")
            THIS.this_nOrdems     = TratarNulo(ordems,     "N")
            THIS.this_cDescrs     = TratarNulo(descrs,     "C")
            THIS.this_nCodFinzs   = TratarNulo(ncodfinzs,  "N")
            THIS.this_nFixos      = TratarNulo(nfixos,     "N")
            THIS.this_cVincs      = TratarNulo(vincs,      "C")
            THIS.this_nRelGers    = TratarNulo(nrelgers,   "N")
            *-- descs vem do JOIN; se coluna existir no cursor, carregar
            IF TYPE("descs") != "U"
                THIS.this_cDescs  = TratarNulo(descs,      "C")
            ELSE
                THIS.this_cDescs  = ""
            ENDIF
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.cidchaves, a.imps, a.ordems, a.descrs," + ;
                       " a.nfixos, a.ncodfinzs, a.vincs, a.nrelgers," + ;
                       " b.descrs AS descs" + ;
                       " FROM SigFiNal a" + ;
                       " LEFT JOIN SigFiRlg b ON b.ordems = a.nrelgers AND b.imps = a.imps"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.imps, a.ordems"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crSigFiNal")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar finalizacoes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCidChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.cidchaves, a.imps, a.ordems, a.descrs," + ;
                       " a.nfixos, a.ncodfinzs, a.vincs, a.nrelgers," + ;
                       " b.descrs AS descs" + ;
                       " FROM SigFiNal a" + ;
                       " LEFT JOIN SigFiRlg b ON b.ordems = a.nrelgers AND b.imps = a.imps" + ;
                       " WHERE a.cidchaves = " + EscaparSQL(par_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CarregaFnl")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_CarregaFnl") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_CarregaFnl")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar finalizacao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_CarregaFnl")
            USE IN cursor_4c_CarregaFnl
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarRelGerencial - Busca registros de SigFiRlg para lookup de Rel. Gerencial
    *--------------------------------------------------------------------------
    PROCEDURE BuscarRelGerencial(par_cImps, par_cCursorDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        IF EMPTY(par_cCursorDestino)
            par_cCursorDestino = "cursor_4c_RelGer"
        ENDIF

        TRY
            loc_cSQL = "SELECT ordems, descrs FROM SigFiRlg" + ;
                       " WHERE imps = " + EscaparSQL(par_cImps) + ;
                       " ORDER BY ordems"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino)

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar Rel. Gerencial:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigFiNal" + ;
                       " (cidchaves, imps, ordems, descrs, nfixos, ncodfinzs, vincs, nrelgers)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cImps) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nOrdems) + ", " + ;
                       EscaparSQL(THIS.this_cDescrs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nFixos) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCodFinzs) + ", " + ;
                       EscaparSQL(THIS.this_cVincs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nRelGers) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir finalizacao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigFiNal SET" + ;
                       " imps = "      + EscaparSQL(THIS.this_cImps) + ", " + ;
                       " ordems = "    + FormatarNumeroSQL(THIS.this_nOrdems) + ", " + ;
                       " descrs = "    + EscaparSQL(THIS.this_cDescrs) + ", " + ;
                       " nfixos = "    + FormatarNumeroSQL(THIS.this_nFixos) + ", " + ;
                       " ncodfinzs = " + FormatarNumeroSQL(THIS.this_nCodFinzs) + ", " + ;
                       " vincs = "     + EscaparSQL(THIS.this_cVincs) + ", " + ;
                       " nrelgers = "  + FormatarNumeroSQL(THIS.this_nRelGers) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar finalizacao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigFiNal WHERE cidchaves = " + ;
                       EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir finalizacao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarOrdemDuplicada - Verifica se Imps+Ordems ja existe (INSERT)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarOrdemDuplicada(par_cImps, par_nOrdems)
        LOCAL loc_cSQL, loc_nResultado, loc_lDuplicado
        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT * FROM SigFiNal WHERE imps = " + ;
                       EscaparSQL(par_cImps) + ;
                       " AND ordems = " + FormatarNumeroSQL(par_nOrdems)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldOrd")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_VldOrd") > 0
                loc_lDuplicado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_VldOrd")
            USE IN cursor_4c_VldOrd
        ENDIF

        RETURN loc_lDuplicado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCodigoDuplicado - Verifica se Imps+ncodfinzs ja existe (INSERT)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCodigoDuplicado(par_cImps, par_nCodFinzs)
        LOCAL loc_cSQL, loc_nResultado, loc_lDuplicado
        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT * FROM SigFiNal WHERE imps = " + ;
                       EscaparSQL(par_cImps) + ;
                       " AND ncodfinzs = " + FormatarNumeroSQL(par_nCodFinzs)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldCod")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_VldCod") > 0
                loc_lDuplicado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_VldCod")
            USE IN cursor_4c_VldCod
        ENDIF

        RETURN loc_lDuplicado
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarNovaCidChaves - Gera identificador unico para cidchaves (substitui fUniqueIds)
    * Usa NEWID() do SQL Server truncado para 20 chars
    *--------------------------------------------------------------------------
    PROCEDURE GerarNovaCidChaves()
        LOCAL loc_cResultado, loc_nRes
        loc_cResultado = ""

        TRY
            loc_nRes = SQLEXEC(gnConnHandle, ;
                "SELECT LEFT(REPLACE(CONVERT(varchar(36), NEWID()), '-', ''), 20) AS NewId", ;
                "cursor_4c_NewId")
            IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_NewId") > 0
                SELECT cursor_4c_NewId
                loc_cResultado = ALLTRIM(cursor_4c_NewId.NewId)
            ENDIF
        CATCH TO loException
            loc_cResultado = LEFT(SYS(2015) + SYS(2015) + SYS(2015), 20)
        ENDTRY

        IF USED("cursor_4c_NewId")
            USE IN cursor_4c_NewId
        ENDIF

        RETURN loc_cResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarProximoNcodFinzs - Proximo codigo finalizador disponivel por impressora
    * Substitui fGerUniqueKey('SigFiNal') do legado
    *--------------------------------------------------------------------------
    PROCEDURE GerarProximoNcodFinzs(par_cImps)
        LOCAL loc_nResultado, loc_nProximo
        loc_nProximo = 1

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT ISNULL(MAX(ncodfinzs), 0) + 1 AS Proximo FROM SigFiNal" + ;
                " WHERE imps = " + EscaparSQL(par_cImps), ;
                "cursor_4c_ProxCod")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ProxCod") > 0
                SELECT cursor_4c_ProxCod
                loc_nProximo = cursor_4c_ProxCod.Proximo
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao gerar pr" + CHR(243) + "ximo c" + CHR(243) + "digo:" + ;
                CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_ProxCod")
            USE IN cursor_4c_ProxCod
        ENDIF

        RETURN loc_nProximo
    ENDPROC

ENDDEFINE

