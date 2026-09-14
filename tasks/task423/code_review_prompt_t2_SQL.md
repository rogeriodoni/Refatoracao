# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: FPAGS

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
Select CrSigOpFpB
lcSql = [Select * From SigOpFpB Where Fpags = ']+crTSigfPag.Fpags+[' Order by CodBins ]
If ThisForm.ParentForm.PodataMgr.Sqlexecute(lcSql,'xFpagI') < 1
Select xFpagI
	Insert Into CrSigOpFpB From array Memvar
Select xFpagI
	.Column1.ControlSource = 'xFPagi.CodBins'
	.Column2.ControlSource = 'xFPagi.Descs'
	.Column3.ControlSource = 'xFPagi.DataIs'
	.Column4.ControlSource = 'xFPagi.DataFs'
Insert Into xFPagI (fPags) Values ( crTSigfPag.fpags )
Select xFPagi
Select xFPagi
	Delete
	Select CodBins,Sum(1) From xFPagi group by CodBins having sum(1) > 1;
	Select TT
	Select crSigOpFpB
	Delete all
	Select xFPagi
			Insert Into crSigOpFpB From array memvar
			SELECT crSigOpFpB
			SELECT xFPagi
	Retorno=TSigfpg.podatamgr.Update("crSigOpFpB")

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormFpb.prg) - TRECHOS RELEVANTES PARA PASS SQL (1126 linhas total):

*-- Linhas 369 a 398:
369:                 .ForeColor = RGB(90, 90, 90)
370:             ENDWITH
371: 
372:             *-- Grid de BINs (RecordSource e ControlSource sao setados em CarregarDados)
373:             loc_oPag.AddObject("grd_4c_Dados", "Grid")
374:             loc_oGrd = loc_oPag.grd_4c_Dados
375:             WITH loc_oGrd
376:                 .Left                = 145
377:                 .Top                 = 135
378:                 .Width               = 432
379:                 .Height              = 244
380:                 .ColumnCount         = 4
381:                 .FontName            = "Tahoma"
382:                 .FontSize            = 8
383:                 .DeleteMark          = .F.
384:                 .RecordMark          = .F.
385:                 .RowHeight           = 16
386:                 .ScrollBars          = 2
387:                 .GridLineColor       = RGB(238, 238, 238)
388:                 .HighlightBackColor  = RGB(255, 255, 255)
389:                 .HighlightForeColor  = RGB(15, 41, 104)
390:                 .HighlightStyle      = 2
391: 
392:                 WITH .Column1
393:                     .Width     = 58
394:                     .Movable   = .F.
395:                     .Resizable = .F.
396:                     .FontName  = "Tahoma"
397:                     .FontSize  = 8
398:                     WITH .Header1

*-- Linhas 653 a 674:
653:                 *-- ColumnCount ANTES de RecordSource (regra VFP9)
654:                 loc_oGrd.ColumnCount           = 4
655:                 loc_oGrd.RecordSource          = "cursor_4c_BINs"
656:                 loc_oGrd.Column1.ControlSource = "cursor_4c_BINs.codbins"
657:                 loc_oGrd.Column2.ControlSource = "cursor_4c_BINs.descs"
658:                 loc_oGrd.Column3.ControlSource = "cursor_4c_BINs.datais"
659:                 loc_oGrd.Column4.ControlSource = "cursor_4c_BINs.datafs"
660: 
661:                 *-- Reconfigurar headers (RecordSource os reseta)
662:                 loc_oGrd.Column1.Header1.Caption = "B I N"
663:                 loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
664:                 loc_oGrd.Column3.Header1.Caption = "Validade De"
665:                 loc_oGrd.Column4.Header1.Caption = "Validade Ate"
666: 
667:                 loc_oGrd.Refresh()
668:                 loc_lSucesso = .T.
669:             ENDIF
670:         CATCH TO loc_oErro
671:             MsgErro(loc_oErro.Message + CHR(13) + ;
672:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
673:                 "Procedure: " + loc_oErro.Procedure, "FormFpb.CarregarDados")
674:         ENDTRY

