# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [GRID-SQL] Campo 'dopers' usado em ControlSource de cursor_4c_Operacoes mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'confops' usado em ControlSource de cursor_4c_Operacoes mas NAO aparece no SELECT SQL

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
  ControlSource = "crSigCdGpe.prods"
  ControlSource = "crSigCdGpe.desutils"
  ControlSource = "crSigCdGpe.iniagenda"
  ControlSource = "crSigCdGpe.numopers"
  ControlSource = "crSigCdGpe.ncontroles"
  ControlSource = "crSigCdGpe.fontnums"
  ControlSource = "crSigCdGpe.limdia"
  ControlSource = "crSigCdGpe.qualquer"
  ControlSource = "crSigCdGpe.Audits"
  ControlSource = "crSigCdGpe.consulta"
  ControlSource = "crSigCdGpe.montagem"
  ControlSource = "crSigCdGpe.chkMercs"
  ControlSource = "crSigCdGpe.opUtiliza"
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  ControlSource = "crSigCdGpo.Dopers"
  ControlSource = "crSigCdGpo.confops"
  ControlSource = "crSigCdGpe.SubNiveis"
  ControlSource = "crSigCdGpe.FilPagas"
  ControlSource = "crSigCdGpe.FilBaixas"
  ControlSource = "crSigCdGpe.Utilizas"
  ControlSource = "crSigCdGpe.ChkReserva"
  ControlSource = "crSigCdGpe.anacps"
  ControlSource = "crSigCdGpe.SubnCrs"
  ControlSource = "crSigCdGpe.Alterar"
  ControlSource = "crSigCdGpe.BlqAdts"
  ControlSource = "crSigCdGpe.InibOcors"
  ControlSource = "crSigCdGpe.inibFecs"
  ControlSource = "crSigCdGpe.opAgends"
  ControlSource = "crSigCdGpe.TpBloqueio"
  ControlSource = "crSigCdGpe.opPagas"
  ControlSource = "crSigCdGpe.opPends"
  ControlSource = "crSigCdGpe.Empresas"
  ControlSource = "crSigCdGpe.Periodos"
  ControlSource = "crSigCdGpe.Operacoes"
  ControlSource = "crSigCdGpe.Entregas"
  ControlSource = "crSigCdGpe.GeraCrs"
  ControlSource = "crSigCdGpe.FixaPs"
  ControlSource = "crSigCdGpe.FixaGs"
  ControlSource = "crSigCdGpe.FixaAs"
  ControlSource = "crSigCdGpe.Locals"
  ControlSource = "crSigCdGpe.CodSegs"
  ControlSource = "crSigCdGpe.FixaLs"
  ControlSource = "crSigCdGpe.Contas"
  ControlSource = "crSigCdGpe.Resps"
  ControlSource = "crSigCdGpe.DtAtuals"
  ControlSource = "crSigCdGpe.cArqIcones"
  ControlSource = "crSigCdGpe.FixaSs"
  ControlSource = "crSigCdGpe.Senresps"
  ControlSource = "crSigCdGpe.Volumes"
  ControlSource = "crSigCdGpe.chdtentrs"
  ControlSource = "crSigCdGpe.Ordemas"
  ControlSource = "crSigCdGpe.Ordemns"
  ControlSource = "crSigCdGpe.Ordems"
  ControlSource = "crSigCdGpe.Vends"
  ControlSource = "crSigCdGpe.sacs"
  ControlSource = "crSigCdGpe.ctAcusus"
  ControlSource = "crSigCdGpe.acmemps"
  ControlSource = "crSigCdGpe.MultiImps"
  ControlSource = "crSigCdGpe.estdisps"
  ControlSource = "crSigCdGpe.dgopes"
  ControlSource = "crSigCdGpe.ngopes"
		ThisForm.pagina.dados.pgfDados.pgConfig.gradeo.Column1.ControlSource="crSigCdGpo.Dopers"
		ThisForm.pagina.dados.pgfDados.pgConfig.gradeo.Column2.ControlSource="crSigCdGpo.confops"
		m.lnErro1 = Iif(.poDataMgr.UpDate('crSigCdGpe'),1,-1)
		m.lnErro1 = Iif(.poDataMgr.UpDate('crSigCdGpo'),1,-1)
		m.lnErro1 = Iif(.poDataMgr.UpDate('crSigCdPrg'),1,-1)
		m.lnErro1 = Iif(.poDataMgr.UpDate('crSigCdGpe'),1,-1)
		m.lnErro1 = Iif(.poDataMgr.UpDate('crSigCdGpo'),1,-1)
		m.lnErro1 = Iif(.poDataMgr.UpDate('crSigCdPrg'),1,-1)
		m.lnErro1 = Iif(.poDataMgr.UpDate('crSigCdGpe'),1,-1)
		m.lnErro1 = Iif(.poDataMgr.UpDate('crSigCdGpo'),1,-1)
		m.lnErro1 = Iif(.poDataMgr.UpDate('crSigCdPrg'),1,-1)
SELECT crSigCdGpe
		Select ('crSigSyIco1')
				Delete File (m.lcArqIcone1)
select crSigCdGpe
		SELECT crSigCdGpo
		SELECT crSigCdGpo
	ThisForm.podatamgr.SqlExecute([Select * From SigCdGpo Where Dgopes = ?crSigCdGpe.Dgopes],'crSigCdGpo')
	ThisForm.pagina.dados.pgfDados.pgConfig.gradeo.Column1.ControlSource="crSigCdGpo.Dopers"
	ThisForm.pagina.dados.pgfDados.pgConfig.gradeo.Column2.ControlSource="crSigCdGpo.confops"
		SELECT crSigCdGpo
	Select ('crTmpIcone')
