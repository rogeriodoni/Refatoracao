# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DEPTOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: AUTOS, CODIGOS

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
  ControlSource = "crSigCdDpt.codigos"
  ControlSource = "crSigCdDpt.Descricaos"
  ControlSource = "crSigCdDpt.Diretors"
  ControlSource = "crSigCdDpt.nChkSubs"
  ControlSource = "crSigCdDpt.nChkTipos"
  ControlSource = "crSigCdDpt.autos"
		lcQuery = [Select * from sigcddpt Where autos = 1 And Codigos <> '] + ThisForm.Pagina.Dados.getcodigos.Value + [']
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalSel]) < 1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormDepartamento.prg) - TRECHOS RELEVANTES PARA PASS SQL (1100 linhas total):

*-- Linhas 279 a 297:
279:             .BackColor   = RGB(255, 255, 255)
280:             .ColumnCount = -1
281:             .RecordMark  = .F.
282:             .DeleteMark  = .F.
283:             .Visible     = .T.
284:         ENDWITH
285: 
286:         THIS.TornarControlesVisiveis(loc_oPagina)
287:     ENDPROC
288: 
289:     *--------------------------------------------------------------------------
290:     * ConfigurarPaginaDados - Configura Page2 (Dados)
291:     * Compensacao PageFrame.Top=-29: todos os controles Top += 29
292:     * Posicoes originais do legado + 29px (compensacao do PageFrame)
293:     *--------------------------------------------------------------------------
294:     PROTECTED PROCEDURE ConfigurarPaginaDados()
295:         LOCAL loc_oPagina
296:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
297: 

*-- Linhas 668 a 696:
668: 
669:                     *-- Configurar colunas APOS RecordSource (Problema 48/32)
670:                     WITH loc_oGrid
671:                         .Column1.ControlSource   = "cursor_4c_Dados.codigos"
672:                         .Column1.Width           = 80
673:                         .Column1.Header1.Caption = "C" + CHR(243) + "digo"
674:                         .Column1.Alignment       = 2
675: 
676:                         .Column2.ControlSource   = "cursor_4c_Dados.descricaos"
677:                         .Column2.Width           = 290
678:                         .Column2.Header1.Caption = "Departamento"
679:                         .Column2.Alignment       = 0
680: 
681:                         .Column3.ControlSource   = "cursor_4c_Dados.diretors"
682:                         .Column3.Width           = 80
683:                         .Column3.Header1.Caption = "Diretor"
684:                         .Column3.Alignment       = 0
685:                     ENDWITH
686: 
687:                     THIS.FormatarGridLista(loc_oGrid)
688:                     loc_lResultado = .T.
689:                 ELSE
690:                     loc_lResultado = .F.
691:                 ENDIF
692:             ENDIF
693: 
694:         CATCH TO loException
695:             MostrarErro("Erro em CarregarLista:" + CHR(13) + loException.Message, "Erro")
696:             loc_lResultado = .F.

*-- Linhas 747 a 765:
747:         loc_cCodigo = ""
748: 
749:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
750:             SELECT cursor_4c_Dados
751:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
752:         ENDIF
753: 
754:         IF EMPTY(loc_cCodigo)
755:             MsgAviso("Selecione um registro na lista.", "Visualizar")
756:             RETURN
757:         ENDIF
758: 
759:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
760:             THIS.BOParaForm()
761:             THIS.this_cModoAtual = "VISUALIZAR"
762:             THIS.HabilitarCampos(.F.)
763:             THIS.AjustarBotoesPorModo()
764:             THIS.pgf_4c_Paginas.ActivePage = 2
765:         ELSE

*-- Linhas 775 a 793:
775:         loc_cCodigo = ""
776: 
777:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
778:             SELECT cursor_4c_Dados
779:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
780:         ENDIF
781: 
782:         IF EMPTY(loc_cCodigo)
783:             MsgAviso("Selecione um registro na lista.", "Alterar")
784:             RETURN
785:         ENDIF
786: 
787:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
788:             THIS.this_oBusinessObject.EditarRegistro()
789:             THIS.BOParaForm()
790:             THIS.this_cModoAtual = "ALTERAR"
791:             THIS.HabilitarCampos(.T.)
792:             THIS.AjustarBotoesPorModo()
793:             THIS.pgf_4c_Paginas.ActivePage = 2

*-- Linhas 805 a 823:
805:         loc_lConfirma = .F.
806: 
807:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
808:             SELECT cursor_4c_Dados
809:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
810:         ENDIF
811: 
812:         IF EMPTY(loc_cCodigo)
813:             MsgAviso("Selecione um registro na lista.", "Excluir")
814:             RETURN
815:         ENDIF
816: 
817:         loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro " + ;
818:                                     CHR(34) + loc_cCodigo + CHR(34) + "?", ;
819:                                     "Confirmar Exclus" + CHR(227) + "o")
820:         IF !loc_lConfirma
821:             RETURN
822:         ENDIF
823: 

