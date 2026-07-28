# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-TABELA] Tabela 'SigCdBlq' usada no BO migrado mas NAO aparece no codigo original. Pode ser tabela inventada/confundida.

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
  ControlSource = "crSigCdBlq.dtInicial"
  ControlSource = "crSigCdBlq.dtFinal"
  ControlSource = "crSigCdBlq.codigos"
  ControlSource = "crSigCdBlq.inativo"
  ControlSource = "crSigCdBlq.dtincs"
  ControlSource = "crSigCdBlq.UsuIncs"
  ControlSource = "crSigCdBlq.dtAlts"
  ControlSource = "crSigCdBlq.UsuAlts"

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormBlq.prg) - TRECHOS RELEVANTES PARA PASS SQL (1138 linhas total):

*-- Linhas 353 a 371:
353:             .HighlightBackColor = RGB(255, 255, 255)
354:             .HighlightForeColor = RGB(15, 41, 104)
355:             .HighlightStyle     = 2
356:             .DeleteMark         = .F.
357:             .RecordMark         = .F.
358:             .RowHeight          = 16
359:             .ScrollBars         = 2
360:             .GridLines          = 3
361:             .Visible            = .T.
362:             .Column1.Width           = 80
363:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
364:             .Column2.Width           = 74
365:             .Column2.Header1.Caption = "Data Inicial"
366:             .Column3.Width           = 74
367:             .Column3.Header1.Caption = "Data Final"
368:             .Column4.Width           = 80
369:             .Column4.Header1.Caption = "Usu" + CHR(225) + "rio"
370:             .Column5.Width           = 52
371:             .Column5.Header1.Caption = "Inativo"

*-- Linhas 401 a 423:
401:                 IF THIS.this_oBusinessObject.Buscar("")
402:                     loc_oGrid.ColumnCount = 5
403:                     loc_oGrid.RecordSource          = "cursor_4c_Dados"
404:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Codigos"
405:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.dtInicial"
406:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.dtFinal"
407:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.UsuIncs"
408:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.inativo"
409:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
410:                     loc_oGrid.Column2.Header1.Caption = "Data Inicial"
411:                     loc_oGrid.Column3.Header1.Caption = "Data Final"
412:                     loc_oGrid.Column4.Header1.Caption = "Usu" + CHR(225) + "rio"
413:                     loc_oGrid.Column5.Header1.Caption = "Inativo"
414:                     THIS.FormatarGridLista(loc_oGrid)
415:                     loc_lResultado = .T.
416:                 ENDIF
417:             CATCH TO loc_oErro
418:                 MsgErro(loc_oErro.Message, "FormBlq.CarregarLista")
419:             ENDTRY
420:         ENDIF
421: 
422:         RETURN loc_lResultado
423:     ENDPROC

*-- Linhas 535 a 553:
535:             .Visible   = .T.
536:         ENDWITH
537: 
538:         *-- Get_Codigo: Campo codigo (auto-gerado no INSERT, editavel so em VISUALIZAR)
539:         *-- Original: top=137, left=435, width=82, height=23 -> top+29=166
540:         loc_oPg2.AddObject("txt_4c_Codigo", "TextBox")
541:         WITH loc_oPg2.txt_4c_Codigo
542:             .Value       = ""
543:             .Top         = 166
544:             .Left        = 435
545:             .Width       = 82
546:             .Height      = 23
547:             .FontName    = "Tahoma"
548:             .FontSize    = 8
549:             .ForeColor   = RGB(90, 90, 90)
550:             .BackColor   = RGB(255, 255, 255)
551:             .ReadOnly    = .T.
552:             .Enabled     = .T.
553:             .Visible     = .T.

*-- Linhas 926 a 944:
926:             RETURN loc_lResultado
927:         ENDIF
928: 
929:         SELECT cursor_4c_Dados
930:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)
931: 
932:         TRY
933:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
934:                 THIS.this_oBusinessObject.EditarRegistro()
935:                 THIS.this_cModoAtual = "ALTERAR"
936:                 THIS.BOParaForm()
937:                 THIS.HabilitarCampos(.T.)
938:                 THIS.AjustarBotoesPorModo()
939:                 THIS.AlternarPagina(2)
940:                 loc_lResultado = .T.
941:             ENDIF
942:         CATCH TO loc_oErro
943:             MsgErro(loc_oErro.Message, "FormBlq.BtnAlterarClick")
944:         ENDTRY

