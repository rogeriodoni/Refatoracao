# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'UFIBGES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGOS, DESCS

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
  ControlSource = "crSigCdMun.Descs"
  ControlSource = "crSigCdMun.UFIBGES"
  ControlSource = "crSigCdMun.Codigos"
SELECT crSigCdMun
		lcQry = [Select * from SigCdMun]
Select crSigCdMun
Select crSigCdMun
	lcquery = [select codigos from SigCdMun where codigos = '] + ThisForm.Pagina.Dados.Get_Codigos.Value + ;
	thisform.podatamgr.sqlexecute(lcquery,'Tmpmunic')
	Select crSigCdMun

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormMun.prg) - TRECHOS RELEVANTES PARA PASS SQL (1097 linhas total):

*-- Linhas 315 a 333:
315:             .HighlightBackColor = RGB(255, 255, 255)
316:             .HighlightForeColor = RGB(15, 41, 104)
317:             .HighlightStyle     = 2
318:             .DeleteMark         = .F.
319:             .RecordMark         = .F.
320:             .RowHeight          = 16
321:             .ScrollBars         = 2
322:             .GridLines          = 3
323:             .ReadOnly           = .T.
324:             .Visible            = .T.
325:         ENDWITH
326: 
327:         *-- ColumnCount fora do WITH (Problema 36: evitar "Unknown member COLUMN1")
328:         loc_oPagina.grd_4c_Lista.ColumnCount = 2
329:         WITH loc_oPagina.grd_4c_Lista.Column1
330:             .Width           = 60
331:             .Alignment       = 0
332:             .Header1.Caption = "C" + CHR(243) + "digo"
333:         ENDWITH