*-- Linhas 1057 a 1086:
1057:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1058:                     *-- Registro exato encontrado, usa direto
1059:                     IF USED("cursor_4c_BuscaDiretor")
1060:                         SELECT cursor_4c_BuscaDiretor
1061:                         loc_oPg2.txt_4c_Diretores.Value = ALLTRIM(cursor_4c_BuscaDiretor.Usuarios)
1062:                     ENDIF
1063:                 ELSE
1064:                     IF !loc_oBusca.this_lAchouRegistro
1065:                     *-- Nao encontrou exato, mostrar grid para selecao
1066:                     loc_oBusca.mAddColuna("Usuarios", "", "Diretor")
1067:                     loc_oBusca.mAddColuna("NComps",   "", "Nome")
1068:                     loc_oBusca.Show()
1069: 
1070:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDiretor")
1071:                         SELECT cursor_4c_BuscaDiretor
1072:                         loc_oPg2.txt_4c_Diretores.Value = ALLTRIM(cursor_4c_BuscaDiretor.Usuarios)
1073:                     ENDIF
1074:                     ENDIF
1075:                 ENDIF
1076: 
1077:                 loc_oBusca.Release()
1078:             ENDIF
1079: 
1080:         CATCH TO loException
1081:             MostrarErro("Erro no lookup de Diretor:" + CHR(13) + loException.Message, "Erro")
1082:         ENDTRY
1083: 
1084:         IF USED("cursor_4c_BuscaDiretor")
1085:             USE IN cursor_4c_BuscaDiretor
1086:         ENDIF


