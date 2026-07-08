# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-ASPAS] Linha 312: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: "WHERE EmpGruEsts = '" + loc_cEmpGE + "' AND NOT Sqtds = 0"
- [SQL-ASPAS] Linha 335: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: "WHERE EmpGruEsts = '" + loc_cEmpGE + "' AND NOT Sqtds = 0"
- [SQL-ASPAS] Linha 464: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: "WHERE a.EmpDopNums BETWEEN '" + loc_cEdI + "' AND '" + loc_cEdF + "' AND " + ;
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPGRUESTS, 1, PESOMS, X, EMPDOPNUMS, QTDPFINS, SEQS, CPROS

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
Insert Into dbCabecalho (Titulo, SubTitulo, NomeEmpresa) Values (lcCab, lcSub, lcEmp)
Select csRel
lcQuery = [Select Cgrus, Dgrus ] + ;
			[From SigCdGrp ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crGrupo') < 1)
Select crGrupo
lcQuery = [Select Distinct GruEstPs as Grupos, ConEstps as Estos ] + ;
			[From SigCdGrp ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdGrp') < 1)
	Select crSigCdGrp
	lcQuery = [Select * ] + ;
				[From SigMvEst ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'pEstoque') < 1)
	lcQuery = [Select * ] + ;
				[From SigMvEst ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'pEstoque') < 1)
	Select crSigCdGrp
		lcQuery = [Select * ] + ;
					[From SigMvEst ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpEst') < 1)
		Select TmpEst
			Insert Into pEstoque From Memvar
Select crGrupo
Select pEstoque
	If Not Seek(crSigCdPro.Cgrus, 'crGrupo', 'Cgrus')
	Select csRel
	If Not Seek(pEstoque.Cpros + CrSigCdPro.cUnis)
		Select csRel
		If Not Seek(pEstoque.Cpros + CrSigCdPro.cUnips)
	lcQuery = [Select b.EmpDopNums, b.CPros, b.Qtds, b.QtBaixas, c.Cgrus, c.QMins, c.Dpros, c.CUnis, c.cUnips, c.PesoMs ] + ;
			    [From SigMvCab a, SigMvItn b, SigCdPro c ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crOperacao') < 1)
	Select crOperacao
		If Seek(crOperacao.Cgrus, 'crGrupo', 'Cgrus')
			Select csRel
			If Not Seek(crOperacao.Cpros+CrOperacao.cUnis)
				If Not Seek(crOperacao.Cpros+CrOperacao.cUniPs)
Select csRel
	Select csRel
		Select csRel
			.Column1.ControlSource  = 'csRel.Mat2s'
			.Column2.ControlSource  = 'csRel.dCompo2s'
			.Column3.ControlSource  = 'csRel.cUnis'
			.Column4.ControlSource  = 'csRel.qtdMins'
			.Column5.ControlSource  = 'csRel.Qtds'
			.Column6.ControlSource  = 'csRel.QtdReqs'
			.Column7.ControlSource  = 'csRel.QtdPedcs'
			.Column8.ControlSource  = 'csRel.QtdComps'
			.Column9.ControlSource  = 'csRel.QtdEmphs'
			.Column10.ControlSource = 'csRel.QtdPfins'
	Select csRel
Select csRel

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdAco.prg) - TRECHOS RELEVANTES PARA PASS SQL (1166 linhas total):

*-- Linhas 298 a 351:
298:             .Themes          = .F.
299:             .SpecialEffect   = 0
300:             .PicturePosition = 13
301:             .MousePointer    = 15
302:             .WordWrap        = .T.
303:             .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
304:             .Visible         = .F.
305:         ENDWITH
306:         BINDEVENT(THIS.cmd_4c_CmdRpview, "Click", THIS, "BtnCmdRpviewClick")
307: 
308:         *-- Botao Imprimir relatorio (oculto ate processar)
309:         THIS.AddObject("cmd_4c_CmdRpPrint", "CommandButton")
310:         WITH THIS.cmd_4c_CmdRpPrint
311:             .Top             = 3
312:             .Left            = 575
313:             .Width           = 75
314:             .Height          = 75
315:             .Caption         = "Impressora"
316:             .FontName        = "Comic Sans MS"
317:             .FontBold        = .T.
318:             .FontItalic      = .T.
319:             .FontSize        = 8
320:             .ForeColor       = RGB(90, 90, 90)
321:             .BackColor       = RGB(255, 255, 255)
322:             .Themes          = .F.
323:             .SpecialEffect   = 0
324:             .PicturePosition = 13
325:             .MousePointer    = 15
326:             .WordWrap        = .T.
327:             .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
328:             .Visible         = .F.
329:         ENDWITH
330:         BINDEVENT(THIS.cmd_4c_CmdRpPrint, "Click", THIS, "BtnCmdRpPrintClick")
331: 
332:         *-- CommandGroup de saida equivalente a Encerrar (posicao top-right no form 800px)
333:         THIS.AddObject("obj_4c_CmdGprocessa", "CommandGroup")
334:         WITH THIS.obj_4c_CmdGprocessa
335:             .Top           = -2
336:             .Left          = 720
337:             .Width         = 85
338:             .Height        = 85
339:             .ButtonCount   = 1
340:             .BackStyle     = 0
341:             .BorderStyle   = 0
342:             .Themes        = .F.
343:             .AutoSize      = .T.
344:             .SpecialEffect = 1
345:             .BorderColor   = RGB(136, 189, 188)
346:         ENDWITH
347:         WITH THIS.obj_4c_CmdGprocessa.Buttons(1)
348:             .Left            = 5
349:             .Top             = 5
350:             .Width           = 75
351:             .Height          = 75

*-- Linhas 412 a 485:
412:             .HighlightBackColor = RGB(255, 255, 255)
413:             .HighlightForeColor = RGB(15, 41, 104)
414:             .HighlightStyle     = 2
415:             .DeleteMark         = .F.
416:             .RecordMark         = .F.
417:             .RowHeight          = 16
418:             .ScrollBars         = 2
419:             .RecordSource       = "csRel"
420:             .RecordSourceType   = 1
421:         ENDWITH
422: 
423:         *-- Colunas: ControlSource + Header + Width (ordem identica ao csRel original)
424:         WITH loc_oGrd
425:             .Column1.ControlSource   = "csRel.Mat2s"
426:             .Column1.Width           = 80
427:             .Column1.Alignment       = 0
428:             .Column1.Header1.Caption = "Material"
429: 
430:             .Column2.ControlSource   = "csRel.Dcompo2s"
431:             .Column2.Width           = 130
432:             .Column2.Alignment       = 0
433:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
434: 
435:             .Column3.ControlSource   = "csRel.CUnis"
436:             .Column3.Width           = 27
437:             .Column3.Alignment       = 2
438:             .Column3.Header1.Caption = "Unid"
439: 
440:             .Column4.ControlSource   = "csRel.QtdMins"
441:             .Column4.Width           = 63
442:             .Column4.Alignment       = 2
443:             .Column4.Header1.Caption = "Qt.M" + CHR(237) + "nima"
444: 
445:             .Column5.ControlSource   = "csRel.Qtds"
446:             .Column5.Width           = 63
447:             .Column5.Alignment       = 2
448:             .Column5.Header1.Caption = "Saldo Atual"
449: 
450:             .Column6.ControlSource   = "csRel.QtdReqs"
451:             .Column6.Width           = 65
452:             .Column6.Alignment       = 2
453:             .Column6.Header1.Caption = "Requisi" + CHR(231) + CHR(227) + "o"
454: 
455:             .Column7.ControlSource   = "csRel.QtdPedcs"
456:             .Column7.Width           = 65
457:             .Column7.Alignment       = 2
458:             .Column7.Header1.Caption = "Ped.Compra"
459: 
460:             .Column8.ControlSource   = "csRel.QtdComps"
461:             .Column8.Width           = 65
462:             .Column8.Alignment       = 2
463:             .Column8.Header1.Caption = "Compra"
464: 
465:             .Column9.ControlSource   = "csRel.QtdEmphs"
466:             .Column9.Width           = 65
467:             .Column9.Alignment       = 2
468:             .Column9.Header1.Caption = "Empenho"
469: 
470:             .Column10.ControlSource   = "csRel.QtdPfins"
471:             .Column10.Width           = 70
472:             .Column10.Alignment       = 2
473:             .Column10.Header1.Caption = "Pos.Final *"
474:         ENDWITH
475: 
476:         *-- Propriedades visuais pixel-perfect (BackColor por coluna, ReadOnly, DynamicForeColor)
477:         THIS.ConfigurarGrdDados(loc_oGrd)
478:     ENDPROC
479: 
480:     *==========================================================================
481:     * ConfigurarPaginaDados - Rodape com notas explicativas
482:     *   Form OPERACIONAL nao tem Page2/Dados como CRUD. Este metodo agrupa
483:     *   os labels explicativos do calculo de Pos.Final exibidos abaixo do grid.
484:     *==========================================================================
485:     PROTECTED PROCEDURE ConfigurarPaginaDados()

*-- Linhas 589 a 607:
589:         ENDIF
590: 
591:         IF USED("csRel")
592:             SELECT csRel
593:             ZAP
594:         ENDIF
595: 
596:         THIS.this_lProcessamento = .F.
597:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
598:             THIS.this_oBusinessObject.this_lProcessamento = .F.
599:         ENDIF
600: 
601:         THIS.shp_4c_ShpRp.Visible      = .F.
602:         THIS.cmd_4c_CmdRpview.Visible  = .F.
603:         THIS.cmd_4c_CmdRpPrint.Visible = .F.
604:         THIS.grd_4c_Dados.Refresh
605:     ENDPROC
606: 
607:     *==========================================================================

*-- Linhas 1026 a 1044:
1026:            !EMPTY(THIS.obj_4c_Arquivos.Value)
1027:             THIS.ArquivosInteractiveChange()
1028:         ELSE
1029:             SELECT csRel
1030:             SET ORDER TO TAG GruMat
1031:             SET KEY TO
1032:             GO TOP
1033:         ENDIF
1034: 
1035:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
1036:             THIS.grd_4c_Dados.Refresh
1037:         ENDIF
1038:     ENDPROC
1039: 
1040:     *==========================================================================
1041:     * AjustarBotoesPorModo - Gerencia visibilidade de botoes conforme estado
1042:     *   Form OPERACIONAL: mostra/oculta os botoes de relatorio (Video,
1043:     *   Impressora, ShpRp) de acordo com o estado de processamento atual.
1044:     *==========================================================================

*-- Linhas 1079 a 1103:
1079:     *==========================================================================
1080:     PROTECTED PROCEDURE LimparCampos()
1081:         IF USED("csRel")
1082:             SELECT csRel
1083:             SET KEY TO
1084:             ZAP
1085:         ENDIF
1086: 
1087:         IF USED("csCab")
1088:             SELECT csCab
1089:             ZAP
1090:             APPEND BLANK
1091:         ENDIF
1092: 
1093:         IF VARTYPE(THIS.obj_4c_Arquivos) = "O"
1094:             THIS.obj_4c_Arquivos.Clear()
1095:         ENDIF
1096: 
1097:         THIS.this_lProcessamento = .F.
1098: 
1099:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1100:             THIS.this_oBusinessObject.this_lProcessamento = .F.
1101:             THIS.this_oBusinessObject.this_cGrupoAtual    = ""
1102:         ENDIF
1103: 


### BO (C:\4c\projeto\app\classes\SigPdAcoBO.prg):
*==============================================================================
* SigPdAcoBO.prg - Business Object: Acompanhamento de Material por Grupo
* Form Operacional - sem tabela principal unica (multi-tabelas)
* Tabelas: SigMvEst, SigCdPro, SigMvCab, SigMvItn, SigCdGrp, SigCdPam, SigCdEmp
*==============================================================================

DEFINE CLASS SigPdAcoBO AS BusinessBase

    *-- Controle de estado do processamento
    this_lProcessamento  = .F.

    *-- Parametros de operacoes carregados de SigCdPam
    this_cDopEmphs   = ""
    this_cDopReqcs   = ""
    this_cDopPedcs   = ""
    this_cDopComps   = ""
    this_cDopTrfCps  = ""

    *-- Cabecalho do relatorio
    this_cTituloRel   = ""
    this_cSubTitulo   = ""
    this_cNomeEmpresa = ""

    *-- Filtro corrente
    this_cGrupoAtual  = ""

    *--------------------------------------------------------------------------
    * Init - Configura BO (form operacional sem tabela CRUD unica)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor de parametros para this_*
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cDopEmphs  = TratarNulo(DopEmphs,  "C")
            THIS.this_cDopReqcs  = TratarNulo(DopReqcs,  "C")
            THIS.this_cDopPedcs  = TratarNulo(DopPedcs,  "C")
            THIS.this_cDopComps  = TratarNulo(DopComps,  "C")
            THIS.this_cDopTrfCps = TratarNulo(DopTrfCps, "C")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Form operacional sem chave unica
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ""
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Executa primeira geracao do relatorio
    *   Form operacional de relatorio: a operacao "Inserir" equivale a executar
    *   o processamento inicial que monta o cursor csRel com saldos atuais,
    *   parametros e empresa. Retorna .T. se o processamento foi bem sucedido
    *   e o cursor csRel ficou disponivel para o Grid.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir(par_oListbox)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Garante parametros e cursores prontos
            IF EMPTY(THIS.this_cDopEmphs) .AND. EMPTY(THIS.this_cDopReqcs) .AND. ;
               EMPTY(THIS.this_cDopPedcs) .AND. EMPTY(THIS.this_cDopComps) .AND. ;
               EMPTY(THIS.this_cDopTrfCps)
                THIS.CarregarParametros()
            ENDIF

            IF !USED("csRel") .OR. !USED("csCab")
                THIS.CriarCursorRelatorio()
            ENDIF

            *-- Executa processamento real (popula csRel + listbox de grupos)
            loc_lSucesso = THIS.Processar(par_oListbox)

            IF loc_lSucesso
                THIS.this_lProcessamento = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Re-executa processamento do relatorio
    *   Form operacional de relatorio: a operacao "Atualizar" equivale a
    *   recalcular saldos atuais. Zera csRel, reprocessa do zero e mantem
    *   o filtro de grupo corrente. Usado quando o usuario clica "Processar"
    *   apos primeira execucao para refletir mudancas em estoque.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar(par_oListbox)
        LOCAL loc_lSucesso, loc_cGrupoAnterior
        loc_lSucesso = .F.
        loc_cGrupoAnterior = THIS.this_cGrupoAtual

        TRY
            *-- Limpa filtro previo para nao interferir no SCAN do Processar
            IF USED("csRel")
                SELECT csRel
                SET KEY TO
                ZAP
            ENDIF

            *-- Reprocessa carregando saldos atuais
            loc_lSucesso = THIS.Processar(par_oListbox)

            IF loc_lSucesso
                THIS.this_lProcessamento = .T.

                *-- Restaura filtro de grupo se havia um ativo
                IF !EMPTY(loc_cGrupoAnterior) .AND. USED("csRel")
                    THIS.FiltrarPorGrupo(loc_cGrupoAnterior)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametros - Carrega parametros de operacao de SigCdPam
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT DopEmphs, DopReqcs, DopPedcs, DopComps, DopTrfCps " + ;
                       "FROM SigCdPam"

            IF USED("cursor_4c_Pam")
                USE IN cursor_4c_Pam
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam") > 0
                IF !EOF("cursor_4c_Pam")
                    THIS.CarregarDoCursor("cursor_4c_Pam")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarEmpresa - Carrega nome da empresa logada para this_cNomeEmpresa
    *--------------------------------------------------------------------------
    PROCEDURE CarregarEmpresa()
        LOCAL loc_cSQL, loc_cCodEmp
        loc_cCodEmp = go_4c_Sistema.cCodEmpresa

        TRY
            loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(ALLTRIM(loc_cCodEmp))

            IF USED("cursor_4c_Emp")
                USE IN cursor_4c_Emp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp") > 0 .AND. !EOF("cursor_4c_Emp")
                SELECT cursor_4c_Emp
                THIS.this_cNomeEmpresa = ALLTRIM(loc_cCodEmp) + " - " + ALLTRIM(TratarNulo(Razas, "C"))
            ELSE
                THIS.this_cNomeEmpresa = ALLTRIM(loc_cCodEmp)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCursorRelatorio - Cria cursores csRel e csCab para o relatorio
    *                        Estrutura IDENTICA a do Load original
    *--------------------------------------------------------------------------
    PROCEDURE CriarCursorRelatorio()
        IF USED("csCab")
            USE IN csCab
        ENDIF
        IF USED("csRel")
            USE IN csRel
        ENDIF

        CREATE CURSOR csCab (cbemp C(60), cbtit C(100), cbsubtit C(100))
        APPEND BLANK

        SET NULL ON
        CREATE CURSOR csRel ( ;
            Cgrus    C(3)    NULL, ;
            Mats     C(10)   NULL, ;
            Dcompos  C(30)   NULL, ;
            Qtds     N(10,3) NULL, ;
            QtdMins  N(10,3) NULL, ;
            CUnis    C(3)    NULL, ;
            QtdReqs  N(10,3) NULL, ;
            QtdPedcs N(10,3) NULL, ;
            QtdComps N(10,3) NULL, ;
            QtdEmphs N(10,3) NULL, ;
            QtdPfins N(10,3) NULL, ;
            QtdPfMs  N(12,3) NULL, ;
            Flags    L       NULL, ;
            Mat2s    C(10)   NULL, ;
            Dcompo2s C(30)   NULL, ;
            Seqs     C(1)    NULL, ;
            PesoMs   N(12,3) NULL  ;
        )
        SET NULL OFF

        INDEX ON Cgrus + Mats + Seqs TAG GruMat
        INDEX ON Mats + CUnis TAG Mats
    ENDPROC

    *--------------------------------------------------------------------------
    * Processar - Processa saldos e movimentacoes por grupo de material
    *             Popula cursor csRel. par_oListbox recebe grupos encontrados.
    *--------------------------------------------------------------------------
    PROCEDURE Processar(par_oListbox)
        LOCAL loc_lSucesso, loc_cSQL, loc_cCodEmp, loc_cEmpGE
        LOCAL loc_nX, loc_cOperBusca, loc_cCampo, loc_cEdI, loc_cEdF, loc_qtMin
        LOCAL loc_cCPros_s, loc_cDPros_s, loc_cCUnis_s, loc_cCGrus_s, loc_cCUniPs_s
        LOCAL loc_nQMins_s, loc_nPesoMs_s, loc_nSqtds_s, loc_nSPesos_s
        LOCAL loc_cCPros_o, loc_cCUnis_o, loc_cCUniPs_o, loc_cCGrus_o, loc_cDPros_o
        LOCAL loc_nQMins_o, loc_nPesoMs_o, loc_nQtdDiff_o

        loc_lSucesso = .F.
        loc_cCodEmp  = go_4c_Sistema.cCodEmpresa

        TRY
            *-- Prepara titulo e cabecalho do relatorio
            THIS.this_cTituloRel = "Relat" + CHR(243) + "rio de Acompanhamento de Material por Grupo"
            THIS.this_cSubTitulo = " "
            THIS.CarregarEmpresa()

            IF USED("csCab")
                SELECT csCab
                REPLACE cbemp    WITH THIS.this_cNomeEmpresa, ;
                        cbtit    WITH THIS.this_cTituloRel,   ;
                        cbsubtit WITH THIS.this_cSubTitulo
            ENDIF

            *-- Zera ou (re)cria csRel
            IF USED("csRel")
                SELECT csRel
                ZAP
            ELSE
                THIS.CriarCursorRelatorio()
            ENDIF

            *-- Carrega grupos validos (crGrupo com index por Cgrus)
            loc_cSQL = "SELECT Cgrus, Dgrus FROM SigCdGrp " + ;
                       "WHERE NOT GruEstPs = '" + SPACE(10) + "' AND " + ;
                             "NOT ConEstPs = '" + SPACE(10) + "'"

            IF USED("crGrupo")
                USE IN crGrupo
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "crGrupo") < 1
                MsgAviso("Falha na conex" + CHR(227) + "o (crGrupo)", "Aviso")
                loc_lSucesso = loc_lSucesso
            ENDIF
            SELECT crGrupo
            INDEX ON Cgrus TAG Cgrus

            *-- Carrega combinacoes Grupos/Estos para busca no estoque
            loc_cSQL = "SELECT DISTINCT GruEstPs AS Grupos, ConEstps AS Estos " + ;
                       "FROM SigCdGrp " + ;
                       "WHERE NOT GruEstPs = '" + SPACE(10) + "' AND " + ;
                             "NOT ConEstPs = '" + SPACE(10) + "'"

            IF USED("crSigCdGrp")
                USE IN crSigCdGrp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdGrp") < 1
                MsgAviso("Falha na conex" + CHR(227) + "o (crSigCdGrp)", "Aviso")
                loc_lSucesso = loc_lSucesso
            ENDIF

            *-- Cria cursor acumulador de estoque (writable) com campos necessarios
            IF USED("pEstoque")
                USE IN pEstoque
            ENDIF
            SET NULL ON
            CREATE CURSOR pEstoque (CPros C(10) NULL, Sqtds N(10,3) NULL, sPesos N(12,3) NULL)
            SET NULL OFF

            IF RECCOUNT("crSigCdGrp") = 1
                *-- Grupo unico: busca estoque diretamente
                SELECT crSigCdGrp
                GO TOP
                loc_cEmpGE = loc_cCodEmp + crSigCdGrp.Grupos + crSigCdGrp.Estos

                loc_cSQL = "SELECT CPros, Sqtds, sPesos FROM SigMvEst " + ;
                           "WHERE EmpGruEsts = '" + loc_cEmpGE + "' AND NOT Sqtds = 0"

                IF USED("cursor_4c_EstTemp")
                    USE IN cursor_4c_EstTemp
                ENDIF

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EstTemp") < 1
                    MsgAviso("Falha na conex" + CHR(227) + "o (pEstoque)", "Aviso")
                    loc_lSucesso = loc_lSucesso
                ENDIF

                SELECT cursor_4c_EstTemp
                SCAN
                    SCATTER MEMVAR
                    INSERT INTO pEstoque FROM MEMVAR
                ENDSCAN
            ELSE
                *-- Multiplos grupos: acumula em pEstoque
                SELECT crSigCdGrp
                SCAN
                    loc_cEmpGE = loc_cCodEmp + crSigCdGrp.Grupos + crSigCdGrp.Estos

                    loc_cSQL = "SELECT CPros, Sqtds, sPesos FROM SigMvEst " + ;
                               "WHERE EmpGruEsts = '" + loc_cEmpGE + "' AND NOT Sqtds = 0"

                    IF USED("cursor_4c_TmpEst")
                        USE IN cursor_4c_TmpEst
                    ENDIF

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpEst") < 1
                        LOOP
                    ENDIF

                    SELECT cursor_4c_TmpEst
                    SCAN
                        SCATTER MEMVAR
                        INSERT INTO pEstoque FROM MEMVAR
                    ENDSCAN
                ENDSCAN
            ENDIF

            *-- Preenche listbox de grupos (Cgrus-Dgrus)
            IF TYPE("par_oListbox") = "O" .AND. !ISNULL(par_oListbox)
                par_oListbox.Clear()
                SELECT crGrupo
                GO TOP
                SCAN
                    par_oListbox.AddItem(ALLTRIM(crGrupo.Cgrus) + "-" + ALLTRIM(crGrupo.Dgrus))
                ENDSCAN
            ENDIF

            *-- Popula csRel com saldo atual de estoque por produto/unidade
            SELECT pEstoque
            GO TOP
            SCAN
                loc_cCPros_s = pEstoque.CPros

                loc_cSQL = "SELECT DPros, CUnis, CGrus, QMins, cUniPs, PesoMs " + ;
                           "FROM SigCdPro WHERE CPros = " + EscaparSQL(ALLTRIM(loc_cCPros_s))

                IF USED("crSigCdPro")
                    USE IN crSigCdPro
                ENDIF

                IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdPro") <= 0 .OR. EOF("crSigCdPro")
                    LOOP
                ENDIF

                SELECT crSigCdPro
                loc_cDPros_s  = TratarNulo(DPros,  "C")
                loc_cCUnis_s  = TratarNulo(CUnis,  "C")
                loc_cCGrus_s  = TratarNulo(CGrus,  "C")
                loc_cCUniPs_s = TratarNulo(cUniPs, "C")
                loc_nQMins_s  = TratarNulo(QMins,  "N")
                loc_nPesoMs_s = TratarNulo(PesoMs, "N")

                *-- Produto deve pertencer a um grupo valido
                IF !SEEK(crSigCdPro.CGrus, "crGrupo", "Cgrus")
                    LOOP
                ENDIF

                SELECT pEstoque
                loc_nSqtds_s  = TratarNulo(Sqtds,  "N")
                loc_nSPesos_s = TratarNulo(sPesos,  "N")

                *-- Linha unidade primaria (Seqs='1')
                SELECT csRel
                IF !SEEK(loc_cCPros_s + loc_cCUnis_s, "csRel", "Mats")
                    APPEND BLANK
                ENDIF

                REPLACE Qtds     WITH Qtds + loc_nSqtds_s, ;
                        QtdMins  WITH loc_nQMins_s, ;
                        Mats     WITH loc_cCPros_s, ;
                        Mat2s    WITH loc_cCPros_s, ;
                        Dcompos  WITH loc_cDPros_s, ;
                        Dcompo2s WITH loc_cDPros_s, ;
                        CUnis    WITH loc_cCUnis_s, ;
                        CGrus    WITH loc_cCGrus_s, ;
                        Seqs     WITH "1"

                *-- Linha unidade alternativa por peso (Seqs='2')
                IF !EMPTY(loc_cCUniPs_s) .AND. loc_nPesoMs_s <> 0
                    loc_qtMin = ROUND(loc_nQMins_s / loc_nPesoMs_s, 0)

                    SELECT csRel
                    IF !SEEK(loc_cCPros_s + loc_cCUniPs_s, "csRel", "Mats")
                        APPEND BLANK
                    ENDIF

                    REPLACE Qtds     WITH Qtds + loc_nSPesos_s, ;
                            QtdMins  WITH loc_qtMin, ;
                            Mats     WITH loc_cCPros_s, ;
                            Dcompos  WITH loc_cDPros_s, ;
                            CUnis    WITH loc_cCUniPs_s, ;
                            CGrus    WITH loc_cCGrus_s, ;
                            PesoMs   WITH loc_nPesoMs_s, ;
                            Seqs     WITH "2"
                ENDIF
            ENDSCAN

            *-- Processa 5 tipos de operacao: Empenho(1), Requisicao(2),
            *   PedidoCompra(3), Compra(4), TransferenciaCompra(5->QtdComps)
            FOR loc_nX = 1 TO 5
                DO CASE
                    CASE loc_nX = 1
                        loc_cOperBusca = THIS.this_cDopEmphs
                        loc_cCampo     = "QtdEmphs"
                    CASE loc_nX = 2
                        loc_cOperBusca = THIS.this_cDopReqcs
                        loc_cCampo     = "QtdReqs"
                    CASE loc_nX = 3
                        loc_cOperBusca = THIS.this_cDopPedcs
                        loc_cCampo     = "QtdPedcs"
                    CASE loc_nX = 4
                        loc_cOperBusca = THIS.this_cDopComps
                        loc_cCampo     = "QtdComps"
                    CASE loc_nX = 5
                        loc_cOperBusca = THIS.this_cDopTrfCps
                        loc_cCampo     = "QtdComps"
                ENDCASE

                IF EMPTY(loc_cOperBusca)
                    LOOP
                ENDIF

                loc_cEdI = loc_cCodEmp + loc_cOperBusca + STR(0,      6)
                loc_cEdF = loc_cCodEmp + loc_cOperBusca + STR(999999, 6)

                loc_cSQL = "SELECT b.EmpDopNums, b.CPros, b.Qtds, b.QtBaixas, " + ;
                           "c.Cgrus, c.QMins, c.Dpros, c.CUnis, c.cUnips, c.PesoMs " + ;
                           "FROM SigMvCab a, SigMvItn b, SigCdPro c " + ;
                           "WHERE a.EmpDopNums BETWEEN '" + loc_cEdI + "' AND '" + loc_cEdF + "' AND " + ;
                                 "a.EmpDopNums = b.EmpDopNums AND " + ;
                                 "NOT ((b.Qtds - b.QtBaixas) = 0) AND " + ;
                                 "b.CPros = c.CPros " + ;
                           "ORDER BY b.EmpDopNums, b.CPros, b.Qtds, b.QtBaixas, " + ;
                                    "c.Cgrus, c.QMins, c.Dpros, c.CUnis"

                IF USED("crOperacao")
                    USE IN crOperacao
                ENDIF

                IF SQLEXEC(gnConnHandle, loc_cSQL, "crOperacao") < 1
                    LOOP
                ENDIF

                SELECT crOperacao
                SCAN
                    IF !SEEK(crOperacao.Cgrus, "crGrupo", "Cgrus")
                        LOOP
                    ENDIF

                    loc_cCPros_o   = crOperacao.CPros
                    loc_cCUnis_o   = crOperacao.CUnis
                    loc_cCUniPs_o  = TratarNulo(crOperacao.cUnips, "C")
                    loc_cCGrus_o   = crOperacao.Cgrus
                    loc_cDPros_o   = TratarNulo(crOperacao.Dpros,  "C")
                    loc_nQMins_o   = TratarNulo(crOperacao.QMins,  "N")
                    loc_nPesoMs_o  = TratarNulo(crOperacao.PesoMs, "N")
                    loc_nQtdDiff_o = TratarNulo(crOperacao.Qtds, "N") - TratarNulo(crOperacao.QtBaixas, "N")

                    *-- Linha unidade primaria
                    SELECT csRel
                    IF !SEEK(loc_cCPros_o + loc_cCUnis_o, "csRel", "Mats")
                        APPEND BLANK
                        REPLACE QtdMins  WITH loc_nQMins_o, ;
                                Mats     WITH loc_cCPros_o, ;
                                Dcompos  WITH loc_cDPros_o, ;
                                Mat2s    WITH loc_cCPros_o, ;
                                Dcompo2s WITH loc_cDPros_o, ;
                                CUnis    WITH loc_cCUnis_o, ;
                                CGrus    WITH loc_cCGrus_o, ;
                                PesoMs   WITH loc_nPesoMs_o, ;
                                Seqs     WITH "1"
                    ENDIF

                    DO CASE
                        CASE loc_cCampo = "QtdEmphs"
                            REPLACE QtdEmphs WITH QtdEmphs + loc_nQtdDiff_o
                        CASE loc_cCampo = "QtdReqs"
                            REPLACE QtdReqs  WITH QtdReqs  + loc_nQtdDiff_o
                        CASE loc_cCampo = "QtdPedcs"
                            REPLACE QtdPedcs WITH QtdPedcs + loc_nQtdDiff_o
                        CASE loc_cCampo = "QtdComps"
                            REPLACE QtdComps WITH QtdComps + loc_nQtdDiff_o
                    ENDCASE

                    *-- Linha unidade alternativa por peso
                    IF !EMPTY(loc_cCUniPs_o) .AND. loc_nPesoMs_o <> 0
                        loc_qtMin = ROUND(loc_nQMins_o / loc_nPesoMs_o, 0)

                        SELECT csRel
                        IF !SEEK(loc_cCPros_o + loc_cCUniPs_o, "csRel", "Mats")
                            APPEND BLANK
                            REPLACE QtdMins  WITH loc_qtMin, ;
                                    Mats     WITH loc_cCPros_o, ;
                                    Dcompos  WITH loc_cDPros_o, ;
                                    CUnis    WITH loc_cCUniPs_o, ;
                                    CGrus    WITH loc_cCGrus_o, ;
                                    PesoMs   WITH loc_nPesoMs_o, ;
                                    Seqs     WITH "2"
                        ENDIF

                        DO CASE
                            CASE loc_cCampo = "QtdEmphs"
                                REPLACE QtdEmphs WITH QtdEmphs + loc_nQtdDiff_o
                            CASE loc_cCampo = "QtdReqs"
                                REPLACE QtdReqs  WITH QtdReqs  + loc_nQtdDiff_o
                            CASE loc_cCampo = "QtdPedcs"
                                REPLACE QtdPedcs WITH QtdPedcs + loc_nQtdDiff_o
                            CASE loc_cCampo = "QtdComps"
                                REPLACE QtdComps WITH QtdComps + loc_nQtdDiff_o
                        ENDCASE
                    ENDIF
                ENDSCAN
            ENDFOR

            *-- Calcula posicao final e flag de alerta (linhas Seqs='2' em peso)
            SELECT csRel
            SCAN
                IF Seqs = "2"
                    REPLACE QtdReqs  WITH ROUND(QtdReqs  / PesoMs, 0), ;
                            QtdPedcs WITH ROUND(QtdPedcs / PesoMs, 0), ;
                            QtdComps WITH ROUND(QtdComps / PesoMs, 0), ;
                            QtdEmphs WITH ROUND(QtdEmphs / PesoMs, 0), ;
                            Dcompo2s WITH PADC("*", 35)
                ENDIF
                REPLACE QtdPfins WITH (Qtds - QtdMins + QtdReqs + QtdPedcs + QtdComps - QtdEmphs)
                REPLACE Flags    WITH IIF(QtdReqs > 0 .AND. QtdPfins > 0, .T., .F.)
            ENDSCAN

            THIS.this_lProcessamento = .T.
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FiltrarPorGrupo - Aplica filtro SET KEY no cursor csRel pelo grupo
    *--------------------------------------------------------------------------
    PROCEDURE FiltrarPorGrupo(par_cGrupo)
        THIS.this_cGrupoAtual = ALLTRIM(LEFT(par_cGrupo, 3))

        IF USED("csRel")
            SELECT csRel
            SET ORDER TO TAG GruMat
            SET KEY TO THIS.this_cGrupoAtual
            GO TOP
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarCabecalhoRelatorio - Atualiza subtitulo no cursor csCab
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarCabecalhoRelatorio(par_cSubTitulo)
        THIS.this_cSubTitulo = par_cSubTitulo
        IF USED("csCab")
            SELECT csCab
            REPLACE cbsubtit WITH par_cSubTitulo
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores auxiliares criados pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_aCursores(9), loc_i
        loc_aCursores(1) = "cursor_4c_Pam"
        loc_aCursores(2) = "cursor_4c_Emp"
        loc_aCursores(3) = "crGrupo"
        loc_aCursores(4) = "crSigCdGrp"
        loc_aCursores(5) = "pEstoque"
        loc_aCursores(6) = "crOperacao"
        loc_aCursores(7) = "crSigCdPro"
        loc_aCursores(8) = "cursor_4c_EstTemp"
        loc_aCursores(9) = "cursor_4c_TmpEst"

        FOR loc_i = 1 TO 9
            IF USED(loc_aCursores(loc_i))
                USE IN (loc_aCursores(loc_i))
            ENDIF
        ENDFOR

        DODEFAULT()
    ENDPROC

ENDDEFINE

