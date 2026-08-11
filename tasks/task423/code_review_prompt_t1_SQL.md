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

### FORM (C:\4c\projeto\app\forms\operacionais\FormFpb.prg) - TRECHOS RELEVANTES PARA PASS SQL (1120 linhas total):

*-- Linhas 363 a 392:
363:                 .ForeColor = RGB(90, 90, 90)
364:             ENDWITH
365: 
366:             *-- Grid de BINs (RecordSource e ControlSource sao setados em CarregarDados)
367:             loc_oPag.AddObject("grd_4c_Dados", "Grid")
368:             loc_oGrd = loc_oPag.grd_4c_Dados
369:             WITH loc_oGrd
370:                 .Left                = 145
371:                 .Top                 = 135
372:                 .Width               = 432
373:                 .Height              = 244
374:                 .ColumnCount         = 4
375:                 .FontName            = "Tahoma"
376:                 .FontSize            = 8
377:                 .DeleteMark          = .F.
378:                 .RecordMark          = .F.
379:                 .RowHeight           = 16
380:                 .ScrollBars          = 2
381:                 .GridLineColor       = RGB(238, 238, 238)
382:                 .HighlightBackColor  = RGB(255, 255, 255)
383:                 .HighlightForeColor  = RGB(15, 41, 104)
384:                 .HighlightStyle      = 2
385: 
386:                 WITH .Column1
387:                     .Width     = 58
388:                     .Movable   = .F.
389:                     .Resizable = .F.
390:                     .FontName  = "Tahoma"
391:                     .FontSize  = 8
392:                     WITH .Header1

*-- Linhas 647 a 668:
647:                 *-- ColumnCount ANTES de RecordSource (regra VFP9)
648:                 loc_oGrd.ColumnCount           = 4
649:                 loc_oGrd.RecordSource          = "cursor_4c_BINs"
650:                 loc_oGrd.Column1.ControlSource = "cursor_4c_BINs.codbins"
651:                 loc_oGrd.Column2.ControlSource = "cursor_4c_BINs.descs"
652:                 loc_oGrd.Column3.ControlSource = "cursor_4c_BINs.datais"
653:                 loc_oGrd.Column4.ControlSource = "cursor_4c_BINs.datafs"
654: 
655:                 *-- Reconfigurar headers (RecordSource os reseta)
656:                 loc_oGrd.Column1.Header1.Caption = "B I N"
657:                 loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
658:                 loc_oGrd.Column3.Header1.Caption = "Validade De"
659:                 loc_oGrd.Column4.Header1.Caption = "Validade Ate"
660: 
661:                 loc_oGrd.Refresh()
662:                 loc_lSucesso = .T.
663:             ENDIF
664:         CATCH TO loc_oErro
665:             MsgErro(loc_oErro.Message + CHR(13) + ;
666:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
667:                 "Procedure: " + loc_oErro.Procedure, "FormFpb.CarregarDados")
668:         ENDTRY

*-- Linhas 677 a 696:
677:         LOCAL loc_oPag, loc_oGrd, loc_oErro
678:         TRY
679:             IF USED("cursor_4c_BINs")
680:                 SELECT cursor_4c_BINs
681:                 INSERT INTO cursor_4c_BINs (fpags) VALUES (THIS.this_cFpags)
682:                 THIS.GravaDados = .T.
683:                 GOTO BOTTOM
684: 
685:                 loc_oPag = THIS.pgf_4c_Paginas.Page1
686:                 loc_oGrd = loc_oPag.grd_4c_Dados
687:                 IF VARTYPE(loc_oGrd) = "O"
688:                     loc_oGrd.Refresh()
689:                     loc_oGrd.Column1.SetFocus()
690:                 ENDIF
691:             ENDIF
692:         CATCH TO loc_oErro
693:             MsgErro(loc_oErro.Message + CHR(13) + ;
694:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
695:                 "Procedure: " + loc_oErro.Procedure, "FormFpb.BtnInserirClick")
696:         ENDTRY

*-- Linhas 704 a 724:
704:         LOCAL loc_oPag, loc_oGrd, loc_oErro
705:         TRY
706:             IF USED("cursor_4c_BINs")
707:                 SELECT cursor_4c_BINs
708:                 IF !EOF()
709:                     DELETE
710:                     SKIP
711:                     IF EOF()
712:                         SKIP -1
713:                     ENDIF
714:                     THIS.GravaDados = .T.
715: 
716:                     loc_oPag = THIS.pgf_4c_Paginas.Page1
717:                     loc_oGrd = loc_oPag.grd_4c_Dados
718:                     IF VARTYPE(loc_oGrd) = "O"
719:                         loc_oGrd.Refresh()
720:                     ENDIF
721:                 ENDIF
722:             ENDIF
723:         CATCH TO loc_oErro
724:             MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 835 a 854:
835:         LOCAL loc_oPag, loc_oGrd, loc_oErro
836:         TRY
837:             IF USED("cursor_4c_BINs")
838:                 SELECT cursor_4c_BINs
839:                 INSERT INTO cursor_4c_BINs (fpags) VALUES (THIS.this_cFpags)
840:                 THIS.GravaDados = .T.
841:                 GOTO BOTTOM
842: 
843:                 loc_oPag = THIS.pgf_4c_Paginas.Page1
844:                 loc_oGrd = loc_oPag.grd_4c_Dados
845:                 IF VARTYPE(loc_oGrd) = "O"
846:                     loc_oGrd.Refresh()
847:                     loc_oGrd.Column1.SetFocus()
848:                 ENDIF
849:                 THIS.this_cModoAtual = "INCLUIR"
850:             ENDIF
851:         CATCH TO loc_oErro
852:             MsgErro(loc_oErro.Message + CHR(13) + ;
853:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
854:                 "Procedure: " + loc_oErro.Procedure, "FormFpb.BtnIncluirClick")

*-- Linhas 864 a 882:
864:         LOCAL loc_oPag, loc_oGrd, loc_oErro
865:         TRY
866:             IF USED("cursor_4c_BINs")
867:                 SELECT cursor_4c_BINs
868:                 IF RECCOUNT() = 0 OR EOF()
869:                     MsgAviso("Nenhum BIN selecionado para altera" + CHR(231) + CHR(227) + "o.", ;
870:                         "Aten" + CHR(231) + CHR(227) + "o")
871:                     RETURN
872:                 ENDIF
873: 
874:                 loc_oPag = THIS.pgf_4c_Paginas.Page1
875:                 loc_oGrd = loc_oPag.grd_4c_Dados
876:                 IF VARTYPE(loc_oGrd) = "O"
877:                     loc_oGrd.Refresh()
878:                     loc_oGrd.Column2.SetFocus()
879:                     THIS.GravaDados = .T.
880:                 ENDIF
881:                 THIS.this_cModoAtual = "ALTERAR"
882:             ENDIF

*-- Linhas 896 a 914:
896:         LOCAL loc_oErro
897:         TRY
898:             IF USED("cursor_4c_BINs")
899:                 SELECT cursor_4c_BINs
900:                 IF RECCOUNT() = 0 OR EOF()
901:                     MsgAviso("Nenhum BIN selecionado para visualiza" + CHR(231) + CHR(227) + "o.", ;
902:                         "Aten" + CHR(231) + CHR(227) + "o")
903:                     RETURN
904:                 ENDIF
905: 
906:                 THIS.AlternarPagina(2)
907:                 THIS.this_cModoAtual = "VISUALIZAR"
908:             ENDIF
909:         CATCH TO loc_oErro
910:             MsgErro(loc_oErro.Message + CHR(13) + ;
911:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
912:                 "Procedure: " + loc_oErro.Procedure, "FormFpb.BtnVisualizarClick")
913:         ENDTRY
914:     ENDPROC

*-- Linhas 928 a 946:
928:         LOCAL loc_oErro
929:         TRY
930:             IF USED("cursor_4c_BINs") AND !EOF("cursor_4c_BINs")
931:                 SELECT cursor_4c_BINs
932:                 THIS.this_oBusinessObject.this_cCidChaves = TratarNulo(cidchaves, "C")
933:                 THIS.this_oBusinessObject.this_cCodBins   = TratarNulo(codbins,   "C")
934:                 THIS.this_oBusinessObject.this_cDescs     = TratarNulo(descs,     "C")
935:                 THIS.this_oBusinessObject.this_dDataIs    = IIF(ISNULL(datais), {}, ;
936:                     IIF(VARTYPE(datais) = "T", TTOD(datais), datais))
937:                 THIS.this_oBusinessObject.this_dDataFs    = IIF(ISNULL(datafs), {}, ;
938:                     IIF(VARTYPE(datafs) = "T", TTOD(datafs), datafs))
939:                 THIS.this_oBusinessObject.this_cFpags     = TratarNulo(fpags,     "C")
940:             ENDIF
941:         CATCH TO loc_oErro
942:             MsgErro(loc_oErro.Message + CHR(13) + ;
943:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
944:                 "Procedure: " + loc_oErro.Procedure, "FormFpb.FormParaBO")
945:         ENDTRY
946:     ENDPROC

*-- Linhas 994 a 1012:
994:         LOCAL loc_oGrd, loc_oErro
995:         TRY
996:             IF USED("cursor_4c_BINs")
997:                 SELECT cursor_4c_BINs
998:                 ZAP
999:             ENDIF
1000:             THIS.GravaDados = .F.
1001: 
1002:             loc_oGrd = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
1003:             IF VARTYPE(loc_oGrd) = "O"
1004:                 loc_oGrd.Refresh()
1005:             ENDIF
1006:         CATCH TO loc_oErro
1007:             MsgErro(loc_oErro.Message + CHR(13) + ;
1008:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1009:                 "Procedure: " + loc_oErro.Procedure, "FormFpb.LimparCampos")
1010:         ENDTRY
1011:     ENDPROC
1012: 


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