*-- Linhas 594 a 613:
594:                     *-- Problema 36: RecordSource e ColumnCount FORA de WITH
595:                     loc_oGrid.ColumnCount = 2
596:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
597:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
598:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
599: 
600:                     *-- Problema 32: redefinir cabecalhos apos RecordSource (auto-bind reseta)
601:                     loc_oGrid.Column1.Width           = 60
602:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
603:                     loc_oGrid.Column2.Width           = 290
604:                     loc_oGrid.Column2.Header1.Caption = "Munic" + CHR(237) + "pio"
605: 
606:                     THIS.FormatarGridLista(loc_oGrid)
607:                     loc_oGrid.Refresh()
608:                     loc_lResultado = .T.
609:                 ENDIF
610:             CATCH TO loException
611:                 MsgErro(loException.Message + CHR(13) + ;
612:                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
613:                     "Procedure: " + loException.Procedure, ;

*-- Linhas 706 a 724:
706:             RETURN
707:         ENDIF
708: 
709:         SELECT cursor_4c_Dados
710:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
711: 
712:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
713:             THIS.this_cModoAtual = "VISUALIZAR"
714:             THIS.BOParaForm()
715:             THIS.HabilitarCampos(.F.)
716:             THIS.AlternarPagina(2)
717:         ELSE
718:             MsgAviso("Erro ao carregar o munic" + CHR(237) + "pio selecionado.", "")
719:         ENDIF
720:     ENDPROC
721: 
722:     *==========================================================================
723:     * BtnAlterarClick - Abre municipio selecionado para edicao
724:     *==========================================================================

*-- Linhas 730 a 748:
730:             RETURN
731:         ENDIF
732: 
733:         SELECT cursor_4c_Dados
734:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
735: 
736:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
737:             THIS.this_oBusinessObject.EditarRegistro()
738:             THIS.this_cModoAtual = "ALTERAR"
739:             THIS.BOParaForm()
740:             THIS.HabilitarCampos(.T.)
741:             THIS.AlternarPagina(2)
742:         ELSE
743:             MsgAviso("Erro ao carregar o munic" + CHR(237) + "pio selecionado.", "")
744:         ENDIF
745:     ENDPROC
746: 
747:     *==========================================================================
748:     * BtnExcluirClick - Exclui municipio selecionado apos confirmacao

*-- Linhas 755 a 773:
755:             RETURN
756:         ENDIF
757: 
758:         SELECT cursor_4c_Dados
759:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
760: 
761:         loc_lConfirmado = MsgConfirma("Deseja excluir o munic" + CHR(237) + ;
762:             "pio '" + loc_cCodigo + "'?", ;
763:             "Confirmar Exclus" + CHR(227) + "o")
764: 
765:         IF loc_lConfirmado
766:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
767:                 IF THIS.this_oBusinessObject.Excluir()
768:                     MsgInfo("Munic" + CHR(237) + "pio exclu" + CHR(237) + ;
769:                         "do com sucesso!", "")
770:                     THIS.CarregarLista()
771:                 ENDIF
772:             ELSE
773:                 MsgAviso("Erro ao carregar o munic" + CHR(237) + ;

*-- Linhas 795 a 813:
795:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMun")
796:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaMun.codigos)
797:                     IF USED("cursor_4c_Dados")
798:                         SELECT cursor_4c_Dados
799:                         LOCATE FOR ALLTRIM(codigos) = loc_cCodigo
800:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
801:                     ENDIF
802:                 ENDIF
803: 
804:                 loc_oBusca.Release()
805:             ENDIF
806:         CATCH TO loException
807:             MsgErro(loException.Message + CHR(13) + ;
808:                 "Linha: " + TRANSFORM(loException.LineNo), ;
809:                 "FormMun.BtnBuscarClick")
810:         ENDTRY
811: 
812:         IF USED("cursor_4c_BuscaMun")
813:             USE IN cursor_4c_BuscaMun

*-- Linhas 971 a 1015:
971: 
972:         TRY
973:             *-- Busca exata por UFIBGEs
974:             loc_cSQL = "SELECT UFIBGEs, Estados, Descrs FROM SigCdUfs" + ;
975:                 " WHERE UFIBGEs = " + TRANSFORM(loc_nUFIBGES)
976: 
977:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaUF")
978: 
979:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaUF") = 0
980:                 *-- Nao encontrado - mostrar lista completa para selecao
981:                 IF USED("cursor_4c_BuscaUF")
982:                     USE IN cursor_4c_BuscaUF
983:                 ENDIF
984: 
985:                 loc_cSQL = "SELECT UFIBGEs, Estados, Descrs FROM SigCdUfs ORDER BY UFIBGEs"
986:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaUF")
987: 
988:                 IF loc_nResult > 0 AND USED("cursor_4c_BuscaUF") AND RECCOUNT("cursor_4c_BuscaUF") > 0
989:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
990: 
991:                     IF VARTYPE(loc_oBusca) = "O"
992:                         loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaUF"
993:                         loc_oBusca.this_cTitulo        = "Selecionar UF no IBGE"
994:                         loc_oBusca.mAddColuna("UFIBGEs", "", "C" + CHR(243) + "d. IBGE")
995:                         loc_oBusca.mAddColuna("Estados", "", "UF")
996:                         loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
997:                         loc_oBusca.Show()
998: 
999:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUF")
1000:                             SELECT cursor_4c_BuscaUF
1001:                             loc_oPagina.txt_4c_UFIBGES.Value = cursor_4c_BuscaUF.UFIBGEs
1002:                         ELSE
1003:                             loc_oPagina.txt_4c_UFIBGES.Value = 0
1004:                         ENDIF
1005:                         loc_oBusca.Release()
1006:                     ENDIF
1007:                 ELSE
1008:                     MsgAviso("C" + CHR(243) + "d. UF IBGE n" + CHR(227) + "o encontrado.", "")
1009:                     loc_oPagina.txt_4c_UFIBGES.Value = 0
1010:                 ENDIF
1011:             ENDIF
1012:         CATCH TO loException
1013:             MsgErro(loException.Message + CHR(13) + ;
1014:                 "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
1015:                 "Procedure: " + loException.Procedure, ;


### BO (C:\4c\projeto\app\classes\MunBO.prg):
*==============================================================================
* MunBO.prg - Business Object para Cadastro de Municípios
* Tabela: SigCdMun
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS MunBO AS BusinessBase

    *-- Propriedades da tabela SigCdMun
    this_cCidChaves = ""     && cidchaves char(20) - chave interna PK do banco
    this_cCodigos   = ""     && codigos char(7) - código do município (negócio)
    this_cDescs     = ""     && descs char(40) - nome do município
    this_nUFIBGES   = 0      && ufibges numeric(2,0) - código da UF no IBGE

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdMun"
            THIS.this_cCampoChave = "cidchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "MunBO.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave interna para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            THIS.this_cCodigos   = TratarNulo(codigos,   "C")
            THIS.this_cDescs     = TratarNulo(descs,     "C")
            THIS.this_nUFIBGES   = TratarNulo(ufibges,   "N")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - SELECT todos os municípios (PUBLIC - chamado pelo Form)
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT codigos, descs, ufibges, cidchaves" + ;
                       " FROM SigCdMun" + ;
                       " ORDER BY codigos"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar municípios:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "MunBO.Buscar")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega município por código de negócio (codigos)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT codigos, descs, ufibges, cidchaves" + ;
                       " FROM SigCdMun" + ;
                       " WHERE codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "MunBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdMun (PROTECTED - chamado por Salvar())
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cCidChaves = SYS(2015) + SYS(2015)
                THIS.this_cCidChaves = LEFT(THIS.this_cCidChaves, 20)
            ENDIF

            loc_cSQL = "INSERT INTO SigCdMun (codigos, descs, ufibges, cidchaves) VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCodigos)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDescs))   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nUFIBGES)   + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCidChaves)) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir município:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "MunBO.Inserir")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdMun (PROTECTED - chamado por Salvar())
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdMun SET" + ;
                       " descs = "   + EscaparSQL(ALLTRIM(THIS.this_cDescs))   + "," + ;
                       " ufibges = " + FormatarNumeroSQL(THIS.this_nUFIBGES)   + ;
                       " WHERE codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigos))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar município:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "MunBO.Atualizar")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigCdMun (PROTECTED - chamado por Excluir())
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdMun" + ;
                       " WHERE codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigos))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir município:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "MunBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDuplicidade - Verifica se código já cadastrado
    * Para INSERT: verifica se codigos existe
    * Para UPDATE: verifica se outro registro tem o mesmo codigos
    *--------------------------------------------------------------------------
    FUNCTION ValidarDuplicidade()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        *-- codigos nao pode ser alterado no UPDATE, entao duplicidade so eh possivel em INSERT
        IF !THIS.this_lNovoRegistro
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT codigos FROM SigCdMun" + ;
                       " WHERE codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigos))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_DupMun")
                TABLEREVERT(.T., "cursor_4c_DupMun")
                USE IN cursor_4c_DupMun
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupMun")

            IF loc_nResult >= 0
                loc_lResultado = (RECCOUNT("cursor_4c_DupMun") > 0)
            ENDIF

            IF USED("cursor_4c_DupMun")
                USE IN cursor_4c_DupMun
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "MunBO.ValidarDuplicidade")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE

