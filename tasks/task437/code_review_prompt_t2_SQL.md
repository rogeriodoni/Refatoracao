# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUCLASS

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
  ControlSource = "CrSigCdGre.class"
  ControlSource = "CrSigCdGre.tipos"
  ControlSource = "CrSigCdGre.grupo"
Select crSigCdGre
=Seek(ThisForm.Pagina.Dados.Get_Grupo.Value+ThisForm.Pagina.Dados.Get_Class.Value,'crSigCdGre','gruclass')
lcQryGruEmp = [Select * From SigCdGre Order By Grupo,Class ]

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formgem.prg) - TRECHOS RELEVANTES PARA PASS SQL (868 linhas total):

*-- Linhas 336 a 354:
336:             .HighlightBackColor = RGB(255, 255, 255)
337:             .HighlightForeColor = RGB(15, 41, 104)
338:             .HighlightStyle     = 2
339:             .DeleteMark         = .F.
340:             .RecordMark         = .F.
341:             .RowHeight          = 16
342:             .ScrollBars         = 2
343:             .GridLines          = 3
344:             .ReadOnly           = .T.
345:             .Visible            = .T.
346:         ENDWITH
347: 
348:         THIS.TornarControlesVisiveis(loc_oPagina)
349:     ENDPROC
350: 
351:     *==========================================================================
352:     * ConfigurarPaginaDados - Configura Page2 (Dados) com campos e botoes
353:     *==========================================================================
354:     PROTECTED PROCEDURE ConfigurarPaginaDados()

*-- Linhas 558 a 577:
558:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
559:                 loc_oGrid.ColumnCount = 2
560:                 loc_oGrid.RecordSource         = "cursor_4c_Dados"
561:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.grupo"
562:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.class"
563:                 loc_oGrid.Column1.Width         = 115
564:                 loc_oGrid.Column2.Width         = 115
565:                 loc_oGrid.Column1.Header1.Caption = "Grupo"
566:                 loc_oGrid.Column2.Header1.Caption = "Classifica" + CHR(231) + CHR(227) + "o"
567:                 THIS.FormatarGridLista(loc_oGrid)
568:                 loc_lResultado = .T.
569:                 ENDIF
570:             ENDIF
571:         CATCH TO loc_oErro
572:             MsgErro("Erro em CarregarLista: " + loc_oErro.Message, "Erro")
573:             loc_lResultado = .F.
574:         ENDTRY
575: 
576:         RETURN loc_lResultado
577:     ENDPROC

*-- Linhas 619 a 637:
619:             RETURN
620:         ENDIF
621: 
622:         SELECT cursor_4c_Dados
623:         loc_cGruClass = ALLTRIM(cursor_4c_Dados.gruclass)
624: 
625:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGruClass)
626:             THIS.this_cModoAtual = "VISUALIZAR"
627:             THIS.BOParaForm()
628:             THIS.HabilitarCampos(.F.)
629:             THIS.AjustarBotoesPorModo()
630:             THIS.AlternarPagina(2)
631:             THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus
632:         ENDIF
633:     ENDPROC
634: 
635:     *==========================================================================
636:     * BtnAlterarClick - Inicia alteracao do registro selecionado
637:     *==========================================================================

*-- Linhas 644 a 662:
644:             RETURN
645:         ENDIF
646: 
647:         SELECT cursor_4c_Dados
648:         loc_cGruClass = ALLTRIM(cursor_4c_Dados.gruclass)
649: 
650:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGruClass)
651:             THIS.this_oBusinessObject.EditarRegistro()
652:             THIS.this_cModoAtual = "ALTERAR"
653:             THIS.BOParaForm()
654:             THIS.HabilitarCampos(.T.)
655:             THIS.AjustarBotoesPorModo()
656:             THIS.AlternarPagina(2)
657:         ENDIF
658:     ENDPROC
659: 
660:     *==========================================================================
661:     * BtnExcluirClick - Exclui registro selecionado com confirmacao
662:     *==========================================================================

