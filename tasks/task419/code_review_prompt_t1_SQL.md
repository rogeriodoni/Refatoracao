# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: IMPS, ORDEMS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'TRNFIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: IMPS, ORDEMS

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
  ControlSource = "crSigFiNtb.Opernf"
  ControlSource = "crSigFiNtb.descrs"
  ControlSource = "crSigFiNtb.nfixos"
  ControlSource = "crSigFiNtb.ordems"
  ControlSource = "crSigFiNtb.Opernf2"
  ControlSource = "crSigFiNtb.imps"
	Select crSigCdOpe
select CrSigFiNtb
Select CrSigFiNtb
		Select CrSigFiNtb
	lcSql = [Select * From SigFiNtb Where Imps=']+lcImp+[' And Ordems = ]+Str(lnOrd,2)+[ ] +;
	If ThisForm.PodataMgr.SqlExecute(lcSql,'CrTrib') > 0 And (Reccount('CrTrib') > 0)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormFNF.prg) - TRECHOS RELEVANTES PARA PASS SQL (1145 linhas total):

*-- Linhas 352 a 370:
352:             .HighlightBackColor = RGB(255, 255, 255)
353:             .HighlightForeColor = RGB(15, 41, 104)
354:             .HighlightStyle     = 2
355:             .DeleteMark         = .F.
356:             .RecordMark         = .F.
357:             .RowHeight          = 16
358:             .ScrollBars         = 2
359:             .GridLines          = 3
360:             .ReadOnly           = .T.
361:             .Visible            = .T.
362:         ENDWITH
363: 
364:         *-- Column1: imps (Impressora, 160px)
365:         WITH loc_oGrid.Column1
366:             .Width           = 160
367:             .ReadOnly        = .T.
368:             .Header1.Caption = "Impressora"
369:         ENDWITH
370: 

*-- Linhas 702 a 727:
702:             IF THIS.this_oBusinessObject.Buscar("")
703:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
704: 
705:                 *-- RecordSource FORA de WITH; ControlSource APOS RecordSource (Prob #36/#48)
706:                 loc_oGrid.ColumnCount = 4
707:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
708: 
709:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.imps"
710:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.ordems"
711:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.descrs"
712:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.nfixos"
713: 
714:                 *-- Redefinir Headers APOS RecordSource (resets ao auto-bind)
715:                 loc_oGrid.Column1.Header1.Caption = "Impressora"
716:                 loc_oGrid.Column2.Header1.Caption = "Ordem"
717:                 loc_oGrid.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
718:                 loc_oGrid.Column4.Header1.Caption = "Fixo"
719: 
720:                 THIS.FormatarGridLista(loc_oGrid)
721:                 loc_lResultado = .T.
722:             ENDIF
723:         CATCH TO loException
724:             MsgErro("Erro ao carregar lista:" + CHR(13) + loException.Message, "Erro")
725:             loc_lResultado = .F.
726:         ENDTRY
727: 

*-- Linhas 810 a 828:
810:         loc_cCidchaves = ""
811: 
812:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
813:             SELECT cursor_4c_Dados
814:             loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)
815:         ENDIF
816: 
817:         IF EMPTY(loc_cCidchaves)
818:             MsgAviso("Selecione um registro na lista.", "Aten" + CHR(231) + CHR(227) + "o")
819:             RETURN
820:         ENDIF
821: 
822:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
823:             THIS.this_cModoAtual = "VISUALIZAR"
824:             THIS.BOParaForm()
825:             THIS.HabilitarCampos(.F.)
826:             THIS.AjustarBotoesPorModo()
827:             THIS.AlternarPagina(2)
828:         ELSE

*-- Linhas 839 a 857:
839:         loc_cCidchaves = ""
840: 
841:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
842:             SELECT cursor_4c_Dados
843:             loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)
844:         ENDIF
845: 
846:         IF EMPTY(loc_cCidchaves)
847:             MsgAviso("Selecione um registro na lista.", "Aten" + CHR(231) + CHR(227) + "o")
848:             RETURN
849:         ENDIF
850: 
851:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
852:             THIS.this_oBusinessObject.EditarRegistro()
853:             THIS.this_cModoAtual = "ALTERAR"
854:             THIS.BOParaForm()
855:             THIS.HabilitarCampos(.T.)
856:             THIS.AjustarBotoesPorModo()
857:             THIS.AlternarPagina(2)