*-- Linhas 683 a 702:
683:         LOCAL loc_oPag, loc_oGrd, loc_oErro
684:         TRY
685:             IF USED("cursor_4c_BINs")
686:                 SELECT cursor_4c_BINs
687:                 INSERT INTO cursor_4c_BINs (fpags) VALUES (THIS.this_cFpags)
688:                 THIS.GravaDados = .T.
689:                 GOTO BOTTOM
690: 
691:                 loc_oPag = THIS.pgf_4c_Paginas.Page1
692:                 loc_oGrd = loc_oPag.grd_4c_Dados
693:                 IF VARTYPE(loc_oGrd) = "O"
694:                     loc_oGrd.Refresh()
695:                     loc_oGrd.Column1.SetFocus()
696:                 ENDIF
697:             ENDIF
698:         CATCH TO loc_oErro
699:             MsgErro(loc_oErro.Message + CHR(13) + ;
700:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
701:                 "Procedure: " + loc_oErro.Procedure, "FormFpb.BtnInserirClick")
702:         ENDTRY

*-- Linhas 710 a 730:
710:         LOCAL loc_oPag, loc_oGrd, loc_oErro
711:         TRY
712:             IF USED("cursor_4c_BINs")
713:                 SELECT cursor_4c_BINs
714:                 IF !EOF()
715:                     DELETE
716:                     SKIP
717:                     IF EOF()
718:                         SKIP -1
719:                     ENDIF
720:                     THIS.GravaDados = .T.
721: 
722:                     loc_oPag = THIS.pgf_4c_Paginas.Page1
723:                     loc_oGrd = loc_oPag.grd_4c_Dados
724:                     IF VARTYPE(loc_oGrd) = "O"
725:                         loc_oGrd.Refresh()
726:                     ENDIF
727:                 ENDIF
728:             ENDIF
729:         CATCH TO loc_oErro
730:             MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 841 a 860:
841:         LOCAL loc_oPag, loc_oGrd, loc_oErro
842:         TRY
843:             IF USED("cursor_4c_BINs")
844:                 SELECT cursor_4c_BINs
845:                 INSERT INTO cursor_4c_BINs (fpags) VALUES (THIS.this_cFpags)
846:                 THIS.GravaDados = .T.
847:                 GOTO BOTTOM
848: 
849:                 loc_oPag = THIS.pgf_4c_Paginas.Page1
850:                 loc_oGrd = loc_oPag.grd_4c_Dados
851:                 IF VARTYPE(loc_oGrd) = "O"
852:                     loc_oGrd.Refresh()
853:                     loc_oGrd.Column1.SetFocus()
854:                 ENDIF
855:                 THIS.this_cModoAtual = "INCLUIR"
856:             ENDIF
857:         CATCH TO loc_oErro
858:             MsgErro(loc_oErro.Message + CHR(13) + ;
859:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
860:                 "Procedure: " + loc_oErro.Procedure, "FormFpb.BtnIncluirClick")

*-- Linhas 870 a 888:
870:         LOCAL loc_oPag, loc_oGrd, loc_oErro
871:         TRY
872:             IF USED("cursor_4c_BINs")
873:                 SELECT cursor_4c_BINs
874:                 IF RECCOUNT() = 0 OR EOF()
875:                     MsgAviso("Nenhum BIN selecionado para altera" + CHR(231) + CHR(227) + "o.", ;
876:                         "Aten" + CHR(231) + CHR(227) + "o")
877:                     RETURN
878:                 ENDIF
879: 
880:                 loc_oPag = THIS.pgf_4c_Paginas.Page1
881:                 loc_oGrd = loc_oPag.grd_4c_Dados
882:                 IF VARTYPE(loc_oGrd) = "O"
883:                     loc_oGrd.Refresh()
884:                     loc_oGrd.Column2.SetFocus()
885:                     THIS.GravaDados = .T.
886:                 ENDIF
887:                 THIS.this_cModoAtual = "ALTERAR"
888:             ENDIF