*-- Linhas 958 a 976:
958:             RETURN loc_lResultado
959:         ENDIF
960: 
961:         SELECT cursor_4c_Dados
962:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)
963: 
964:         TRY
965:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
966:                 THIS.this_cModoAtual = "VISUALIZAR"
967:                 THIS.BOParaForm()
968:                 THIS.HabilitarCampos(.F.)
969:                 THIS.AjustarBotoesPorModo()
970:                 THIS.AlternarPagina(2)
971:                 loc_lResultado = .T.
972:             ENDIF
973:         CATCH TO loc_oErro
974:             MsgErro(loc_oErro.Message, "FormBlq.BtnVisualizarClick")
975:         ENDTRY
976: 

*-- Linhas 988 a 1006:
988:             RETURN
989:         ENDIF
990: 
991:         SELECT cursor_4c_Dados
992:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)
993: 
994:         loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do bloqueio" + CHR(13) + ;
995:                                     loc_cCodigo + "?", "Confirmar Exclus" + CHR(227) + "o")
996: 
997:         IF loc_lConfirma
998:             TRY
999:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1000:                     IF THIS.this_oBusinessObject.Excluir()
1001:                         MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
1002:                         THIS.CarregarLista()
1003:                     ENDIF
1004:                 ENDIF
1005:             CATCH TO loc_oErro
1006:                 MsgErro(loc_oErro.Message, "FormBlq.BtnExcluirClick")

*-- Linhas 1046 a 1075:
1046:         IF THIS.this_cModoAtual = "BUSCAR"
1047:             loc_cCodFiltro = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
1048:             loc_cFiltro    = IIF(EMPTY(loc_cCodFiltro), "", ;
1049:                              "Codigos LIKE " + EscaparSQL(loc_cCodFiltro + "%"))
1050: 
1051:             TRY
1052:                 IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
1053:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1054:                     loc_oGrid.ColumnCount = 5
1055:                     loc_oGrid.RecordSource            = "cursor_4c_Dados"
1056:                     loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.Codigos"
1057:                     loc_oGrid.Column2.ControlSource   = "cursor_4c_Dados.dtInicial"
1058:                     loc_oGrid.Column3.ControlSource   = "cursor_4c_Dados.dtFinal"
1059:                     loc_oGrid.Column4.ControlSource   = "cursor_4c_Dados.UsuIncs"
1060:                     loc_oGrid.Column5.ControlSource   = "cursor_4c_Dados.inativo"
1061:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1062:                     loc_oGrid.Column2.Header1.Caption = "Data Inicial"
1063:                     loc_oGrid.Column3.Header1.Caption = "Data Final"
1064:                     loc_oGrid.Column4.Header1.Caption = "Usu" + CHR(225) + "rio"
1065:                     loc_oGrid.Column5.Header1.Caption = "Inativo"
1066:                     THIS.FormatarGridLista(loc_oGrid)
1067:                 ENDIF
1068:             CATCH TO loc_oErro
1069:                 MsgErro(loc_oErro.Message, "FormBlq.BtnSalvarClick.Buscar")
1070:             ENDTRY
1071: 
1072:             THIS.pgf_4c_Paginas.ActivePage = 1
1073:             THIS.this_cModoAtual           = "LISTA"
1074:             RETURN
1075:         ENDIF