*-- Linhas 871 a 889:
871:         loc_lConfirma  = .F.
872: 
873:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
874:             SELECT cursor_4c_Dados
875:             loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)
876:         ENDIF
877: 
878:         IF EMPTY(loc_cCidchaves)
879:             MsgAviso("Selecione um registro na lista.", "Aten" + CHR(231) + CHR(227) + "o")
880:             RETURN
881:         ENDIF
882: 
883:         loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro selecionado?", ;
884:                                     "Confirmar Exclus" + CHR(227) + "o")
885:         IF !loc_lConfirma
886:             RETURN
887:         ENDIF
888: 
889:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)


### BO (C:\4c\projeto\app\classes\FNFBO.prg):
*==============================================================================
* FNFBO.prg - Business Object para Finalizadoras n" + CHR(227) + "o Fiscal
* Tabela: SIGFINTB
* PK: cidchaves (char 20 - gerado via NEWID SQL Server)
*==============================================================================
DEFINE CLASS FNFBO AS BusinessBase

    *-- Propriedades herdadas (sobrescrever em Init)
    this_cTabela      = "SIGFINTB"
    this_cCampoChave  = "cidchaves"

    *-- Campos de SIGFINTB
    this_cCidChaves   = ""   && char(20) PK
    this_cImps        = ""   && char(20) Impressora
    this_nOrdems      = 0    && numeric(2,0) Ordem
    this_cOpernf      = ""   && char(2) Cod.Opera" + CHR(231) + CHR(227) + "o NF
    this_cOpernf2     = ""   && char(2) Cod.Abertura (s" + CHR(243) + " SWEDA/NSWEDA)
    this_cDescrs      = ""   && char(50) Descri" + CHR(231) + CHR(227) + "o
    this_nNfixos      = 0    && numeric(1,0) Fixo: 1=Sim 0=N" + CHR(227) + "o

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SIGFINTB"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria (BusinessBase)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Lista finalizadoras n" + CHR(227) + "o fiscais
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.imps, a.ordems, a.descrs, a.nfixos, a.cidchaves" + ;
                       " FROM SIGFINTB a" + ;
                       " ORDER BY a.imps, a.ordems"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar finalizadoras:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar finalizadoras:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega finalizadora pela PK cidchaves
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCidchaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.cidchaves, a.imps, a.ordems, a.opernf, a.opernf2," + ;
                       " a.descrs, a.nfixos" + ;
                       " FROM SIGFINTB a" + ;
                       " WHERE a.cidchaves = " + EscaparSQL(par_cCidchaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar finalizadora:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            THIS.this_cImps      = TratarNulo(imps,      "C")
            THIS.this_nOrdems    = TratarNulo(ordems,    "N")
            THIS.this_cOpernf    = TratarNulo(opernf,    "C")
            THIS.this_cOpernf2   = TratarNulo(opernf2,   "C")
            THIS.this_cDescrs    = TratarNulo(descrs,    "C")
            THIS.this_nNfixos    = TratarNulo(nfixos,    "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarUnicidade - Verifica se Impressora+Ordem j" + CHR(225) + " existe
    * Retorna .T. se combinacao esta disponivel (sem duplicata)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarUnicidade()
        LOCAL loc_cSQL, loc_nResultado, loc_lDisponivel
        loc_lDisponivel = .T.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS cnt FROM SIGFINTB" + ;
                       " WHERE imps = " + EscaparSQL(THIS.this_cImps) + ;
                       " AND ordems = " + FormatarNumeroSQL(THIS.this_nOrdems) + ;
                       " AND cidchaves <> " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Unic")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Unic") > 0
                SELECT cursor_4c_Unic
                IF cursor_4c_Unic.cnt > 0
                    MsgAviso("Impressora / Ordem j" + CHR(225) + " cadastrada!", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lDisponivel = .F.
                ENDIF
            ENDIF

            IF USED("cursor_4c_Unic")
                USE IN cursor_4c_Unic
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar duplicidade:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Unic")
                USE IN cursor_4c_Unic
            ENDIF
            loc_lDisponivel = .F.
        ENDTRY

        RETURN loc_lDisponivel
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SIGFINTB
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        *-- Validar duplicidade Impressora+Ordem ANTES do TRY
        IF !THIS.ValidarUnicidade()
            RETURN .F.
        ENDIF

        TRY
            *-- Gerar chave unica via NEWID do SQL Server
            THIS.this_cCidChaves = ""
            loc_nResultado = SQLEXEC(gnConnHandle, "SELECT LEFT(NEWID(), 20) AS novo_uuid", "cursor_4c_Uuid")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Uuid") > 0
                SELECT cursor_4c_Uuid
                THIS.this_cCidChaves = ALLTRIM(cursor_4c_Uuid.novo_uuid)
            ENDIF
            IF USED("cursor_4c_Uuid")
                USE IN cursor_4c_Uuid
            ENDIF

            IF EMPTY(THIS.this_cCidChaves)
                MsgErro("Erro ao gerar chave " + CHR(250) + "nica.", "Erro")
                loc_lSucesso = .F.
            ELSE
                loc_cSQL = "INSERT INTO SIGFINTB" + ;
                           " (cidchaves, imps, ordems, opernf, opernf2, descrs, nfixos)" + ;
                           " VALUES (" + ;
                           EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                           EscaparSQL(THIS.this_cImps) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nOrdems) + ", " + ;
                           EscaparSQL(THIS.this_cOpernf) + ", " + ;
                           EscaparSQL(THIS.this_cOpernf2) + ", " + ;
                           EscaparSQL(THIS.this_cDescrs) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nNfixos) + ;
                           ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inserir finalizadora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir finalizadora:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SIGFINTB
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        *-- Validar duplicidade Impressora+Ordem (excluindo registro atual) ANTES do TRY
        IF !THIS.ValidarUnicidade()
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "UPDATE SIGFINTB SET" + ;
                       " imps = " + EscaparSQL(THIS.this_cImps) + ", " + ;
                       " ordems = " + FormatarNumeroSQL(THIS.this_nOrdems) + ", " + ;
                       " opernf = " + EscaparSQL(THIS.this_cOpernf) + ", " + ;
                       " opernf2 = " + EscaparSQL(THIS.this_cOpernf2) + ", " + ;
                       " descrs = " + EscaparSQL(THIS.this_cDescrs) + ", " + ;
                       " nfixos = " + FormatarNumeroSQL(THIS.this_nNfixos) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar finalizadora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar finalizadora:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE da finalizadora
    * Valida se Ordems esta sendo usada em SigCdOpe.trnfis
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_lEmUso
        loc_lSucesso = .F.
        loc_lEmUso   = .F.

        TRY
            *-- Validar uso: SigCdOpe.trnfis referencia esta ordem?
            loc_cSQL = "SELECT COUNT(*) AS cnt FROM SigCdOpe" + ;
                       " WHERE trnfis = " + FormatarNumeroSQL(THIS.this_nOrdems)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeUso")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_OpeUso") > 0
                SELECT cursor_4c_OpeUso
                IF cursor_4c_OpeUso.cnt > 0
                    MsgAviso("C" + CHR(243) + "digo de Opera" + CHR(231) + CHR(227) + "o sendo utilizada, Imposs" + CHR(237) + "vel Exclus" + CHR(227) + "o!!", ;
                            "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lEmUso = .T.
                ENDIF
            ENDIF
            IF USED("cursor_4c_OpeUso")
                USE IN cursor_4c_OpeUso
            ENDIF

            IF !loc_lEmUso
                *-- Executar exclusao
                loc_cSQL = "DELETE FROM SIGFINTB" + ;
                           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao excluir finalizadora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir finalizadora:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_OpeUso")
                USE IN cursor_4c_OpeUso
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

