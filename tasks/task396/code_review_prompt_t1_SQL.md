# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PKCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODS

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
  ControlSource = "crSigCdDpi.Cods"
  ControlSource = "crSigCdDpi.Descs"
		lcQuery = [Select Cods ] + ;
				    [From SigCdDpi ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalBus]) < 1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormDpi.prg) - TRECHOS RELEVANTES PARA PASS SQL (876 linhas total):

*-- Linhas 329 a 347:
329:             .HighlightBackColor = RGB(255, 255, 255)
330:             .HighlightForeColor = RGB(15, 41, 104)
331:             .HighlightStyle     = 2
332:             .DeleteMark         = .F.
333:             .RecordMark         = .F.
334:             .RowHeight          = 16
335:             .ScrollBars         = 2
336:             .GridLines          = 3
337:             .Visible            = .T.
338:         ENDWITH
339: 
340:         loc_oPagina.grd_4c_Lista.ColumnCount = 2
341: 
342:         WITH loc_oPagina.grd_4c_Lista.Column1
343:             .Width     = 80
344:             .Alignment = 2
345:         ENDWITH
346: 
347:         WITH loc_oPagina.grd_4c_Lista.Column2

*-- Linhas 510 a 529:
510:                 loc_oGrid.ColumnCount = 2
511:                 loc_oGrid.RecordSource          = "cursor_4c_Dados"
512:                 loc_oGrid.ColumnCount           = 2
513:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
514:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
515: 
516:                 *-- Reconfigurar headers apos RecordSource (VFP reseta captions)
517:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
518:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
519: 
520:                 THIS.FormatarGridLista(loc_oGrid)
521:                 loc_lResultado = .T.
522:             ELSE
523:                 MsgErro("Erro ao carregar departamentos.", "Erro")
524:             ENDIF
525:         CATCH TO loc_oErro
526:             MsgErro(loc_oErro.Message, "FormDpi.CarregarLista")
527:         ENDTRY
528: 
529:         RETURN loc_lResultado

*-- Linhas 687 a 705:
687:             RETURN
688:         ENDIF
689: 
690:         SELECT cursor_4c_Dados
691:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
692: 
693:         IF EMPTY(loc_cCodigo)
694:             MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
695:             RETURN
696:         ENDIF
697: 
698:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
699:             THIS.this_cModoAtual = "VISUALIZAR"
700:             THIS.BOParaForm()
701:             THIS.HabilitarCampos(.F.)
702:             THIS.AjustarBotoesPorModo()
703:             THIS.pgf_4c_Paginas.ActivePage = 2
704:             THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus()
705:         ENDIF

*-- Linhas 717 a 735:
717:             RETURN
718:         ENDIF
719: 
720:         SELECT cursor_4c_Dados
721:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
722: 
723:         IF EMPTY(loc_cCodigo)
724:             MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
725:             RETURN
726:         ENDIF
727: 
728:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
729:             THIS.this_oBusinessObject.EditarRegistro()
730:             THIS.this_cModoAtual = "ALTERAR"
731:             THIS.BOParaForm()
732:             THIS.HabilitarCampos(.T.)
733:             THIS.AjustarBotoesPorModo()
734:             THIS.pgf_4c_Paginas.ActivePage = 2
735:             THIS.pgf_4c_Paginas.Page2.txt_4c_Descricao.SetFocus()

*-- Linhas 750 a 768:
750:             RETURN
751:         ENDIF
752: 
753:         SELECT cursor_4c_Dados
754:         loc_cCodigo    = ALLTRIM(cursor_4c_Dados.cods)
755:         loc_cDescricao = ALLTRIM(cursor_4c_Dados.descs)
756: 
757:         IF EMPTY(loc_cCodigo)
758:             MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
759:             RETURN
760:         ENDIF
761: 
762:         loc_lConfirma = MsgConfirma("Excluir o departamento:" + CHR(13) + ;
763:             CHR(13) + "C" + CHR(243) + "digo: " + loc_cCodigo + ;
764:             CHR(13) + "Descri" + CHR(231) + CHR(227) + "o: " + loc_cDescricao + ;
765:             CHR(13) + CHR(13) + "Confirma a exclus" + CHR(227) + "o?", ;
766:             "Confirmar Exclus" + CHR(227) + "o")
767: 
768:         IF loc_lConfirma