### BO (C:\4c\projeto\app\classes\BlqBO.prg):
*------------------------------------------------------------------------------
* BlqBO.prg - Business Object para Bloqueios por Periodo (SigCdBlq)
* Herda de: BusinessBase
* Tabela: SigCdBlq
*------------------------------------------------------------------------------
DEFINE CLASS BlqBO AS BusinessBase

    *-- Propriedades da tabela SigCdBlq
    this_cCodigos   = ""    && Codigos    CHAR(10) - C" + CHR(243) + "digo gerado por fGerUniqueKey('BLOQUEIO')
    this_cCidChaves = ""    && CidChaves  CHAR     - Chave " + CHR(250) + "nica interna (gerada por fUniqueIds)
    this_dDtInicial = {}    && dtInicial  DATE     - Data inicial do per" + CHR(237) + "odo de bloqueio
    this_dDtFinal   = {}    && dtFinal    DATE     - Data final do per" + CHR(237) + "odo de bloqueio
    this_lInativo   = .F.   && inativo    LOGICAL  - Flag de registro inativo
    this_cUsuIncs   = ""    && UsuIncs    CHAR     - Usu" + CHR(225) + "rio de inclus" + CHR(227) + "o (somente leitura)
    this_dDtIncs    = {}    && DtIncs     DATETIME - Data/hora de inclus" + CHR(227) + "o (somente leitura)
    this_cUsuAlts   = ""    && UsuAlts    CHAR     - Usu" + CHR(225) + "rio de altera" + CHR(231) + CHR(227) + "o (somente leitura)
    this_dDtAlts    = {}    && DtAlts     DATETIME - Data/hora de altera" + CHR(231) + CHR(227) + "o (somente leitura)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdBlq"
        THIS.this_cCampoChave = "Codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da chave para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de um cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigos   = TratarNulo(Codigos,   "C")
            THIS.this_cCidChaves = TratarNulo(CidChaves, "C")
            THIS.this_dDtInicial = TratarNulo(dtInicial, "D")
            THIS.this_dDtFinal   = TratarNulo(dtFinal,   "D")
            THIS.this_lInativo   = ConverterParaLogico(inativo)
            THIS.this_cUsuIncs   = TratarNulo(UsuIncs,   "C")
            THIS.this_dDtIncs    = TratarNulo(DtIncs,    "D")
            THIS.this_cUsuAlts   = TratarNulo(UsuAlts,   "C")
            THIS.this_dDtAlts    = TratarNulo(DtAlts,    "D")
            THIS.this_lNovoRegistro = .F.
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista registros da tabela (PUBLIC)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cFiltro) <> "C"
            par_cFiltro = ""
        ENDIF

        TRY
            loc_cSQL = "SELECT Codigos, dtInicial, dtFinal, UsuIncs, DtIncs," + ;
                       " UsuAlts, DtAlts, inativo" + ;
                       " FROM SigCdBlq"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY Codigos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar bloqueios:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BlqBO.Buscar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pelo codigo (PUBLIC)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT Codigos, CidChaves, dtInicial, dtFinal, inativo," + ;
                       " UsuIncs, DtIncs, UsuAlts, DtAlts" + ;
                       " FROM SigCdBlq" + ;
                       " WHERE Codigos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar bloqueio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BlqBO.CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Inclui novo registro no banco (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_cCodigos   = fGerMascara(fGerUniqueKey("BLOQUEIO"))
            THIS.this_cCidChaves = fUniqueIds()
            THIS.this_cUsuIncs   = ALLTRIM(gc_4c_UsuarioLogado)

            loc_cSQL = "INSERT INTO SigCdBlq" + ;
                       " (Codigos, CidChaves, dtInicial, dtFinal, inativo," + ;
                       "  UsuIncs, DtIncs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigos) + ", " + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       FormatarDataSQL(THIS.this_dDtInicial) + ", " + ;
                       FormatarDataSQL(THIS.this_dDtFinal) + ", " + ;
                       IIF(THIS.this_lInativo, "1", "0") + ", " + ;
                       EscaparSQL(THIS.this_cUsuIncs) + ", " + ;
                       "GETDATE())"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao incluir bloqueio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BlqBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente no banco (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_cUsuAlts = ALLTRIM(gc_4c_UsuarioLogado)

            loc_cSQL = "UPDATE SigCdBlq SET" + ;
                       " dtInicial = " + FormatarDataSQL(THIS.this_dDtInicial) + "," + ;
                       " dtFinal   = " + FormatarDataSQL(THIS.this_dDtFinal) + "," + ;
                       " inativo   = " + IIF(THIS.this_lInativo, "1", "0") + "," + ;
                       " UsuAlts   = " + EscaparSQL(THIS.this_cUsuAlts) + "," + ;
                       " DtAlts    = GETDATE()" + ;
                       " WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar bloqueio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BlqBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove registro do banco (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdBlq" + ;
                       " WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir bloqueio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BlqBO.ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