*-- Linhas 902 a 920:
902:         LOCAL loc_oErro
903:         TRY
904:             IF USED("cursor_4c_BINs")
905:                 SELECT cursor_4c_BINs
906:                 IF RECCOUNT() = 0 OR EOF()
907:                     MsgAviso("Nenhum BIN selecionado para visualiza" + CHR(231) + CHR(227) + "o.", ;
908:                         "Aten" + CHR(231) + CHR(227) + "o")
909:                     RETURN
910:                 ENDIF
911: 
912:                 THIS.AlternarPagina(2)
913:                 THIS.this_cModoAtual = "VISUALIZAR"
914:             ENDIF
915:         CATCH TO loc_oErro
916:             MsgErro(loc_oErro.Message + CHR(13) + ;
917:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
918:                 "Procedure: " + loc_oErro.Procedure, "FormFpb.BtnVisualizarClick")
919:         ENDTRY
920:     ENDPROC

*-- Linhas 934 a 952:
934:         LOCAL loc_oErro
935:         TRY
936:             IF USED("cursor_4c_BINs") AND !EOF("cursor_4c_BINs")
937:                 SELECT cursor_4c_BINs
938:                 THIS.this_oBusinessObject.this_cCidChaves = TratarNulo(cidchaves, "C")
939:                 THIS.this_oBusinessObject.this_cCodBins   = TratarNulo(codbins,   "C")
940:                 THIS.this_oBusinessObject.this_cDescs     = TratarNulo(descs,     "C")
941:                 THIS.this_oBusinessObject.this_dDataIs    = IIF(ISNULL(datais), {}, ;
942:                     IIF(VARTYPE(datais) = "T", TTOD(datais), datais))
943:                 THIS.this_oBusinessObject.this_dDataFs    = IIF(ISNULL(datafs), {}, ;
944:                     IIF(VARTYPE(datafs) = "T", TTOD(datafs), datafs))
945:                 THIS.this_oBusinessObject.this_cFpags     = TratarNulo(fpags,     "C")
946:             ENDIF
947:         CATCH TO loc_oErro
948:             MsgErro(loc_oErro.Message + CHR(13) + ;
949:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
950:                 "Procedure: " + loc_oErro.Procedure, "FormFpb.FormParaBO")
951:         ENDTRY
952:     ENDPROC

*-- Linhas 1000 a 1018:
1000:         LOCAL loc_oGrd, loc_oErro
1001:         TRY
1002:             IF USED("cursor_4c_BINs")
1003:                 SELECT cursor_4c_BINs
1004:                 ZAP
1005:             ENDIF
1006:             THIS.GravaDados = .F.
1007: 
1008:             loc_oGrd = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
1009:             IF VARTYPE(loc_oGrd) = "O"
1010:                 loc_oGrd.Refresh()
1011:             ENDIF
1012:         CATCH TO loc_oErro
1013:             MsgErro(loc_oErro.Message + CHR(13) + ;
1014:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1015:                 "Procedure: " + loc_oErro.Procedure, "FormFpb.LimparCampos")
1016:         ENDTRY
1017:     ENDPROC
1018: 


### BO (C:\4c\projeto\app\classes\FpbBO.prg):
*==============================================================================
* FpbBO.prg - Business Object: Cadastro de BIN
* Tabela: SigOpFpb
* PK: cidchaves char(20)
* Herda de: BusinessBase
*==============================================================================
DEFINE CLASS FpbBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - Chave Primaria
    *--------------------------------------------------------------------------
    this_cCidChaves  = ""    && cidchaves char(20) - PK tecnica (auto-gerada)

    *--------------------------------------------------------------------------
    * Propriedades - Campos da tabela SigOpFpb
    *--------------------------------------------------------------------------
    this_cCodBins    = ""    && codbins   char(6)      - codigo BIN
    this_cDescs      = ""    && descs     char(30)     - descricao
    this_dDataIs     = {}    && datais    datetime NULL - validade de
    this_dDataFs     = {}    && datafs    datetime NULL - validade ate
    this_cFpags      = ""    && fpags     char(12)     - FK condicao de pagamento

    *--------------------------------------------------------------------------
    * Propriedades de controle
    *--------------------------------------------------------------------------
    this_lGravaDados = .F.   && indica se houve alteracao nos dados do grid

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigOpFpb"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpbBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
                THIS.this_cCodBins   = TratarNulo(codbins,   "C")
                THIS.this_cDescs     = TratarNulo(descs,     "C")
                THIS.this_dDataIs    = IIF(ISNULL(datais), {}, IIF(VARTYPE(datais) = "T", TTOD(datais), datais))
                THIS.this_dDataFs    = IIF(ISNULL(datafs), {}, IIF(VARTYPE(datafs) = "T", TTOD(datafs), datafs))
                THIS.this_cFpags     = TratarNulo(fpags,     "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpbBO.CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida campos obrigatorios antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarDados()
        IF EMPTY(THIS.this_cCodBins)
            MsgAviso("C" + CHR(243) + "digo BIN " + CHR(233) + ;
                " " + CHR(233) + " obrigat" + CHR(243) + "rio.", ;
                "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cFpags)
            MsgAviso("Condi" + CHR(231) + CHR(227) + "o de pagamento " + CHR(233) + ;
                " obrigat" + CHR(243) + "ria.", ;
                "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo BIN no banco de dados
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.ValidarDados()
                THIS.this_cCidChaves = THIS.GerarChavePrimaria()

                loc_cSQL = "INSERT INTO SigOpFpb " + ;
                           "(cidchaves, codbins, descs, datais, datafs, fpags) " + ;
                           "VALUES (" + ;
                           EscaparSQL(THIS.this_cCidChaves)    + ", " + ;
                           EscaparSQL(THIS.this_cCodBins)      + ", " + ;
                           EscaparSQL(THIS.this_cDescs)        + ", " + ;
                           FormatarDataSQL(THIS.this_dDataIs)  + ", " + ;
                           FormatarDataSQL(THIS.this_dDataFs)  + ", " + ;
                           EscaparSQL(THIS.this_cFpags)        + ")"

                IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                    THIS.RegistrarAuditoria("I")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inserir BIN no banco de dados.", "FpbBO.Inserir")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpbBO.Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza BIN existente no banco de dados
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.ValidarDados()
                loc_cSQL = "UPDATE SigOpFpb SET " + ;
                           "codbins = " + EscaparSQL(THIS.this_cCodBins)     + ", " + ;
                           "descs   = " + EscaparSQL(THIS.this_cDescs)       + ", " + ;
                           "datais  = " + FormatarDataSQL(THIS.this_dDataIs) + ", " + ;
                           "datafs  = " + FormatarDataSQL(THIS.this_dDataFs) + ", " + ;
                           "fpags   = " + EscaparSQL(THIS.this_cFpags)       + ;
                           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

                IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                    THIS.RegistrarAuditoria("A")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao atualizar BIN no banco de dados.", "FpbBO.Atualizar")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpbBO.Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui BIN do banco de dados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "DELETE FROM SigOpFpb " + ;
                       "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                THIS.RegistrarAuditoria("E")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir BIN do banco de dados.", "FpbBO.ExecutarExclusao")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpbBO.ExecutarExclusao")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarBINs - Carrega BINs de uma condicao de pagamento em cursor local
    *--------------------------------------------------------------------------
    FUNCTION CarregarBINs(par_cFpags)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_BINs")
                USE IN cursor_4c_BINs
            ENDIF
            IF USED("cursor_4c_BINsTemp")
                USE IN cursor_4c_BINsTemp
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_BINs ( ;
                cidchaves C(20) NULL, ;
                codbins   C(6)  NULL, ;
                descs     C(30) NULL, ;
                datais    T     NULL, ;
                datafs    T     NULL, ;
                fpags     C(12) NULL  ;
            )
            SET NULL OFF

            loc_cSQL = "SELECT cidchaves, codbins, descs, datais, datafs, fpags " + ;
                       "FROM SigOpFpb " + ;
                       "WHERE fpags = " + EscaparSQL(par_cFpags) + ;
                       " ORDER BY codbins"

            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BINsTemp")

            IF USED("cursor_4c_BINsTemp")
                SELECT cursor_4c_BINs
                APPEND FROM DBF("cursor_4c_BINsTemp")
                USE IN cursor_4c_BINsTemp
            ENDIF

            SELECT cursor_4c_BINs
            INDEX ON codbins TAG codbins
            SET ORDER TO
            GOTO TOP

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpbBO.CarregarBINs")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDuplicidade - Verifica se ha codbins duplicados no cursor
    *--------------------------------------------------------------------------
    FUNCTION ValidarDuplicidade(par_cCursorBINs)
        LOCAL loc_lValido, loc_oErro
        loc_lValido = .T.
        TRY
            IF USED(par_cCursorBINs)
                IF USED("cursor_4c_DupBINs")
                    USE IN cursor_4c_DupBINs
                ENDIF

                SELECT codbins, SUM(1) AS nQtd ;
                    FROM (par_cCursorBINs) ;
                    WHERE !EMPTY(codbins) ;
                    GROUP BY codbins ;
                    HAVING SUM(1) > 1 ;
                    INTO CURSOR cursor_4c_DupBINs READWRITE

                IF RECCOUNT("cursor_4c_DupBINs") > 0
                    loc_lValido = .F.
                ENDIF

                IF USED("cursor_4c_DupBINs")
                    USE IN cursor_4c_DupBINs
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpbBO.ValidarDuplicidade")
            loc_lValido = .F.
        ENDTRY
        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarBINs - Exclui BINs antigos e reinsere todos do cursor local
    *--------------------------------------------------------------------------
    FUNCTION SalvarBINs(par_cFpags, par_cCursorBINs)
        LOCAL loc_lSucesso, loc_lErroInsert, loc_cSQL, loc_cChave, loc_oErro
        loc_lSucesso    = .F.
        loc_lErroInsert = .F.
        TRY
            IF THIS.ValidarDuplicidade(par_cCursorBINs)
                loc_cSQL = "DELETE FROM SigOpFpb WHERE fpags = " + EscaparSQL(par_cFpags)
                IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                    IF USED(par_cCursorBINs)
                        SELECT (par_cCursorBINs)
                        GOTO TOP
                        SCAN WHILE !loc_lErroInsert
                            IF !EMPTY(codbins)
                                loc_cChave = THIS.GerarChavePrimaria()

                                loc_cSQL = "INSERT INTO SigOpFpb " + ;
                                           "(cidchaves, codbins, descs, datais, datafs, fpags) " + ;
                                           "VALUES (" + ;
                                           EscaparSQL(loc_cChave)   + ", " + ;
                                           EscaparSQL(codbins)       + ", " + ;
                                           EscaparSQL(descs)         + ", " + ;
                                           FormatarDataSQL(datais)   + ", " + ;
                                           FormatarDataSQL(datafs)   + ", " + ;
                                           EscaparSQL(par_cFpags)    + ")"

                                IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                                    MsgErro("Erro ao salvar BIN: " + ALLTRIM(codbins), ;
                                        "FpbBO.SalvarBINs")
                                    loc_lErroInsert = .T.
                                ENDIF
                            ENDIF
                        ENDSCAN
                        loc_lSucesso = !loc_lErroInsert
                    ELSE
                        loc_lSucesso = .T.
                    ENDIF
                ELSE
                    MsgErro("Erro ao excluir BINs anteriores da condi" + CHR(231) + CHR(227) + ;
                        "o de pagamento.", "FpbBO.SalvarBINs")
                ENDIF
            ELSE
                MsgAviso("Dados inconsistentes. C" + CHR(243) + "digo BIN em duplicidade!!!", ;
                    "Valida" + CHR(231) + CHR(227) + "o")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpbBO.SalvarBINs")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarChavePrimaria - Gera chave unica de 20 chars (substitui fUniqueIds)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarChavePrimaria()
        LOCAL loc_cTs, loc_cRand, loc_cChave
        loc_cTs    = TTOC(DATETIME(), 1)
        loc_cRand  = TRANSFORM(INT(RAND() * 999999), "999999")
        loc_cChave = LEFT(loc_cTs + loc_cRand, 20)
        RETURN loc_cChave
    ENDFUNC

ENDDEFINE