*-- Linhas 793 a 811:
793:                 loc_oBusca.Show()
794: 
795:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDpi")
796:                     SELECT cursor_4c_BuscaDpi
797:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaDpi.cods)
798:                 ENDIF
799: 
800:                 loc_oBusca.Release()
801:             ENDIF
802: 
803:             IF USED("cursor_4c_BuscaDpi")
804:                 USE IN cursor_4c_BuscaDpi
805:             ENDIF
806: 
807:             IF !EMPTY(loc_cCodigo)
808:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
809:                     THIS.this_cModoAtual = "VISUALIZAR"
810:                     THIS.BOParaForm()
811:                     THIS.HabilitarCampos(.F.)


### BO (C:\4c\projeto\app\classes\DpiBO.prg):
*==============================================================================
* DpiBO.prg - Business Object para Departamentos do Site
* Tabela: SigCdDpi (cods char(2), descs char(30), pkchaves char(20))
*==============================================================================
DEFINE CLASS DpiBO AS BusinessBase

    *-- Propriedades da entidade
    this_cCods      = ""   && cods     char(2)  - codigo do departamento
    this_cDescs     = ""   && descs    char(30) - descricao
    this_cPkChaves  = ""   && pkchaves char(20) - chave primaria (PK)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdDpi"
            THIS.this_cCampoChave = "pkchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK atual para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCods     = TratarNulo(cods,     "C")
            THIS.this_cDescs    = TratarNulo(descs,    "C")
            THIS.this_cPkChaves = TratarNulo(pkchaves, "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Retorna todos os registros (ou filtrados por texto livre)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_cFiltro) != "C"
                par_cFiltro = ""
            ENDIF

            loc_cSQL = "SELECT cods, descs, pkchaves FROM SigCdDpi"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + ;
                           " WHERE cods LIKE " + EscaparSQL(par_cFiltro + "%") + ;
                           "    OR descs LIKE " + EscaparSQL("%" + par_cFiltro + "%")
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY cods"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar departamentos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pela chave de negocio (cods)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT cods, descs, pkchaves FROM SigCdDpi" + ;
                       " WHERE cods = " + EscaparSQL(ALLTRIM(par_cCodigo))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MsgErro("Erro ao carregar departamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdDpi
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_cSQLDup, loc_nDup
        loc_lResultado = .F.

        *-- Validacoes fora do TRY (RETURN permitido aqui)
        IF EMPTY(ALLTRIM(THIS.this_cCods))
            MsgAviso("C" + CHR(243) + "digo inv" + CHR(225) + "lido!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cDescs))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            *-- Verificar duplicidade de codigo
            loc_cSQLDup = "SELECT cods FROM SigCdDpi WHERE cods = " + EscaparSQL(ALLTRIM(THIS.this_cCods))
            loc_nDup = SQLEXEC(gnConnHandle, loc_cSQLDup, "cursor_4c_Dup")
            IF loc_nDup >= 0 AND RECCOUNT("cursor_4c_Dup") > 0
                IF USED("cursor_4c_Dup")
                    USE IN cursor_4c_Dup
                ENDIF
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF USED("cursor_4c_Dup")
                    USE IN cursor_4c_Dup
                ENDIF

                *-- Gerar PK
                THIS.this_cPkChaves = fUniqueIds()

                loc_cSQL = "INSERT INTO SigCdDpi (cods, descs, pkchaves)" + ;
                           " VALUES (" + EscaparSQL(ALLTRIM(THIS.this_cCods)) + ;
                           ", " + EscaparSQL(ALLTRIM(THIS.this_cDescs)) + ;
                           ", " + EscaparSQL(THIS.this_cPkChaves) + ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao inserir departamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdDpi
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        *-- Validacoes fora do TRY (RETURN permitido aqui)
        IF EMPTY(ALLTRIM(THIS.this_cCods))
            MsgAviso("C" + CHR(243) + "digo inv" + CHR(225) + "lido!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cDescs))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "UPDATE SigCdDpi" + ;
                       " SET cods = " + EscaparSQL(ALLTRIM(THIS.this_cCods)) + ;
                       ", descs = " + EscaparSQL(ALLTRIM(THIS.this_cDescs)) + ;
                       " WHERE pkchaves = " + EscaparSQL(THIS.this_cPkChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar departamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigCdDpi
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdDpi WHERE pkchaves = " + EscaparSQL(THIS.this_cPkChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir departamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