### BO (C:\4c\projeto\app\classes\DepartamentoBO.prg):
*==============================================================================
* DepartamentoBO.prg - Business Object para Cadastro de Departamentos
* Tabela: SigCdDpt
* Herda de: BusinessBase
*==============================================================================
DEFINE CLASS DepartamentoBO AS BusinessBase

    *-- Propriedades da tabela SigCdDpt
    this_cCodigo    = ""    && codigos   char(10)
    this_cDescricao = ""    && descricaos char(40)
    this_cDiretor   = ""    && diretors  char(10)
    this_nChkSubs   = 0     && nchksubs  numeric(1,0) - Obriga Subclas. Encerramento
    this_nChkTipos  = 0     && nchktipos numeric(1,0) - Tipo
    this_nAutos     = 0     && autos     numeric(1,0) - Automatico

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO configurando tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdDpt"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros na tabela SigCdDpt
    * par_cFiltro: filtro adicional WHERE (opcional)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_cFiltro) != "C"
            par_cFiltro = ""
        ENDIF

        TRY
            loc_cSQL = "SELECT codigos, Descricaos, Diretors, nChkSubs, nChkTipos, autos" + ;
                       " FROM SigCdDpt"
            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY codigos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar departamentos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pelo codigo
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, Descricaos, Diretors, nChkSubs, nChkTipos, autos" + ;
                       " FROM SigCdDpt" + ;
                       " WHERE codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Departamento n" + CHR(227) + "o encontrado!", "Busca")
                ENDIF
                USE IN cursor_4c_Carrega
            ELSE
                MsgErro("Erro ao carregar departamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo    = TratarNulo(codigos,    "C")
            THIS.this_cDescricao = TratarNulo(Descricaos, "C")
            THIS.this_cDiretor   = TratarNulo(Diretors,   "C")
            THIS.this_nChkSubs   = TratarNulo(nChkSubs,   "N")
            THIS.this_nChkTipos  = TratarNulo(nChkTipos,  "N")
            THIS.this_nAutos     = TratarNulo(autos,       "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigCdDpt
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_cSQLCheck, loc_nResultado, loc_lSucesso, loc_nExiste, loc_lAbortou
        loc_lSucesso = .F.
        loc_lAbortou = .F.

        TRY
            *-- Verificar se codigo ja existe
            loc_cSQLCheck = "SELECT COUNT(*) AS nExiste FROM SigCdDpt WHERE codigos = " + ;
                            EscaparSQL(ALLTRIM(THIS.this_cCodigo))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQLCheck, "cursor_4c_ChkCod")
            IF loc_nResultado >= 0
                SELECT cursor_4c_ChkCod
                loc_nExiste = cursor_4c_ChkCod.nExiste
                USE IN cursor_4c_ChkCod
                IF loc_nExiste > 0
                    MsgAviso("C" + CHR(243) + "digo do Departamento j" + CHR(225) + " Cadastrado!", "Aviso")
                    loc_lAbortou = .T.
                ENDIF
            ENDIF

            *-- Se autos=1, verificar se ja existe outro registro automatico
            IF !loc_lAbortou AND THIS.this_nAutos = 1
                loc_cSQLCheck = "SELECT COUNT(*) AS nExiste FROM SigCdDpt" + ;
                                " WHERE autos = 1 AND codigos <> " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQLCheck, "cursor_4c_ChkAuto")
                IF loc_nResultado >= 0
                    SELECT cursor_4c_ChkAuto
                    loc_nExiste = cursor_4c_ChkAuto.nExiste
                    USE IN cursor_4c_ChkAuto
                    IF loc_nExiste > 0
                        MsgAviso("J" + CHR(225) + " existe registro com c" + CHR(243) + "digo autom" + CHR(225) + "tico!", "Aviso")
                        loc_lAbortou = .T.
                    ENDIF
                ENDIF
            ENDIF

            IF !loc_lAbortou
                loc_cSQL = "INSERT INTO SigCdDpt (codigos, Descricaos, Diretors, nChkSubs, nChkTipos, autos)" + ;
                           " VALUES (" + ;
                           EscaparSQL(ALLTRIM(THIS.this_cCodigo))    + ", " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cDescricao)) + ", " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cDiretor))   + ", " + ;
                           FormatarNumeroSQL(THIS.this_nChkSubs)     + ", " + ;
                           FormatarNumeroSQL(THIS.this_nChkTipos)    + ", " + ;
                           FormatarNumeroSQL(THIS.this_nAutos)       + ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inserir departamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigCdDpt
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_cSQLCheck, loc_nResultado, loc_lSucesso, loc_nExiste, loc_lAbortou
        loc_lSucesso = .F.
        loc_lAbortou = .F.

        TRY
            *-- Se autos=1, verificar se ja existe outro registro automatico
            IF THIS.this_nAutos = 1
                loc_cSQLCheck = "SELECT COUNT(*) AS nExiste FROM SigCdDpt" + ;
                                " WHERE autos = 1 AND codigos <> " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQLCheck, "cursor_4c_ChkAuto")
                IF loc_nResultado >= 0
                    SELECT cursor_4c_ChkAuto
                    loc_nExiste = cursor_4c_ChkAuto.nExiste
                    USE IN cursor_4c_ChkAuto
                    IF loc_nExiste > 0
                        MsgAviso("J" + CHR(225) + " existe registro com c" + CHR(243) + "digo autom" + CHR(225) + "tico!", "Aviso")
                        loc_lAbortou = .T.
                    ENDIF
                ENDIF
            ENDIF

            IF !loc_lAbortou
                loc_cSQL = "UPDATE SigCdDpt SET" + ;
                           " Descricaos = " + EscaparSQL(ALLTRIM(THIS.this_cDescricao)) + "," + ;
                           " Diretors   = " + EscaparSQL(ALLTRIM(THIS.this_cDiretor))   + "," + ;
                           " nChkSubs   = " + FormatarNumeroSQL(THIS.this_nChkSubs)     + "," + ;
                           " nChkTipos  = " + FormatarNumeroSQL(THIS.this_nChkTipos)    + "," + ;
                           " autos      = " + FormatarNumeroSQL(THIS.this_nAutos)       + ;
                           " WHERE codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao atualizar departamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigCdDpt
    * Verifica dependencias em SigCdUsu antes de excluir
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_cSQLCheck, loc_nResultado, loc_lSucesso, loc_nExiste, loc_lAbortou
        loc_lSucesso = .F.
        loc_lAbortou = .F.

        TRY
            *-- Verificar se existem usuarios usando este departamento
            loc_cSQLCheck = "SELECT COUNT(*) AS nExiste FROM SigCdUsu" + ;
                            " WHERE deptos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQLCheck, "cursor_4c_ChkUsu")
            IF loc_nResultado >= 0
                SELECT cursor_4c_ChkUsu
                loc_nExiste = cursor_4c_ChkUsu.nExiste
                USE IN cursor_4c_ChkUsu
                IF loc_nExiste > 0
                    MsgAviso("Existem Usu" + CHR(225) + "rios que utilizam esse Departamento!", "Exclus" + CHR(227) + "o n" + CHR(227) + "o permitida")
                    loc_lAbortou = .T.
                ENDIF
            ENDIF

            IF !loc_lAbortou
                loc_cSQL = "DELETE FROM SigCdDpt WHERE codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao excluir departamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