Select crSigCdGpe
Select crSigCdGpe
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves, BarraForms, BarraPict ) ;
		lcUpdate = [Update SigCdPrg Set BarraForms = ']+m.lcBarraForm+[',BarraPict=']+crSigCdGpe.cArqIcones+[' Where Programas=']+_Prog+[' ]+;
		ThisForm.PodataMgr.SqlExecute(lcUpdate,'')
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg (Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
	Select crSigCdGpo
			delete
		Select crSigCdGpo
	Select crSigCdGpo
		Select crSigCdGpo
		Select crSigCdGpo
			Select crSigCdGpo
		Select crSigCdGpo
	SELECT crSigCdGpo
	DELETE all
	Select crSigCdGpe
Select crSigCdGpe
	Select CrSigCdGpe
Select CrSigCdGpe
	select crSigCdGpo
	Select crSigCdGpo
lcQuery = [Select Codigos, Descricaos ] + ;
		    [From SigPrLcl ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crListaRemota') < 1)
Select crListaRemota
	If Not Seek(This.Value, 'crListaRemota', 'Codigos')
		m.lcMcrSql1 = ([select a.carqicones,a.marqicones,']+Space(128)+[' as ctmpicones from SigSyIco a order by 1])
			m.lnErro1 = .poDatamgr.SQLExecute(m.lcMcrSql1,'crSigSyIco1')
			Select ('crSigSyIco1')
				Insert Into crSigSyIco1 (carqicones) Values (' < Nenhum >')
	Insert Into crProg2 (descricaos,barrapict) Values (crSigCdGpe.DgOpes,ThisForm.Pagina.Dados.pgfDados.pgCompls.getArqIcone.Value)
	If (Seek(ThisForm.Pagina.Dados.pgfDados.pgCompls.getArqIcone.Value,'crSigSyIco1','carqicones') And;
Select crSigCdGpo

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormGpe.prg) - TRECHOS RELEVANTES PARA PASS SQL (4242 linhas total):

*-- Linhas 373 a 391:
373:             .HighlightBackColor = RGB(255, 255, 255)
374:             .HighlightForeColor = RGB(15, 41, 104)
375:             .HighlightStyle     = 2
376:             .DeleteMark         = .F.
377:             .RecordMark         = .F.
378:             .RowHeight          = 16
379:             .ScrollBars         = 2
380:             .GridLines          = 3
381:             .ReadOnly           = .T.
382:             .Visible            = .T.
383: 
384:             .Column1.Width           = 750
385:             .Column1.Resizable       = .T.
386:             .Column1.Header1.Caption = "Grupo Operacional"
387: 
388:             .Column2.Width           = 100
389:             .Column2.Resizable       = .T.
390:             .Column2.Alignment       = 1
391:             .Column2.Header1.Caption = "N" + CHR(186)

*-- Linhas 1465 a 1483:
1465:             .Height       = 171
1466:             .Left         = 424
1467:             .RecordMark   = .F.
1468:             .DeleteMark   = .F.
1469:             .RowHeight    = 17
1470:             .Top          = 121
1471:             .Width        = 301
1472:             .ReadOnly     = .F.
1473:             .ScrollBars   = 2
1474:             .Visible      = .T.
1475: 
1476:             .Column1.Width    = 140
1477:             .Column1.Movable  = .F.
1478:             .Column1.Resizable = .F.
1479:             .Column1.FontName = "Courier New"
1480:             .Column1.FontSize = 8
1481: 
1482:             .Column2.Width    = 140
1483:             .Column2.Movable  = .F.

*-- Linhas 3120 a 3139:
3120:                 IF VARTYPE(loc_oGrid) = "O" AND THIS.this_oBusinessObject.Buscar("")
3121:                     loc_oGrid.ColumnCount = 2
3122:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
3123:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.dgopes"
3124:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.ngopes"
3125: 
3126:                     *-- Reconfigurar headers APOS RecordSource (VFP9 reseta headers)
3127:                     loc_oGrid.Column1.Header1.Caption = "Grupo Operacional"
3128:                     loc_oGrid.Column2.Header1.Caption = "N" + CHR(186)
3129:                     loc_oGrid.Column2.Alignment       = 1
3130: 
3131:                     THIS.FormatarGridLista(loc_oGrid)
3132:                     loc_lResultado = .T.
3133:                 ENDIF
3134:             ENDIF
3135:         CATCH TO loc_oErro
3136:             MsgErro(loc_oErro.Message + CHR(13) + ;
3137:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro CarregarLista")
3138:             loc_lResultado = .F.
3139:         ENDTRY

*-- Linhas 3354 a 3379:
3354:                 loc_oPgC.img_4c_Icone.Visible = .T.
3355:             ELSE
3356:                 loc_oPgC.img_4c_Icone.Visible = .F.
3357:             ENDIF
3358: 
3359:             *-- Grid de Operacoes: carregar cursor_4c_Operacoes
3360:             IF loc_oBO.BuscarOperacoes(ALLTRIM(loc_oBO.this_cDgopes))
3361:                 loc_oPg1.grd_4c_GradeOpe.ColumnCount = 2
3362:                 loc_oPg1.grd_4c_GradeOpe.RecordSource          = "cursor_4c_Operacoes"
3363:                 loc_oPg1.grd_4c_GradeOpe.Column1.ControlSource = "cursor_4c_Operacoes.dopers"
3364:                 loc_oPg1.grd_4c_GradeOpe.Column2.ControlSource = "cursor_4c_Operacoes.confops"
3365:                 loc_oPg1.grd_4c_GradeOpe.Column1.Header1.Caption = ;
3366:                     "Opera" + CHR(231) + CHR(245) + "es Poss" + CHR(237) + "veis"
3367:                 loc_oPg1.grd_4c_GradeOpe.Column2.Header1.Caption = ;
3368:                     "Opera" + CHR(231) + CHR(227) + "o Confer" + CHR(234) + "ncia"
3369:                 loc_oPg1.grd_4c_GradeOpe.Refresh()
3370:             ENDIF
3371: 
3372:             loc_lResultado = .T.
3373: 
3374:         CATCH TO loc_oErro
3375:             MsgErro(loc_oErro.Message + CHR(13) + ;
3376:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3377:                 "Procedure: " + loc_oErro.Procedure, "Erro BOParaForm")
3378:         ENDTRY
3379: 

*-- Linhas 3503 a 3530:
3503:             loc_oPg1.opt_4c_Filbaixas.Value = 1
3504:             loc_oPg1.opt_4c_Audits.Value    = 1
3505:             loc_oPg1.txt_4c_Limdia.Value    = 0
3506: 
3507:             *-- pgConfig: Grid → cursor vazio editavel
3508:             IF USED("cursor_4c_Operacoes")
3509:                 USE IN cursor_4c_Operacoes
3510:             ENDIF
3511:             CREATE CURSOR cursor_4c_Operacoes (dopers C(20), confops C(20), cidchaves C(20))
3512:             loc_oPg1.grd_4c_GradeOpe.ColumnCount = 2
3513:             loc_oPg1.grd_4c_GradeOpe.RecordSource          = "cursor_4c_Operacoes"
3514:             loc_oPg1.grd_4c_GradeOpe.Column1.ControlSource = "cursor_4c_Operacoes.dopers"
3515:             loc_oPg1.grd_4c_GradeOpe.Column2.ControlSource = "cursor_4c_Operacoes.confops"
3516:             loc_oPg1.grd_4c_GradeOpe.Column1.Header1.Caption = ;
3517:                 "Opera" + CHR(231) + CHR(245) + "es Poss" + CHR(237) + "veis"
3518:             loc_oPg1.grd_4c_GradeOpe.Column2.Header1.Caption = ;
3519:                 "Opera" + CHR(231) + CHR(227) + "o Confer" + CHR(234) + "ncia"
3520:             loc_oPg1.grd_4c_GradeOpe.Refresh()
3521: 
3522:             *-- pgCompls: OptionGroups → todos Value=1
3523:             loc_oPgC.opt_4c_Dtatuals.Value   = 1
3524:             loc_oPgC.opt_4c_Blqadts.Value    = 1
3525:             loc_oPgC.opt_4c_Inibocors.Value  = 1
3526:             loc_oPgC.opt_4c_Inibfecs.Value   = 1
3527:             loc_oPgC.opt_4c_Alterar.Value    = 1
3528:             loc_oPgC.opt_4c_Periodos.Value   = 1
3529:             loc_oPgC.opt_4c_Entregas.Value   = 1
3530:             loc_oPgC.opt_4c_Operacoes.Value  = 1

*-- Linhas 3703 a 3721:
3703:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
3704:                 loc_cDgopes = ALLTRIM(cursor_4c_Busca.dgopes)
3705:                 IF USED("cursor_4c_Dados")
3706:                     SELECT cursor_4c_Dados
3707:                     LOCATE FOR ALLTRIM(dgopes) = loc_cDgopes
3708:                 ENDIF
3709:             ENDIF
3710: 
3711:             loc_oBusca.Release()
3712:         ENDIF
3713: 
3714:         IF USED("cursor_4c_Busca")
3715:             USE IN cursor_4c_Busca
3716:         ENDIF
3717:     ENDPROC
3718: 
3719:     *--------------------------------------------------------------------------
3720:     * BtnConfirmarClick - Salva o registro atual (Inserir ou Atualizar)
3721:     *--------------------------------------------------------------------------

*-- Linhas 3731 a 3751:
3731: 
3732:         THIS.FormParaBO()
3733: 
3734:         IF THIS.this_oBusinessObject.Salvar()
3735:             THIS.this_oBusinessObject.SalvarOperacoes(;
3736:                 THIS.this_oBusinessObject.this_cDgopes, "cursor_4c_Operacoes")
3737:             MsgInfo("Registro salvo com sucesso!", "")
3738:             THIS.this_cModoAtual = "LISTA"
3739:             THIS.CarregarLista()
3740:             THIS.AlternarPagina(1)
3741:         ENDIF
3742:     ENDPROC
3743: 
3744:     *--------------------------------------------------------------------------
3745:     * BtnCancelarClick - Cancela edicao e volta para lista
3746:     *--------------------------------------------------------------------------
3747:     PROCEDURE BtnCancelarClick()
3748:         THIS.this_cModoAtual = "LISTA"
3749:         THIS.AlternarPagina(1)
3750:     ENDPROC
3751: 

*-- Linhas 3763 a 3803:
3763: 
3764:         loc_cDgopes = ALLTRIM(cursor_4c_Dados.dgopes)
3765: 
3766:         TRY
3767:             IF THIS.this_oBusinessObject.BuscarOperacoes(loc_cDgopes)
3768:                 loc_nCount = RECCOUNT("cursor_4c_Operacoes")
3769:                 IF loc_nCount = 0
3770:                     MsgInfo("O grupo [" + loc_cDgopes + ;
3771:                         "] n" + CHR(227) + "o possui opera" + CHR(231) + CHR(245) + ;
3772:                         "es cadastradas.", ;
3773:                         "Listagem de Opera" + CHR(231) + CHR(245) + "es")
3774:                 ELSE
3775:                     loc_cTexto = "LISTAGEM DE OPERA" + CHR(199) + CHR(213) + "ES" + CHR(13) + CHR(10) + ;
3776:                         "Grupo Operacional: " + loc_cDgopes + CHR(13) + CHR(10) + ;
3777:                         "Total: " + TRANSFORM(loc_nCount) + " registro(s)" + CHR(13) + CHR(10) + ;
3778:                         REPLICATE("=", 60) + CHR(13) + CHR(10) + ;
3779:                         PADR("Opera" + CHR(231) + CHR(227) + "o Poss" + CHR(237) + "vel", 22) + ;
3780:                         PADR("Opera" + CHR(231) + CHR(227) + "o Confer" + CHR(234) + "ncia", 22) + ;
3781:                         CHR(13) + CHR(10) + REPLICATE("-", 60) + CHR(13) + CHR(10)
3782: 
3783:                     SELECT cursor_4c_Operacoes
3784:                     GO TOP
3785:                     SCAN
3786:                         loc_cTexto = loc_cTexto + ;
3787:                             PADR(ALLTRIM(cursor_4c_Operacoes.dopers),  22) + ;
3788:                             PADR(ALLTRIM(cursor_4c_Operacoes.confops), 22) + ;
3789:                             CHR(13) + CHR(10)
3790:                     ENDSCAN
3791: 
3792:                     loc_cArqTmp = ADDBS(SYS(2023)) + "ListaOps_" + loc_cDgopes + "_" + ;
3793:                         SYS(2015) + ".txt"
3794:                     STRTOFILE(loc_cTexto, loc_cArqTmp)
3795: 
3796:                     IF FILE(loc_cArqTmp)
3797:                         RUN /N NOTEPAD.EXE "&loc_cArqTmp"
3798:                     ELSE
3799:                         MsgErro("Falha ao gerar arquivo de listagem.", "Erro")
3800:                     ENDIF
3801:                 ENDIF
3802:             ENDIF
3803:         CATCH TO loc_oErro

*-- Linhas 3840 a 3889:
3840:             ENDIF
3841: 
3842:             IF loc_lProsseguir
3843:                 SELECT cursor_4c_XMLImp
3844:                 GO TOP
3845: 
3846:                 IF TYPE("cursor_4c_XMLImp.dgopes") = "U"
3847:                     MsgErro("XML n" + CHR(227) + "o possui a coluna 'dgopes'.", "Erro")
3848:                     loc_lProsseguir = .F.
3849:                 ENDIF
3850:             ENDIF
3851: 
3852:             IF loc_lProsseguir
3853:                 loc_cDgopes = ALLTRIM(cursor_4c_XMLImp.dgopes)
3854:                 IF EMPTY(loc_cDgopes)
3855:                     MsgErro("Grupo operacional vazio no XML.", "Erro")
3856:                     loc_lProsseguir = .F.
3857:                 ENDIF
3858:             ENDIF
3859: 
3860:             IF loc_lProsseguir
3861:                 *-- Verificar se ja existe
3862:                 loc_cSQL = "SELECT dgopes FROM SigCdGpe WHERE dgopes = " + ;
3863:                     EscaparSQL(loc_cDgopes)
3864:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_XMLChk")
3865:                 loc_lJaExiste  = (loc_nResultado >= 0 AND USED("cursor_4c_XMLChk") AND ;
3866:                                   RECCOUNT("cursor_4c_XMLChk") > 0)
3867: 
3868:                 IF loc_lJaExiste
3869:                     IF MsgConfirma("Grupo [" + loc_cDgopes + ;
3870:                             "] j" + CHR(225) + " existe. Substituir?", ;
3871:                             "Confirma" + CHR(231) + CHR(227) + "o")
3872:                         loc_cSQL = "DELETE FROM SigCdGpe WHERE dgopes = " + ;
3873:                             EscaparSQL(loc_cDgopes)
3874:                         SQLEXEC(gnConnHandle, loc_cSQL)
3875:                     ELSE
3876:                         loc_lProsseguir = .F.
3877:                     ENDIF
3878:                 ENDIF
3879: 
3880:                 IF USED("cursor_4c_XMLChk")
3881:                     USE IN cursor_4c_XMLChk
3882:                 ENDIF
3883:             ENDIF
3884: 
3885:             IF loc_lProsseguir
3886:                 *-- Inserir usando o BO (via CarregarDoCursor + Salvar)
3887:                 IF THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_XMLImp")
3888:                     THIS.this_oBusinessObject.NovoRegistro()
3889:                     THIS.this_oBusinessObject.this_cDgopes = loc_cDgopes

*-- Linhas 3931 a 3951:
3931: 
3932:         TRY
3933:             loc_lProsseguir = .T.
3934:             loc_cSQL        = "SELECT * FROM SigCdGpe WHERE dgopes = " + ;
3935:                 EscaparSQL(loc_cDgopes)
3936:             loc_nResultado  = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_XMLExp")
3937: 
3938:             IF loc_nResultado < 0 OR !USED("cursor_4c_XMLExp") OR ;
3939:                     RECCOUNT("cursor_4c_XMLExp") = 0
3940:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar o grupo:" + ;
3941:                     CHR(13) + CapturarErroSQL(), "Erro")
3942:                 loc_lProsseguir = .F.
3943:             ENDIF
3944: 
3945:             IF loc_lProsseguir
3946:                 loc_cXML = ""
3947:                 CURSORTOXML("cursor_4c_XMLExp", "loc_cXML", 1, 512, 0, "1")
3948: 
3949:                 IF EMPTY(loc_cXML)
3950:                     MsgErro("Falha ao gerar XML.", "Erro")
3951:                     loc_lProsseguir = .F.

*-- Linhas 4044 a 4065:
4044: 
4045:         IF USED("cursor_4c_Dados")
4046:             USE IN cursor_4c_Dados
4047:         ENDIF
4048: 
4049:         IF USED("cursor_4c_Operacoes")
4050:             USE IN cursor_4c_Operacoes
4051:         ENDIF
4052: 
4053:         IF USED("cursor_4c_Busca")
4054:             USE IN cursor_4c_Busca
4055:         ENDIF
4056: 
4057:         IF USED("cursor_4c_BuscaSub")
4058:             USE IN cursor_4c_BuscaSub
4059:         ENDIF
4060: 
4061:         IF USED("cursor_4c_BuscaLcl")
4062:             USE IN cursor_4c_BuscaLcl
4063:         ENDIF
4064: 
4065:         IF USED("cursor_4c_BuscaSct")


### BO (C:\4c\projeto\app\classes\GpeBO.prg):
* GpeBO.prg - Business Object para Cadastro de Grupos Operacionais
* Tabela principal: SigCdGpe | PK: dgopes
* Tabela filha: SigCdGpo (grid operacoes: dopers + confops)

DEFINE CLASS GpeBO AS BusinessBase

    *-- SigCdGpe: Identificacao
    this_cDgopes            = ""   && dgopes char(20) - PK Grupo Operacional
    this_nNgopes            = 0    && ngopes numeric(6,0) - Nro interno (fGerUniqueKey)

    *-- SigCdGpe: Numeracao e Controle
    this_nNumopers          = 0    && numopers numeric(1,0) - Numeracao da Operacao
    this_nNcontroles        = 0    && ncontroles numeric(1,0) - Tipo do Nro de Controle
    this_nFontnums          = 0    && fontnums numeric(1,0) - Fonte da Numeracao
    this_nLimdia            = 0    && limdia numeric(6,0) - Limite diario

    *-- SigCdGpe: Auditoria e Acesso
    this_nAudits            = 0    && audits numeric(1,0) - Auditoria (9 opcoes)
    this_nBlqadts           = 0    && blqadts numeric(1,0) - Bloqueia Alt. Data
    this_nInibfecs          = 0    && inibfecs numeric(1,0) - Inibir Botao Fechamento
    this_nInibocors         = 0    && inibocors numeric(1,0) - Inibir Botao Ocorrencia
    this_nAlterar           = 0    && alterar numeric(1,0) - Permitir Alteracao
    this_nConsulta          = 0    && consulta numeric(1,0) - Apenas Consulta
    this_nCtacusus          = 0    && ctacusus numeric(1,0) - Controlar Acesso por Usuario
    this_nSenresps          = 0    && senresps numeric(1,0) - Senha por Responsavel
    this_nAcmemps           = 0    && acmemps numeric(1,0) - Checar Acesso Muda Empresa
    this_nAnacps            = 0    && anacps numeric(1,0) - Analisar C.Pagto Fx.Cx

    *-- SigCdGpe: Situacoes (tristate)
    this_nSubniveis         = 0    && subniveis numeric(1,0) - Situacao dos Subniveis
    this_nUtilizas          = 0    && utilizas numeric(1,0) - Situacao das Operacoes
    this_nFilpagas          = 0    && filpagas numeric(1,0) - Filtro Operacoes Pagas
    this_nFilbaixas         = 0    && filbaixas numeric(1,0) - Filtro Operacoes Baixadas
    this_nOputiliza         = 0    && oputiliza numeric(1,0) - Operacoes Utilizadas
    this_nMontagem          = 0    && montagem numeric(1,0) - Produtos Com Montagem
    this_nQualquer          = 0    && qualquer numeric(1,0) - Ignorar Grupo Operacional
    this_nChkmercs          = 0    && chkmercs numeric(1,0) - Checar Mercadorias
    this_nProds             = 0    && prods numeric(1,0) - Ordem de Producao
    this_nDesutils          = 0    && desutils numeric(1,0) - Desagendar Utilizados
    this_nIniagenda         = 0    && iniagenda numeric(1,0) - Exibir botao F8 - AGENDA

    *-- SigCdGpe: Operacoes em filtro (ordem grade)
    this_nOpagends          = 0    && opagends numeric(1,0) - Operacoes Agendadas (filtro lista)
    this_nOppagas           = 0    && oppagas numeric(1,0) - Operacoes Pagas (filtro lista)
    this_nOppends           = 0    && oppends numeric(1,0) - Operacoes Todas/Agend./Nao-Agend.
    this_nOrdemas           = 0    && ordemas numeric(1,0) - Ordem das Agendadas (combobox)
    this_nOrdemns           = 0    && ordemns numeric(1,0) - Ordem das Nao-Agendadas (combobox)
    this_nOrdems            = 0    && ordems numeric(1,0) - Ordem de Todas (combobox)

    *-- SigCdGpe: Fixar ordenacao
    this_nFixaps            = 0    && fixaps numeric(1,0) - Fixa Pagas (checkbox)
    this_nFixaas            = 0    && fixaas numeric(1,0) - Fixa Agendadas (checkbox)
    this_nFixals            = 0    && fixals numeric(1,0) - Fixa Livres (checkbox Check1)
    this_nFixags            = 0    && fixags numeric(1,0) - Fixa Geral (checkbox)
    this_nFixass            = 0    && fixass numeric(1,0) - Fixa Sessao (checkbox Check2)

    *-- SigCdGpe: Utilizar recursos
    this_nResps             = 0    && resps numeric(1,0) - Utiliza Responsavel
    this_nContas            = 0    && contas numeric(1,0) - Utiliza Conta
    this_nEmpresas          = 0    && empresas numeric(1,0) - Utiliza Empresa
    this_nVends             = 0    && vends numeric(1,0) - Senha por Responsavel (Vendas)
    this_nSacs              = 0    && sacs numeric(1,0) - Checar SAC
    this_nVolumes           = 0    && volumes numeric(1,0) - Quantidade de Volumes
    this_nPeriodos          = 0    && periodos numeric(1,0) - Utiliza Periodo Configuracao
    this_nEntregas          = 0    && entregas numeric(1,0) - Utiliza Periodo Entrega
    this_nOperacoes         = 0    && operacoes numeric(1,0) - Utiliza Periodo Operacao
    this_nEstdisps          = 0    && estdisps numeric(1,0) - Estoque Disponivel
    this_nDtatuals          = 0    && dtatuals numeric(1,0) - Utilizar Data Atual
    this_nGeracrs           = 0    && geracrs numeric(1,0) - Gera Controle de Subniveis
    this_nChkreserva        = 0    && chkreserva numeric(1,0) - Credito/Bonus (optReserva)
    this_nMultiimps         = 0    && multiimps numeric(1,0) - Imprime Documentos
    this_nRoadshows         = 0    && roadshows numeric(1,0)
    this_nTpbloqueio        = 0    && tpbloqueio numeric(1,0) - Tipo de Bloqueio
    this_nChdtentrs         = 0    && chdtentrs numeric(1,0) - Checar Data de Entrega

    *-- SigCdGpe: Campos texto
    this_cSubncrs           = ""   && subncrs char(20) - Subnivel (lookup SigCdOpe)
    this_cLocals            = ""   && locals char(10) - Localizacao Padrao
    this_cCodsegs           = ""   && codsegs char(10) - Segmento Padrao (lookup SigCdSct)
    this_cCarqicones        = ""   && carqicones char(64) - Arquivo de icone
    this_cDopes             = ""   && dopes char(20) - Operacao Padrao (lookup SigCdOpe)
    this_cTproads           = ""   && tproads char(15)

    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdGpe"
        THIS.this_cCampoChave = "dgopes"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cDgopes
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Lista SigCdGpe em cursor_4c_Dados
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT dgopes, ngopes FROM SigCdGpe"
            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY dgopes"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado > 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar grupos operacionais:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega SigCdGpe pelo codigo do grupo
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cDgopes)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT dgopes, ngopes, numopers, ncontroles, fontnums, limdia," + ;
                " audits, blqadts, inibfecs, inibocors, alterar, consulta, ctacusus," + ;
                " senresps, acmemps, anacps, subniveis, utilizas, filpagas, filbaixas," + ;
                " oputiliza, montagem, qualquer, chkmercs, prods, desutils, iniagenda," + ;
                " opagends, oppagas, oppends, ordemas, ordemns, ordems," + ;
                " fixaps, fixaas, fixals, fixags, fixass," + ;
                " resps, contas, empresas, vends, sacs, volumes, periodos, entregas," + ;
                " operacoes, estdisps, dtatuals, geracrs, chkreserva, multiimps," + ;
                " roadshows, tpbloqueio, chdtentrs," + ;
                " subncrs, locals, codsegs, carqicones, dopes, tproads" + ;
                " FROM SigCdGpe WHERE dgopes = " + EscaparSQL(par_cDgopes)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar grupo operacional:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor para propriedades do BO
    * OBRIGATORIO: SELECT (par_cAliasCursor) antes de acessar campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cDgopes       = TratarNulo(dgopes, "C")
            THIS.this_nNgopes       = TratarNulo(ngopes, "N")
            THIS.this_nNumopers     = TratarNulo(numopers, "N")
            THIS.this_nNcontroles   = TratarNulo(ncontroles, "N")
            THIS.this_nFontnums     = TratarNulo(fontnums, "N")
            THIS.this_nLimdia       = TratarNulo(limdia, "N")
            THIS.this_nAudits       = TratarNulo(audits, "N")
            THIS.this_nBlqadts      = TratarNulo(blqadts, "N")
            THIS.this_nInibfecs     = TratarNulo(inibfecs, "N")
            THIS.this_nInibocors    = TratarNulo(inibocors, "N")
            THIS.this_nAlterar      = TratarNulo(alterar, "N")
            THIS.this_nConsulta     = TratarNulo(consulta, "N")
            THIS.this_nCtacusus     = TratarNulo(ctacusus, "N")
            THIS.this_nSenresps     = TratarNulo(senresps, "N")
            THIS.this_nAcmemps      = TratarNulo(acmemps, "N")
            THIS.this_nAnacps       = TratarNulo(anacps, "N")
            THIS.this_nSubniveis    = TratarNulo(subniveis, "N")
            THIS.this_nUtilizas     = TratarNulo(utilizas, "N")
            THIS.this_nFilpagas     = TratarNulo(filpagas, "N")
            THIS.this_nFilbaixas    = TratarNulo(filbaixas, "N")
            THIS.this_nOputiliza    = TratarNulo(oputiliza, "N")
            THIS.this_nMontagem     = TratarNulo(montagem, "N")
            THIS.this_nQualquer     = TratarNulo(qualquer, "N")
            THIS.this_nChkmercs     = TratarNulo(chkmercs, "N")
            THIS.this_nProds        = TratarNulo(prods, "N")
            THIS.this_nDesutils     = TratarNulo(desutils, "N")
            THIS.this_nIniagenda    = TratarNulo(iniagenda, "N")
            THIS.this_nOpagends     = TratarNulo(opagends, "N")
            THIS.this_nOppagas      = TratarNulo(oppagas, "N")
            THIS.this_nOppends      = TratarNulo(oppends, "N")
            THIS.this_nOrdemas      = TratarNulo(ordemas, "N")
            THIS.this_nOrdemns      = TratarNulo(ordemns, "N")
            THIS.this_nOrdems       = TratarNulo(ordems, "N")
            THIS.this_nFixaps       = TratarNulo(fixaps, "N")
            THIS.this_nFixaas       = TratarNulo(fixaas, "N")
            THIS.this_nFixals       = TratarNulo(fixals, "N")
            THIS.this_nFixags       = TratarNulo(fixags, "N")
            THIS.this_nFixass       = TratarNulo(fixass, "N")
            THIS.this_nResps        = TratarNulo(resps, "N")
            THIS.this_nContas       = TratarNulo(contas, "N")
            THIS.this_nEmpresas     = TratarNulo(empresas, "N")
            THIS.this_nVends        = TratarNulo(vends, "N")
            THIS.this_nSacs         = TratarNulo(sacs, "N")
            THIS.this_nVolumes      = TratarNulo(volumes, "N")
            THIS.this_nPeriodos     = TratarNulo(periodos, "N")
            THIS.this_nEntregas     = TratarNulo(entregas, "N")
            THIS.this_nOperacoes    = TratarNulo(operacoes, "N")
            THIS.this_nEstdisps     = TratarNulo(estdisps, "N")
            THIS.this_nDtatuals     = TratarNulo(dtatuals, "N")
            THIS.this_nGeracrs      = TratarNulo(geracrs, "N")
            THIS.this_nChkreserva   = TratarNulo(chkreserva, "N")
            THIS.this_nMultiimps    = TratarNulo(multiimps, "N")
            THIS.this_nRoadshows    = TratarNulo(roadshows, "N")
            THIS.this_nTpbloqueio   = TratarNulo(tpbloqueio, "N")
            THIS.this_nChdtentrs    = TratarNulo(chdtentrs, "N")
            THIS.this_cSubncrs      = TratarNulo(subncrs, "C")
            THIS.this_cLocals       = TratarNulo(locals, "C")
            THIS.this_cCodsegs      = TratarNulo(codsegs, "C")
            THIS.this_cCarqicones   = TratarNulo(carqicones, "C")
            THIS.this_cDopes        = TratarNulo(dopes, "C")
            THIS.this_cTproads      = TratarNulo(tproads, "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdGpe
    * ngopes gerado via fGerUniqueKey("SigCdGpe")
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_nNgopes = fGerUniqueKey("SigCdGpe")

            loc_cSQL = "INSERT INTO SigCdGpe (" + ;
                "dgopes, ngopes, numopers, ncontroles, fontnums, limdia," + ;
                " audits, blqadts, inibfecs, inibocors, alterar, consulta, ctacusus," + ;
                " senresps, acmemps, anacps, subniveis, utilizas, filpagas, filbaixas," + ;
                " oputiliza, montagem, qualquer, chkmercs, prods, desutils, iniagenda," + ;
                " opagends, oppagas, oppends, ordemas, ordemns, ordems," + ;
                " fixaps, fixaas, fixals, fixags, fixass," + ;
                " resps, contas, empresas, vends, sacs, volumes, periodos, entregas," + ;
                " operacoes, estdisps, dtatuals, geracrs, chkreserva, multiimps," + ;
                " roadshows, tpbloqueio, chdtentrs," + ;
                " subncrs, locals, codsegs, carqicones, dopes, tproads" + ;
                ") VALUES (" + ;
                EscaparSQL(THIS.this_cDgopes) + "," + ;
                FormatarNumeroSQL(THIS.this_nNgopes) + "," + ;
                FormatarNumeroSQL(THIS.this_nNumopers) + "," + ;
                FormatarNumeroSQL(THIS.this_nNcontroles) + "," + ;
                FormatarNumeroSQL(THIS.this_nFontnums) + "," + ;
                FormatarNumeroSQL(THIS.this_nLimdia) + "," + ;
                FormatarNumeroSQL(THIS.this_nAudits) + "," + ;
                FormatarNumeroSQL(THIS.this_nBlqadts) + "," + ;
                FormatarNumeroSQL(THIS.this_nInibfecs) + "," + ;
                FormatarNumeroSQL(THIS.this_nInibocors) + "," + ;
                FormatarNumeroSQL(THIS.this_nAlterar) + "," + ;
                FormatarNumeroSQL(THIS.this_nConsulta) + "," + ;
                FormatarNumeroSQL(THIS.this_nCtacusus) + "," + ;
                FormatarNumeroSQL(THIS.this_nSenresps) + "," + ;
                FormatarNumeroSQL(THIS.this_nAcmemps) + "," + ;
                FormatarNumeroSQL(THIS.this_nAnacps) + "," + ;
                FormatarNumeroSQL(THIS.this_nSubniveis) + "," + ;
                FormatarNumeroSQL(THIS.this_nUtilizas) + "," + ;
                FormatarNumeroSQL(THIS.this_nFilpagas) + "," + ;
                FormatarNumeroSQL(THIS.this_nFilbaixas) + "," + ;
                FormatarNumeroSQL(THIS.this_nOputiliza) + "," + ;
                FormatarNumeroSQL(THIS.this_nMontagem) + "," + ;
                FormatarNumeroSQL(THIS.this_nQualquer) + "," + ;
                FormatarNumeroSQL(THIS.this_nChkmercs) + "," + ;
                FormatarNumeroSQL(THIS.this_nProds) + "," + ;
                FormatarNumeroSQL(THIS.this_nDesutils) + "," + ;
                FormatarNumeroSQL(THIS.this_nIniagenda) + "," + ;
                FormatarNumeroSQL(THIS.this_nOpagends) + "," + ;
                FormatarNumeroSQL(THIS.this_nOppagas) + "," + ;
                FormatarNumeroSQL(THIS.this_nOppends) + "," + ;
                FormatarNumeroSQL(THIS.this_nOrdemas) + "," + ;
                FormatarNumeroSQL(THIS.this_nOrdemns) + "," + ;
                FormatarNumeroSQL(THIS.this_nOrdems) + "," + ;
                FormatarNumeroSQL(THIS.this_nFixaps) + "," + ;
                FormatarNumeroSQL(THIS.this_nFixaas) + "," + ;
                FormatarNumeroSQL(THIS.this_nFixals) + "," + ;
                FormatarNumeroSQL(THIS.this_nFixags) + "," + ;
                FormatarNumeroSQL(THIS.this_nFixass) + "," + ;
                FormatarNumeroSQL(THIS.this_nResps) + "," + ;
                FormatarNumeroSQL(THIS.this_nContas) + "," + ;
                FormatarNumeroSQL(THIS.this_nEmpresas) + "," + ;
                FormatarNumeroSQL(THIS.this_nVends) + "," + ;
                FormatarNumeroSQL(THIS.this_nSacs) + "," + ;
                FormatarNumeroSQL(THIS.this_nVolumes) + "," + ;
                FormatarNumeroSQL(THIS.this_nPeriodos) + "," + ;
                FormatarNumeroSQL(THIS.this_nEntregas) + "," + ;
                FormatarNumeroSQL(THIS.this_nOperacoes) + "," + ;
                FormatarNumeroSQL(THIS.this_nEstdisps) + "," + ;
                FormatarNumeroSQL(THIS.this_nDtatuals) + "," + ;
                FormatarNumeroSQL(THIS.this_nGeracrs) + "," + ;
                FormatarNumeroSQL(THIS.this_nChkreserva) + "," + ;
                FormatarNumeroSQL(THIS.this_nMultiimps) + "," + ;
                FormatarNumeroSQL(THIS.this_nRoadshows) + "," + ;
                FormatarNumeroSQL(THIS.this_nTpbloqueio) + "," + ;
                FormatarNumeroSQL(THIS.this_nChdtentrs) + "," + ;
                EscaparSQL(THIS.this_cSubncrs) + "," + ;
                EscaparSQL(THIS.this_cLocals) + "," + ;
                EscaparSQL(THIS.this_cCodsegs) + "," + ;
                EscaparSQL(THIS.this_cCarqicones) + "," + ;
                EscaparSQL(THIS.this_cDopes) + "," + ;
                EscaparSQL(THIS.this_cTproads) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir grupo operacional:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigCdGpe (nao atualiza dgopes/ngopes - sao PK/chave)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdGpe SET" + ;
                " numopers = " + FormatarNumeroSQL(THIS.this_nNumopers) + ;
                ", ncontroles = " + FormatarNumeroSQL(THIS.this_nNcontroles) + ;
                ", fontnums = " + FormatarNumeroSQL(THIS.this_nFontnums) + ;
                ", limdia = " + FormatarNumeroSQL(THIS.this_nLimdia) + ;
                ", audits = " + FormatarNumeroSQL(THIS.this_nAudits) + ;
                ", blqadts = " + FormatarNumeroSQL(THIS.this_nBlqadts) + ;
                ", inibfecs = " + FormatarNumeroSQL(THIS.this_nInibfecs) + ;
                ", inibocors = " + FormatarNumeroSQL(THIS.this_nInibocors) + ;
                ", alterar = " + FormatarNumeroSQL(THIS.this_nAlterar) + ;
                ", consulta = " + FormatarNumeroSQL(THIS.this_nConsulta) + ;
                ", ctacusus = " + FormatarNumeroSQL(THIS.this_nCtacusus) + ;
                ", senresps = " + FormatarNumeroSQL(THIS.this_nSenresps) + ;
                ", acmemps = " + FormatarNumeroSQL(THIS.this_nAcmemps) + ;
                ", anacps = " + FormatarNumeroSQL(THIS.this_nAnacps) + ;
                ", subniveis = " + FormatarNumeroSQL(THIS.this_nSubniveis) + ;
                ", utilizas = " + FormatarNumeroSQL(THIS.this_nUtilizas) + ;
                ", filpagas = " + FormatarNumeroSQL(THIS.this_nFilpagas) + ;
                ", filbaixas = " + FormatarNumeroSQL(THIS.this_nFilbaixas) + ;
                ", oputiliza = " + FormatarNumeroSQL(THIS.this_nOputiliza) + ;
                ", montagem = " + FormatarNumeroSQL(THIS.this_nMontagem) + ;
                ", qualquer = " + FormatarNumeroSQL(THIS.this_nQualquer) + ;
                ", chkmercs = " + FormatarNumeroSQL(THIS.this_nChkmercs) + ;
                ", prods = " + FormatarNumeroSQL(THIS.this_nProds) + ;
                ", desutils = " + FormatarNumeroSQL(THIS.this_nDesutils) + ;
                ", iniagenda = " + FormatarNumeroSQL(THIS.this_nIniagenda) + ;
                ", opagends = " + FormatarNumeroSQL(THIS.this_nOpagends) + ;
                ", oppagas = " + FormatarNumeroSQL(THIS.this_nOppagas) + ;
                ", oppends = " + FormatarNumeroSQL(THIS.this_nOppends) + ;
                ", ordemas = " + FormatarNumeroSQL(THIS.this_nOrdemas) + ;
                ", ordemns = " + FormatarNumeroSQL(THIS.this_nOrdemns) + ;
                ", ordems = " + FormatarNumeroSQL(THIS.this_nOrdems) + ;
                ", fixaps = " + FormatarNumeroSQL(THIS.this_nFixaps) + ;
                ", fixaas = " + FormatarNumeroSQL(THIS.this_nFixaas) + ;
                ", fixals = " + FormatarNumeroSQL(THIS.this_nFixals) + ;
                ", fixags = " + FormatarNumeroSQL(THIS.this_nFixags) + ;
                ", fixass = " + FormatarNumeroSQL(THIS.this_nFixass) + ;
                ", resps = " + FormatarNumeroSQL(THIS.this_nResps) + ;
                ", contas = " + FormatarNumeroSQL(THIS.this_nContas) + ;
                ", empresas = " + FormatarNumeroSQL(THIS.this_nEmpresas) + ;
                ", vends = " + FormatarNumeroSQL(THIS.this_nVends) + ;
                ", sacs = " + FormatarNumeroSQL(THIS.this_nSacs) + ;
                ", volumes = " + FormatarNumeroSQL(THIS.this_nVolumes) + ;
                ", periodos = " + FormatarNumeroSQL(THIS.this_nPeriodos) + ;
                ", entregas = " + FormatarNumeroSQL(THIS.this_nEntregas) + ;
                ", operacoes = " + FormatarNumeroSQL(THIS.this_nOperacoes) + ;
                ", estdisps = " + FormatarNumeroSQL(THIS.this_nEstdisps) + ;
                ", dtatuals = " + FormatarNumeroSQL(THIS.this_nDtatuals) + ;
                ", geracrs = " + FormatarNumeroSQL(THIS.this_nGeracrs) + ;
                ", chkreserva = " + FormatarNumeroSQL(THIS.this_nChkreserva) + ;
                ", multiimps = " + FormatarNumeroSQL(THIS.this_nMultiimps) + ;
                ", roadshows = " + FormatarNumeroSQL(THIS.this_nRoadshows) + ;
                ", tpbloqueio = " + FormatarNumeroSQL(THIS.this_nTpbloqueio) + ;
                ", chdtentrs = " + FormatarNumeroSQL(THIS.this_nChdtentrs) + ;
                ", subncrs = " + EscaparSQL(THIS.this_cSubncrs) + ;
                ", locals = " + EscaparSQL(THIS.this_cLocals) + ;
                ", codsegs = " + EscaparSQL(THIS.this_cCodsegs) + ;
                ", carqicones = " + EscaparSQL(THIS.this_cCarqicones) + ;
                ", dopes = " + EscaparSQL(THIS.this_cDopes) + ;
                ", tproads = " + EscaparSQL(THIS.this_cTproads) + ;
                " WHERE dgopes = " + EscaparSQL(THIS.this_cDgopes)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar grupo operacional:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de SigCdGpe e registros filhos SigCdGpo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- Excluir operacoes filhas em SigCdGpo
            loc_cSQL = "DELETE FROM SigCdGpo WHERE dgopes = " + ;
                EscaparSQL(THIS.this_cDgopes)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao excluir opera" + CHR(231) + CHR(245) + "es do grupo:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Excluir registro principal
                loc_cSQL = "DELETE FROM SigCdGpe WHERE dgopes = " + ;
                    EscaparSQL(THIS.this_cDgopes)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir grupo operacional:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarOperacoes - Carrega SigCdGpo (grid de operacoes) em cursor_4c_Operacoes
    * SigCdGpo: dgopes(FK), dopers(op. possivel), confops(op. conferencia), cidchaves(PK)
    *--------------------------------------------------------------------------
    FUNCTION BuscarOperacoes(par_cDgopes)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT dopers, confops, cidchaves FROM SigCdGpo" + ;
                " WHERE dgopes = " + EscaparSQL(par_cDgopes) + ;
                " ORDER BY cidchaves"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Operacoes")
                TABLEREVERT(.T., "cursor_4c_Operacoes")
                USE IN cursor_4c_Operacoes
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacoes")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarOperacoes - Persiste grid de operacoes (SigCdGpo) do grupo
    * par_cDgopes: codigo do grupo
    * par_cCursorOps: nome do cursor com linhas editadas (campos: dopers, confops)
    * Estrategia: DELETE todas + INSERT das linhas nao vazias
    *--------------------------------------------------------------------------
    FUNCTION SalvarOperacoes(par_cDgopes, par_cCursorOps)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado, loc_nLinha, loc_cChave
        LOCAL loc_cDopers, loc_cConfops
        loc_lResultado = .F.

        TRY
            *-- Excluir todas as operacoes do grupo
            loc_cSQL = "DELETE FROM SigCdGpo WHERE dgopes = " + EscaparSQL(par_cDgopes)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao limpar opera" + CHR(231) + CHR(245) + "es:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lResultado = .T.
                IF USED(par_cCursorOps) AND RECCOUNT(par_cCursorOps) > 0
                    SELECT (par_cCursorOps)
                    GO TOP
                    loc_nLinha = 0
                    DO WHILE !EOF() AND loc_lResultado
                        loc_cDopers  = ALLTRIM(dopers)
                        loc_cConfops = ALLTRIM(confops)
                        IF !EMPTY(loc_cDopers)
                            loc_nLinha = loc_nLinha + 1
                            loc_cChave = LEFT(ALLTRIM(par_cDgopes) + ;
                                STR(loc_nLinha, 6), 20)
                            loc_cSQL = "INSERT INTO SigCdGpo" + ;
                                " (dgopes, dopers, confops, cidchaves) VALUES (" + ;
                                EscaparSQL(par_cDgopes) + "," + ;
                                EscaparSQL(loc_cDopers) + "," + ;
                                EscaparSQL(loc_cConfops) + "," + ;
                                EscaparSQL(loc_cChave) + ")"
                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                            IF loc_nResultado < 0
                                MsgErro("Erro ao inserir opera" + CHR(231) + CHR(227) + ;
                                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                                loc_lResultado = .F.
                            ENDIF
                        ENDIF
                        SKIP
                    ENDDO
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE

