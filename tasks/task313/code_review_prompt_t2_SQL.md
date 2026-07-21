# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NREGIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: I, CODIGOS, SELIMP
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: I, CODIGOS, SELIMP

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
	Select crSigMlItn
	.DeleteMark 	   = .f.
	.Column1.ControlSource   = 'crSigMlItn.SelImp'
	.Column2.ControlSource   = 'crSigMlItn.Codigos'
	.Column3.ControlSource   = 'crSigMlItn.Descs'
	.Column4.ControlSource   = 'crSigMlItn.Usuins'
	.Column5.ControlSource   = 'crSigMlItn.Datins'
	.Column6.ControlSource   = 'crSigMlItn.Nregis'
Select * ;
  From crSigMlCab ;
Select Codigos ;
  From crSigMlItn ;
Select csMalasSelecionadas
	lcQuery = [Select ] + lcCampo + [ From SigMlCab a Where Codigos = ?pCod Order By ] + lcCampo
	ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTmp')
	Select crTmp
		Select crTmp
		Select csMalaDuplicada
Select Padr(Upper(StrTran(a.Desti + a.Ceps + a.Endes + a.Nums + a.Compls, ' ', '')), 200) as ChaveUnica, a.* ;
  From csMalaDuplicada a ;
Select * ;
  From csMalaUnificada1 ;
Select csMalaUnificada   
Select csMalaUnificada1
	If !Seek(csMalaUnificada1.ChaveUnica,'csMalaUnificada','idxmalauni')
		Insert into csMalaUnificada From Memvar
Select csMalaUnificada
	Select csMalaUnificada
	Select crSigMlCab
Insert Into crSigMlItn (Codigos, Descs, Ativos, UsuIns, DatIns, DatAlts, Ults, DtEnts, NRegis, Espelhos, Unificas) ;
	.Update('crSigMlCab')
	.Update('crSigMlItn')
Select crSigMlCab
lcQryMalc = 'Select 0 as SelImp, * From SigMlItn'
lcQryMala = 'Select * From SigMlCab Where Codigos = ?pCod'
Select crSigMlItn
	Select crSigMlItn
Select Codigos ;
  From crSigMlItn ;
Update crSigMlItn Set SelImp = This.Value

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrMlu.prg) - TRECHOS RELEVANTES PARA PASS SQL (925 linhas total):

*-- Linhas 241 a 259:
241:             .Width              = 870
242:             .Height             = 420
243:             .RecordMark         = .F.
244:             .DeleteMark         = .F.
245:             .RowHeight          = 16
246:             .HeaderHeight       = 16
247:             .AllowHeaderSizing  = .F.
248:             .AllowRowSizing     = .F.
249:             .ReadOnly           = .F.
250:             .ScrollBars         = 2
251:             .FontName           = "Tahoma"
252:             .FontSize           = 8
253:             .GridLineColor      = RGB(238, 238, 238)
254:             .ColumnCount        = 6
255: 
256:             *-- Column1: CheckBox de selecao (SelImp)
257:             WITH .Column1
258:                 .ColumnOrder   = 1
259:                 .Width         = 20

*-- Linhas 493 a 516:
493:                 loc_oGrd.RecordSource = "cursor_4c_Itn"
494: 
495:                 WITH loc_oGrd
496:                     .Column1.ControlSource = "cursor_4c_Itn.SelImp"
497:                     .Column2.ControlSource = "cursor_4c_Itn.Codigos"
498:                     .Column3.ControlSource = "cursor_4c_Itn.Descs"
499:                     .Column4.ControlSource = "cursor_4c_Itn.Usuins"
500:                     .Column5.ControlSource = "cursor_4c_Itn.Datins"
501:                     .Column6.ControlSource = "cursor_4c_Itn.Nregis"
502:                 ENDWITH
503: 
504:                 GO TOP IN cursor_4c_Itn
505:             ENDIF
506: 
507:             IF VARTYPE(loc_oGrd) = "O"
508:                 loc_oGrd.Refresh()
509:             ENDIF
510: 
511:         CATCH TO loc_oErro
512:             MsgErro(loc_oErro.Message, "Erro MontarGrade")
513:         ENDTRY
514:     ENDPROC
515: 
516:     *==========================================================================

*-- Linhas 654 a 672:
654:                 ENDIF
655: 
656:                 *-- Verificar se ha malas com registros selecionadas
657:                 SELECT COUNT(*) AS nSel FROM cursor_4c_Itn ;
658:                     WHERE SelImp = 1 INTO CURSOR cursor_4c_TmpSel
659:                 loc_nSelecionadas = 0
660:                 IF USED("cursor_4c_TmpSel")
661:                     loc_nSelecionadas = NVL(cursor_4c_TmpSel.nSel, 0)
662:                     USE IN cursor_4c_TmpSel
663:                 ENDIF
664: 
665:                 IF loc_nSelecionadas < 1
666:                     MsgAviso("Nenhuma Mala Direta com registros foi selecionada para unifica" + ;
667:                              CHR(231) + CHR(227) + "o.", "Processar")
668:                     IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
669:                         THIS.grd_4c_Selecoes.SetFocus()
670:                     ENDIF
671:                 ELSE
672:                     IF loc_nSelecionadas = 1

*-- Linhas 771 a 805:
771:         LOCAL loc_nSel
772:         IF USED("cursor_4c_Itn")
773:             loc_nSel = IIF(cursor_4c_Itn.SelImp = 1, 0, 1)
774:             SELECT cursor_4c_Itn
775:             REPLACE SelImp WITH loc_nSel
776:         ENDIF
777:         IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
778:             THIS.grd_4c_Selecoes.Refresh()
779:         ENDIF
780:         NODEFAULT
781:     ENDPROC
782: 
783:     *-- KeyPress: toggle SelImp com Enter (13) ou Space (32)
784:     PROCEDURE GrdChkKeyPress
785:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
786:         LOCAL loc_nSel
787:         IF INLIST(par_nKeyCode, 13, 32)
788:             IF USED("cursor_4c_Itn")
789:                 loc_nSel = IIF(cursor_4c_Itn.SelImp = 1, 0, 1)
790:                 SELECT cursor_4c_Itn
791:                 REPLACE SelImp WITH loc_nSel
792:             ENDIF
793:             IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
794:                 THIS.grd_4c_Selecoes.Refresh()
795:             ENDIF
796:             NODEFAULT
797:         ENDIF
798:     ENDPROC
799: 
800:     *-- Click: absorver para nao disparar duplo-toggle com MouseDown
801:     PROCEDURE GrdChkClick()
802:         NODEFAULT
803:     ENDPROC
804: 
805:     *==========================================================================


### BO (C:\4c\projeto\app\classes\SigPrMluBO.prg):
*==============================================================================
* SigPrMluBO.prg - Business Object: Unificacao de Mala Direta
* Tabela principal: SigMlItn (lista de malas para unificacao)
* Tabela secundaria: SigMlCab (membros/destinatarios das malas)
*==============================================================================
DEFINE CLASS SigPrMluBO AS BusinessBase

    *-- Propriedades do registro SigMlItn gerado pela unificacao
    this_cCodigos        = ""   && char(10) PK - codigo gerado via SYS(2015)
    this_cDescs          = ""   && char(30) - nome da unificacao digitado pelo usuario
    this_cUsuIns         = ""   && char(10) - usuario que executou
    this_nNRegis         = 0    && numeric(8,0) - qtd de registros unificados (apos dedup)
    this_cEspelhos       = ""   && char(8)  - sempre 'SigPrMlu'
    this_cUnificas       = ""   && text     - lista de codigos unificados (sep '; ')

    *-- Controle interno do processamento
    this_nTotalMalas     = 0    && qtd de malas selecionadas (SelImp=1 AND NRegis>0)
    this_nTotalRegistros = 0    && total bruto de registros antes da deduplicacao

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        this_cTabela     = "SigMlItn"
        this_cCampoChave = "Codigos"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - retorna PK do registro atual
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - mapeia cursor_4c_Itn para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigos  = NVL(Codigos,  "")
            THIS.this_cDescs    = NVL(Descs,    "")
            THIS.this_cUsuIns   = NVL(Usuins,   "")
            THIS.this_nNRegis   = NVL(Nregis,   0)
            THIS.this_cEspelhos = NVL(Espelhos, "")
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarMalas - carrega SigMlItn em cursor_4c_Itn com SelImp=0
    * Equivale ao MontaGrades + Requery do legado
    *--------------------------------------------------------------------------
    PROCEDURE BuscarMalas()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Itn")
                TABLEREVERT(.T., "cursor_4c_Itn")
                USE IN cursor_4c_Itn
            ENDIF
            IF USED("cursor_4c_ItnTemp")
                USE IN cursor_4c_ItnTemp
            ENDIF

            loc_cSQL = "SELECT Codigos, Descs, UsuIns, DatIns, NRegis, Espelhos " + ;
                       "FROM SigMlItn ORDER BY Descs"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItnTemp") > 0
                SET NULL ON
                CREATE CURSOR cursor_4c_Itn ( ;
                    SelImp   N(1,0) NULL, ;
                    Codigos  C(10)  NULL, ;
                    Descs    C(30)  NULL, ;
                    Usuins   C(10)  NULL, ;
                    Datins   T      NULL, ;
                    Nregis   N(8,0) NULL, ;
                    Espelhos C(8)   NULL  ;
                )
                SET NULL OFF

                INDEX ON Codigos TAG Codigos
                INDEX ON Descs   TAG Descs
                INDEX ON Usuins  TAG Usuins
                INDEX ON Datins  TAG Datins

                SELECT cursor_4c_Itn
                APPEND FROM DBF("cursor_4c_ItnTemp")
                REPLACE ALL SelImp WITH 0

                USE IN cursor_4c_ItnTemp
                GO TOP IN cursor_4c_Itn
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar lista de Malas Diretas.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarUnificacao - unifica malas selecionadas (SelImp=1) em uma nova
    * par_cNomeUnificacao - nome digitado pelo usuario para a nova mala
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarUnificacao(par_cNomeUnificacao)
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cNew, loc_lcUni, loc_lnTot, loc_nMalas, loc_pCod, loc_cSQL
        LOCAL loc_lInsertOk

        loc_lSucesso = .F.
        TRY
            IF !USED("cursor_4c_Itn")
                MsgAviso("Grade de malas n" + CHR(227) + "o carregada.", "Aviso")
            ELSE
                *-- Conta malas com registros selecionadas
                loc_nMalas = 0
                SELECT COUNT(*) AS nSel FROM cursor_4c_Itn ;
                    WHERE SelImp = 1 INTO CURSOR cursor_4c_ContSel READWRITE
                IF USED("cursor_4c_ContSel")
                    SELECT cursor_4c_ContSel
                    loc_nMalas = NVL(nSel, 0)
                    USE IN cursor_4c_ContSel
                ENDIF

                IF loc_nMalas < 1
                    MsgAviso("Nenhuma Mala Direta com Registros foi Selecionada para Unifica" + ;
                             CHR(231) + CHR(227) + "o!", "Aviso")
                ELSE
                    IF loc_nMalas = 1
                    MsgAviso("Selecione ao menos duas Malas Diretas para Unificar.", "Aviso")
                ELSE
                    *-- Gera novo codigo para a mala unificada
                    loc_cNew  = SUBSTR(SYS(2015), 3, 10)
                    loc_lcUni = ""
                    loc_lnTot = 0

                    *-- Cursor acumulador de TODOS os registros das malas selecionadas
                    SET NULL ON
                    CREATE CURSOR cursor_4c_MalaDup ( ;
                        Cidchaves C(20) NULL, IClis    C(10)  NULL, Codigos  C(10)  NULL, ;
                        Bairs     C(40) NULL, Ceps     C(9)   NULL, Compls   C(25)  NULL, ;
                        Estas     C(2)  NULL, Faxs     C(20)  NULL, Grupos   C(10)  NULL, ;
                        Mes       C(2)  NULL, Nums     C(10)  NULL, Rclis    C(50)  NULL, ;
                        Tel1S     C(20) NULL, Tel2S    C(20)  NULL, Cidas    C(30)  NULL, ;
                        Endes     C(60) NULL, Nascs    T      NULL, Profiss  C(20)  NULL, ;
                        Sexos     C(1)  NULL, Ultcomps T      NULL, Aptos    N(6,0) NULL, ;
                        Opdest    N(1,0) NULL, Desti   C(50)  NULL, Opini    N(1,0) NULL, ;
                        Dtncons   T     NULL, Conjuges C(60)  NULL, Dtcasas  T      NULL, ;
                        Situas    C(3)  NULL, Dataincs T      NULL, Opani    N(1,0) NULL, ;
                        Quebras   C(40) NULL, Cpfs     C(20)  NULL, ;
                        ChaveUnica C(200) NULL ;
                    )
                    SET NULL OFF

                    *-- Acumula registros de cada mala selecionada via SQLEXEC
                    SELECT cursor_4c_Itn
                    SCAN FOR SelImp = 1
                        loc_pCod  = RTRIM(cursor_4c_Itn.Codigos)
                        loc_lcUni = loc_lcUni + loc_pCod + "; "

                        loc_cSQL = "SELECT Cidchaves, IClis, Codigos, Bairs, Ceps, Compls, " + ;
                                   "Estas, Faxs, Grupos, Mes, Nums, Rclis, Tel1S, Tel2S, " + ;
                                   "Cidas, Endes, Nascs, Profiss, Sexos, Ultcomps, Aptos, " + ;
                                   "Opdest, Desti, Opini, Dtncons, Conjuges, Dtcasas, " + ;
                                   "Situas, Dataincs, Opani, Quebras, Cpfs " + ;
                                   "FROM SigMlCab WHERE Codigos = " + EscaparSQL(loc_pCod)

                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MlaTemp") > 0
                            loc_lnTot = loc_lnTot + RECCOUNT("cursor_4c_MlaTemp")
                            SELECT cursor_4c_MalaDup
                            APPEND FROM DBF("cursor_4c_MlaTemp")
                            USE IN cursor_4c_MlaTemp
                        ENDIF
                    ENDSCAN

                    *-- Calcula ChaveUnica de deduplicacao para todos os registros
                    SELECT cursor_4c_MalaDup
                    REPLACE ALL ChaveUnica WITH ;
                        PADR(UPPER(STRTRAN( ;
                            RTRIM(NVL(Desti,  "")) + ;
                            RTRIM(NVL(Ceps,   "")) + ;
                            RTRIM(NVL(Endes,  "")) + ;
                            RTRIM(NVL(Nums,   "")) + ;
                            RTRIM(NVL(Compls, "")), " ", "")), 200)

                    *-- Cursor de destino: apenas registros unicos
                    SET NULL ON
                    CREATE CURSOR cursor_4c_MalaUni ( ;
                        Cidchaves C(20) NULL, IClis    C(10)  NULL, Codigos  C(10)  NULL, ;
                        Bairs     C(40) NULL, Ceps     C(9)   NULL, Compls   C(25)  NULL, ;
                        Estas     C(2)  NULL, Faxs     C(20)  NULL, Grupos   C(10)  NULL, ;
                        Mes       C(2)  NULL, Nums     C(10)  NULL, Rclis    C(50)  NULL, ;
                        Tel1S     C(20) NULL, Tel2S    C(20)  NULL, Cidas    C(30)  NULL, ;
                        Endes     C(60) NULL, Nascs    T      NULL, Profiss  C(20)  NULL, ;
                        Sexos     C(1)  NULL, Ultcomps T      NULL, Aptos    N(6,0) NULL, ;
                        Opdest    N(1,0) NULL, Desti   C(50)  NULL, Opini    N(1,0) NULL, ;
                        Dtncons   T     NULL, Conjuges C(60)  NULL, Dtcasas  T      NULL, ;
                        Situas    C(3)  NULL, Dataincs T      NULL, Opani    N(1,0) NULL, ;
                        Quebras   C(40) NULL, Cpfs     C(20)  NULL, ;
                        ChaveUnica C(200) NULL ;
                    )
                    SET NULL OFF

                    SELECT cursor_4c_MalaUni
                    INDEX ON ChaveUnica TAG idxmalauni

                    *-- Deduplicacao: copia apenas registros com ChaveUnica nova
                    SELECT cursor_4c_MalaDup
                    GO TOP
                    SCAN
                        IF !SEEK(cursor_4c_MalaDup.ChaveUnica, "cursor_4c_MalaUni", "idxmalauni")
                            SCATTER MEMVAR MEMO
                            SELECT cursor_4c_MalaUni
                            APPEND BLANK
                            GATHER MEMVAR MEMO
                            SELECT cursor_4c_MalaDup
                        ENDIF
                    ENDSCAN

                    *-- Insere registros deduplicados no SQL Server SigMlCab
                    loc_lInsertOk = .T.
                    SELECT cursor_4c_MalaUni
                    GO TOP
                    SCAN
                        loc_cSQL = THIS.GerarSQLInsertSigMlCab(loc_cNew)
                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                            MsgErro("Erro ao inserir registro na Mala Direta unificada.", "Erro")
                            loc_lInsertOk = .F.
                            EXIT
                        ENDIF
                    ENDSCAN

                    IF loc_lInsertOk
                        *-- Atualiza propriedades e persiste SigMlItn
                        THIS.this_cCodigos        = loc_cNew
                        THIS.this_cDescs          = LEFT(ALLTRIM(par_cNomeUnificacao), 30)
                        THIS.this_cUsuIns         = ALLTRIM(gc_4c_UsuarioLogado)
                        THIS.this_nNRegis         = RECCOUNT("cursor_4c_MalaUni")
                        THIS.this_cEspelhos       = "SigPrMlu"
                        THIS.this_cUnificas       = loc_lcUni
                        THIS.this_nTotalMalas     = loc_nMalas
                        THIS.this_nTotalRegistros = loc_lnTot

                        IF THIS.Inserir()
                            MsgInfo( ;
                                "Unifica" + CHR(231) + CHR(227) + "o '" + ;
                                ALLTRIM(par_cNomeUnificacao) + "' Conclu" + CHR(237) + "da!" + CHR(13) + ;
                                "Foram Selecionados " + ALLTRIM(STR(THIS.this_nNRegis)) + " Registros," + CHR(13) + ;
                                "Retirados de " + ALLTRIM(STR(loc_nMalas)) + " Malas Diretas," + CHR(13) + ;
                                "Que Continham Um Total de " + ALLTRIM(STR(loc_lnTot)) + " Registros.", ;
                                "Unifica" + CHR(231) + CHR(227) + "o")
                            THIS.BuscarMalas()
                            loc_lSucesso = .T.
                        ENDIF
                    ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        *-- Limpa cursores de trabalho (fora do TRY para sempre executar)
        IF USED("cursor_4c_MalaDup")
            USE IN cursor_4c_MalaDup
        ENDIF
        IF USED("cursor_4c_MalaUni")
            USE IN cursor_4c_MalaUni
        ENDIF
        IF USED("cursor_4c_MlaTemp")
            USE IN cursor_4c_MlaTemp
        ENDIF
        IF USED("cursor_4c_ContSel")
            USE IN cursor_4c_ContSel
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarSQLInsertSigMlCab - monta SQL INSERT para um registro de SigMlCab
    * Cursor_4c_MalaUni deve estar posicionado no registro a inserir
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarSQLInsertSigMlCab(par_cNovoCodigos)
        LOCAL loc_cSQL, loc_cCidChaves

        loc_cCidChaves = fUniqueIds()

        *-- Monta INSERT parte a parte para clareza
        loc_cSQL = "INSERT INTO SigMlCab " + ;
                   "(CidChaves, Codigos, IClis, Bairs, Ceps, Compls, Estas, Faxs, Grupos, " + ;
                   "Mes, Nums, Rclis, Tel1S, Tel2S, Cidas, Endes, Nascs, Profiss, " + ;
                   "Sexos, Ultcomps, Aptos, Opdest, Desti, Opini, Dtncons, Conjuges, " + ;
                   "Dtcasas, Situas, Dataincs, Opani, Quebras, Cpfs, DesDtCom, TelDtCom) " + ;
                   "VALUES (" + ;
                   EscaparSQL(loc_cCidChaves) + ", " + ;
                   EscaparSQL(par_cNovoCodigos) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.IClis,    ""))) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Bairs,    ""))) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Ceps,     ""))) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Compls,   ""))) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Estas,    ""))) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Faxs,     ""))) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Grupos,   ""))) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Mes,      ""))) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Nums,     ""))) + ", " + ;
                   EscaparSQL(LEFT(RTRIM(NVL(cursor_4c_MalaUni.Rclis,"")),50)) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Tel1S,    ""))) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Tel2S,    ""))) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Cidas,    ""))) + ", " + ;
                   EscaparSQL(LEFT(RTRIM(NVL(cursor_4c_MalaUni.Endes,"")),60)) + ", " + ;
                   FormatarDataSQL(cursor_4c_MalaUni.Nascs) + ", " + ;
                   EscaparSQL(LEFT(RTRIM(NVL(cursor_4c_MalaUni.Profiss,"")),20)) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Sexos,    ""))) + ", " + ;
                   FormatarDataSQL(cursor_4c_MalaUni.Ultcomps) + ", " + ;
                   FormatarNumeroSQL(NVL(cursor_4c_MalaUni.Aptos,  0), 0) + ", " + ;
                   FormatarNumeroSQL(NVL(cursor_4c_MalaUni.Opdest, 0), 0) + ", " + ;
                   EscaparSQL(LEFT(RTRIM(NVL(cursor_4c_MalaUni.Desti,  "")),50)) + ", " + ;
                   FormatarNumeroSQL(NVL(cursor_4c_MalaUni.Opini,  0), 0) + ", " + ;
                   FormatarDataSQL(cursor_4c_MalaUni.Dtncons) + ", " + ;
                   EscaparSQL(LEFT(RTRIM(NVL(cursor_4c_MalaUni.Conjuges,"")),60)) + ", " + ;
                   FormatarDataSQL(cursor_4c_MalaUni.Dtcasas) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Situas,  ""))) + ", " + ;
                   FormatarDataSQL(cursor_4c_MalaUni.Dataincs) + ", " + ;
                   FormatarNumeroSQL(NVL(cursor_4c_MalaUni.Opani,  0), 0) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Quebras, ""))) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Cpfs,    ""))) + ", " + ;
                   "'', '')"

        RETURN loc_cSQL
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT novo registro SigMlItn no SQL Server
    * SigMlItn tem ~80 colunas NOT NULL; filtros de selecao recebem valores
    * neutros (' '/0/0) pois este registro e produto da unificacao, nao filtro.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        LOCAL loc_cCols1, loc_cCols2, loc_cCols3, loc_cCols4
        LOCAL loc_cVals1, loc_cVals2, loc_cVals3, loc_cVals4
        LOCAL loc_cCidChaves

        loc_lSucesso = .F.
        TRY
            loc_cCidChaves = fUniqueIds()

            *-- Bloco 1: colunas com valores reais do processo de unificacao
            loc_cCols1 = "Codigos, Descs, Ativos, UsuIns, UsuAlts, DatIns, NRegis, " + ;
                         "Espelhos, Unificas, CidChaves"
            loc_cVals1 = EscaparSQL(THIS.this_cCodigos) + ", " + ;
                         EscaparSQL(LEFT(THIS.this_cDescs, 30)) + ", 1, " + ;
                         EscaparSQL(LEFT(THIS.this_cUsuIns, 10)) + ", " + ;
                         "'', GETDATE(), " + ;
                         FormatarNumeroSQL(THIS.this_nNRegis, 0) + ", " + ;
                         "'SigPrMlu', " + ;
                         EscaparSQL(THIS.this_cUnificas) + ", " + ;
                         EscaparSQL(loc_cCidChaves)

            *-- Bloco 2: colunas char NOT NULL de criterios de filtro (vazias)
            loc_cCols2 = ", DEmps, Cadas, Cemps, CepFs, CepIs, Cidades, Ests, FaixaFs, FaixaIs, " + ;
                         "Nomes, Profs, RSocs, AnivFs, AnivIs, LinHas, TabUfs, BairS, Estados, " + ;
                         "Vends, CParents, Paises, Dopes, Conjuge, Situa, ClassiFis, ClassiFSs, " + ;
                         "RegIFs, RegIIs"
            loc_cVals2 = ", '', '', '', '', '', '', '', '', '', " + ;
                         "'', '', '', '', '', '', '', '', '', " + ;
                         "'', '', '', '', '', '', '', '', " + ;
                         "'', ''"

            *-- Bloco 3: colunas numericas NOT NULL de criterios de filtro (zero)
            loc_cCols3 = ", DestIs, OPSexS, OptCepS, OptNrS, OptUltS, Situas, OPSitua, OPAnis, " + ;
                         "OPCivis, OpenDes, OptLmk, OPIdade, EnDigual, ValosF, ValosI, IdadeFs, IdadeIs"
            loc_cVals3 = ", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0"

            *-- Bloco 4: colunas bit NOT NULL de criterios de filtro (zero)
            loc_cCols4 = ", CkAnis, CkCads, CkCepS, CkCidS, CkEmpS, CkEsts, CkFNoms, CkNomes, CkProfs, " + ;
                         "CkRSocs, CkSexS, CkUlts, CkClas, CkSituas, CkRegis, CkSitua, CkCivils, " + ;
                         "CkDtEnts, CkLinhas, CkBairs, CkVends, CkIdade, CkDtAtus, CkTlMk, CkNComp, " + ;
                         "CkUltCom, CkPais, CkMov, CkConjuge"
            loc_cVals4 = ", 0, 0, 0, 0, 0, 0, 0, 0, 0, " + ;
                         "0, 0, 0, 0, 0, 0, 0, 0, " + ;
                         "0, 0, 0, 0, 0, 0, 0, 0, " + ;
                         "0, 0, 0, 0"

            loc_cSQL = "INSERT INTO SigMlItn (" + ;
                       loc_cCols1 + loc_cCols2 + loc_cCols3 + loc_cCols4 + ") " + ;
                       "VALUES (" + loc_cVals1 + loc_cVals2 + loc_cVals3 + loc_cVals4 + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                MsgErro("Erro ao gravar Unifica" + CHR(231) + CHR(227) + "o no banco de dados.", "Erro")
            ELSE
                THIS.RegistrarAuditoria("I")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE do registro SigMlItn no SQL Server
    * A tela original nao faz edicao apos unificar (mala unificada e imutavel),
    * mas o metodo existe para permitir manutencao (renomear, atualizar contadores)
    * via propriedades do BO.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cCodigos)
                MsgAviso("C" + CHR(243) + "digo da Unifica" + CHR(231) + CHR(227) + ;
                         "o n" + CHR(227) + "o informado.", "Aviso")
            ELSE
                loc_cSQL = "UPDATE SigMlItn SET " + ;
                           "Descs = "     + EscaparSQL(LEFT(THIS.this_cDescs, 30)) + ", " + ;
                           "UsuAlts = "   + EscaparSQL(LEFT(THIS.this_cUsuIns, 10)) + ", " + ;
                           "NRegis = "    + FormatarNumeroSQL(THIS.this_nNRegis, 0) + ", " + ;
                           "Espelhos = "  + EscaparSQL(LEFT(THIS.this_cEspelhos, 8)) + ", " + ;
                           "Unificas = "  + EscaparSQL(THIS.this_cUnificas) + " " + ;
                           "WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)

                IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                    MsgErro("Erro ao atualizar Unifica" + CHR(231) + CHR(227) + ;
                            "o no banco de dados.", "Erro")
                ELSE
                    THIS.RegistrarAuditoria("A")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - registra operacao em LogAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_oErro
        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Usuario, DataHora, Tabela, Operacao, ChaveRegistro, Descricao) " + ;
                       "VALUES (" + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", GETDATE(), " + ;
                       "'SigMlItn', " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(THIS.this_cCodigos) + ", " + ;
                       EscaparSQL("Unifica" + CHR(231) + CHR(227) + "o: " + THIS.this_cDescs) + ")"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            *-- Auditoria nao deve bloquear operacao principal
        ENDTRY
    ENDPROC

ENDDEFINE