*-- Linhas 669 a 687:
669:             RETURN
670:         ENDIF
671: 
672:         SELECT cursor_4c_Dados
673:         loc_cGruClass  = ALLTRIM(cursor_4c_Dados.gruclass)
674:         loc_cGrupo     = ALLTRIM(cursor_4c_Dados.grupo)
675:         loc_cClass     = ALLTRIM(cursor_4c_Dados.class)
676: 
677:         IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro?" + CHR(13) + ;
678:                        "Grupo: " + loc_cGrupo + CHR(13) + ;
679:                        "Classifica" + CHR(231) + CHR(227) + "o: " + loc_cClass, ;
680:                        "Confirmar Exclus" + CHR(227) + "o")
681:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGruClass)
682:                 IF THIS.this_oBusinessObject.Excluir()
683:                     MsgSucesso("Registro exclu" + CHR(237) + "do com sucesso!")
684:                     THIS.CarregarLista()
685:                 ENDIF
686:             ENDIF
687:         ENDIF


### BO (C:\4c\projeto\app\classes\gemBO.prg):
*==============================================================================
* gemBO.prg - Business Object para Grupo Empresarial (SigCdGre)
* Herda de BusinessBase
*==============================================================================

DEFINE CLASS gemBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - campos da tabela SigCdGre
    *--------------------------------------------------------------------------
    this_cCidChaves = ""   && cidchaves C(20) - PK gerada
    this_cClass     = ""   && class     C(15) - Classificacao
    this_cGruClass  = ""   && gruclass  C(30) - grupo+class concatenado
    this_cGrupo     = ""   && grupo     C(15) - Grupo
    this_nTipos     = 1    && tipos     N(1,0) - 1=Industrial, 2=Diversos

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdGre"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros com filtro opcional
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, grupo, class, gruclass, tipos" + ;
                       " FROM SigCdGre"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY grupo, class"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar dados: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Buscar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo gruclass (grupo+class)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, grupo, class, gruclass, tipos" + ;
                       " FROM SigCdGre" + ;
                       " WHERE gruclass = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorCodigo: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            THIS.this_cGrupo     = TratarNulo(grupo,     "C")
            THIS.this_cClass     = TratarNulo(class,     "C")
            THIS.this_cGruClass  = TratarNulo(gruclass,  "C")
            THIS.this_nTipos     = TratarNulo(tipos,     "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna cidchaves para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDuplicata - Verifica se grupo+class ja existe (usar antes de INSERT)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDuplicata()
        LOCAL loc_cSQL, loc_nResultado, loc_lDuplicata, loc_cGruClass
        loc_lDuplicata = .F.

        TRY
            loc_cGruClass = ALLTRIM(THIS.this_cGrupo) + ALLTRIM(THIS.this_cClass)
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdGre" + ;
                       " WHERE gruclass = " + EscaparSQL(loc_cGruClass)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupCheck")
            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_DupCheck") > 0
                SELECT cursor_4c_DupCheck
                loc_lDuplicata = (qtd > 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar duplicata: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_DupCheck")
            USE IN cursor_4c_DupCheck
        ENDIF

        RETURN loc_lDuplicata
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdGre (PROTECTED)
    * Logica original: gera cidchaves via fUniqueIds(), seta gruclass=grupo+class
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cGruClass
        loc_lSucesso = .F.

        TRY
            *-- Gerar ID unico para cidchaves (equivalente ao fUniqueIds() do legado)
            THIS.this_cCidChaves = LEFT(SYS(2015) + SYS(2015) + SYS(2015), 20)

            *-- gruclass = grupo+class concatenado (indice da tabela)
            loc_cGruClass = ALLTRIM(THIS.this_cGrupo) + ALLTRIM(THIS.this_cClass)
            THIS.this_cGruClass = loc_cGruClass

            loc_cSQL = "INSERT INTO SigCdGre (cidchaves, grupo, class, gruclass, tipos)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cGrupo) + ", " + ;
                       EscaparSQL(THIS.this_cClass) + ", " + ;
                       EscaparSQL(loc_cGruClass) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTipos) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir registro: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Inserir: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdGre (PROTECTED)
    * Nota: grupo e class nao sao editaveis no ALTERAR (apenas tipos)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdGre SET" + ;
                       " tipos = " + FormatarNumeroSQL(THIS.this_nTipos) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar registro: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Atualizar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigCdGre (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdGre" + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir registro: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ExecutarExclusao: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

