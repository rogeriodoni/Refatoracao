# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGO
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGO

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
  ControlSource = "crSigCdEve.Codigo"
  ControlSource = "crSigCdEve.Status"
  ControlSource = "crSigCdEve.Nome"
  ControlSource = "crSigCdEve.Evento"
  ControlSource = "crSigCdEve.Conta"
  ControlSource = "crSigCdEve.Grupo"
Select crSigCdGcr
Select crSigCdCli
		lcQuery = [Select Codigo ] + ;
				    [From SigCdEve ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalBus]) < 1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormEVE.prg) - TRECHOS RELEVANTES PARA PASS SQL (1276 linhas total):

*-- Linhas 343 a 361:
343:             .HighlightBackColor = RGB(255, 255, 255)
344:             .HighlightForeColor = RGB(15, 41, 104)
345:             .HighlightStyle     = 2
346:             .DeleteMark         = .F.
347:             .RecordMark         = .F.
348:             .RowHeight          = 16
349:             .ScrollBars         = 2
350:             .GridLines          = 3
351:             .Visible            = .T.
352:             .Column1.Width      = 80
353:             .Column2.Width      = 400
354:             .Column3.Width      = 100
355:             .Column4.Width      = 100
356:         ENDWITH
357: 
358:         THIS.TornarControlesVisiveis(loc_oPg1)
359:     ENDPROC
360: 
361:     *--------------------------------------------------------------------------

*-- Linhas 736 a 763:
736:             IF THIS.this_oBusinessObject.Buscar("")
737:                 loc_oGrid.ColumnCount = 4
738:                 loc_oGrid.RecordSource            = "cursor_4c_Dados"
739:                 loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.Codigo"
740:                 loc_oGrid.Column1.Width           = 80
741:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
742:                 loc_oGrid.Column2.ControlSource   = "cursor_4c_Dados.Nome"
743:                 loc_oGrid.Column2.Width           = 400
744:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
745:                 loc_oGrid.Column3.ControlSource   = "cursor_4c_Dados.Grupo"
746:                 loc_oGrid.Column3.Width           = 100
747:                 loc_oGrid.Column3.Header1.Caption = "Grupo"
748:                 loc_oGrid.Column4.ControlSource   = "cursor_4c_Dados.Conta"
749:                 loc_oGrid.Column4.Width           = 100
750:                 loc_oGrid.Column4.Header1.Caption = "Conta"
751:                 THIS.FormatarGridLista(loc_oGrid)
752:                 loc_lResultado = .T.
753:             ENDIF
754:         CATCH TO loc_oErro
755:             MsgErro(loc_oErro.Message, "FormEVE.CarregarLista")
756:         ENDTRY
757: 
758:         RETURN loc_lResultado
759:     ENDPROC
760: 
761:     *--------------------------------------------------------------------------
762:     * FormatarGridLista - Formata visual do grid da lista
763:     *--------------------------------------------------------------------------

*-- Linhas 793 a 811:
793:             RETURN
794:         ENDIF
795: 
796:         SELECT cursor_4c_Dados
797:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigo)
798: 
799:         IF EMPTY(loc_cCodigo)
800:             MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
801:             RETURN
802:         ENDIF
803: 
804:         TRY
805:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
806:                 THIS.this_cModoAtual = "VISUALIZAR"
807:                 THIS.BOParaForm()
808:                 THIS.HabilitarCampos(.F.)
809:                 THIS.AjustarBotoesPorModo()
810:                 THIS.pgf_4c_Paginas.ActivePage = 2
811:             ENDIF

*-- Linhas 826 a 844:
826:             RETURN
827:         ENDIF
828: 
829:         SELECT cursor_4c_Dados
830:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigo)
831: 
832:         IF EMPTY(loc_cCodigo)
833:             MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
834:             RETURN
835:         ENDIF
836: 
837:         TRY
838:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
839:                 THIS.this_oBusinessObject.EditarRegistro()
840:                 THIS.this_cModoAtual = "ALTERAR"
841:                 THIS.BOParaForm()
842:                 THIS.HabilitarCampos(.T.)
843:                 THIS.AjustarBotoesPorModo()
844:                 THIS.pgf_4c_Paginas.ActivePage = 2

*-- Linhas 862 a 880:
862:             RETURN
863:         ENDIF
864: 
865:         SELECT cursor_4c_Dados
866:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigo)
867:         loc_cNome   = ALLTRIM(cursor_4c_Dados.Nome)
868: 
869:         IF EMPTY(loc_cCodigo)
870:             RETURN
871:         ENDIF
872: 
873:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do evento " + loc_cNome + "?", ;
874:                         "Confirmar Exclus" + CHR(227) + "o")
875:             RETURN
876:         ENDIF
877: 
878:         TRY
879:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
880:                 IF THIS.this_oBusinessObject.Excluir()

*-- Linhas 897 a 935:
897: 
898:         TRY
899:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
900:                 SELECT cursor_4c_Dados
901:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigo)
902:             ENDIF
903: 
904:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
905:                 "SigCdEve", "cursor_4c_BuscaEve", "Codigo", loc_cCodigo, ;
906:                 "Buscar Evento")
907: 
908:             IF VARTYPE(loc_oBusca) = "O"
909:                 IF !loc_oBusca.this_lAchouRegistro
910:                     loc_oBusca.mAddColuna("Codigo", "", "C" + CHR(243) + "digo")
911:                     loc_oBusca.mAddColuna("Nome",   "", "Descri" + CHR(231) + CHR(227) + "o")
912:                     loc_oBusca.mAddColuna("Grupo",  "", "Grupo")
913:                     loc_oBusca.mAddColuna("Conta",  "", "Conta")
914:                     loc_oBusca.Show()
915:                 ENDIF
916: 
917:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEve")
918:                     SELECT cursor_4c_BuscaEve
919:                     loc_cCodigoSel = ALLTRIM(cursor_4c_BuscaEve.Codigo)
920:                     SELECT cursor_4c_Dados
921:                     LOCATE FOR ALLTRIM(Codigo) = loc_cCodigoSel
922:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
923:                 ENDIF
924: 
925:                 loc_oBusca.Release()
926:             ENDIF
927: 
928:             IF USED("cursor_4c_BuscaEve")
929:                 USE IN cursor_4c_BuscaEve
930:             ENDIF
931:         CATCH TO loc_oErro
932:             MsgErro(loc_oErro.Message, "FormEVE.BtnBuscarClick")
933:             IF USED("cursor_4c_BuscaEve")
934:                 USE IN cursor_4c_BuscaEve
935:             ENDIF

*-- Linhas 1130 a 1148:
1130:                 ENDIF
1131: 
1132:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
1133:                     SELECT cursor_4c_BuscaGrupo
1134:                     loc_cGrupoSel                = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
1135:                     loc_oPg2.txt_4c_Grupo.Value  = loc_cGrupoSel
1136:                     loc_oPg2.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
1137:                 ENDIF
1138: 
1139:                 loc_oBusca.Release()
1140:             ENDIF
1141: 
1142:             IF USED("cursor_4c_BuscaGrupo")
1143:                 USE IN cursor_4c_BuscaGrupo
1144:             ENDIF
1145:         CATCH TO loc_oErro
1146:             MsgErro(loc_oErro.Message, "FormEVE.GrupoKeyPress")
1147:             IF USED("cursor_4c_BuscaGrupo")
1148:                 USE IN cursor_4c_BuscaGrupo

*-- Linhas 1206 a 1224:
1206:                 ENDIF
1207: 
1208:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1209:                     SELECT cursor_4c_BuscaConta
1210:                     loc_cContaSel                = ALLTRIM(cursor_4c_BuscaConta.Iclis)
1211:                     loc_oPg2.txt_4c_Conta.Value  = loc_cContaSel
1212:                     loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.Rclis)
1213:                 ENDIF
1214: 
1215:                 loc_oBusca.Release()
1216:             ENDIF
1217: 
1218:             IF USED("cursor_4c_BuscaConta")
1219:                 USE IN cursor_4c_BuscaConta
1220:             ENDIF
1221:         CATCH TO loc_oErro
1222:             MsgErro(loc_oErro.Message, "FormEVE.ContaKeyPress")
1223:             IF USED("cursor_4c_BuscaConta")
1224:                 USE IN cursor_4c_BuscaConta


### BO (C:\4c\projeto\app\classes\EVEBO.prg):
*==============================================================================
* EVEBO.prg - Business Object para Eventos
* Tabela: SigCdEve
* Arquitetura: Camada de Negocio (BusinessBase)
*==============================================================================

DEFINE CLASS EVEBO AS BusinessBase

    *-- Campos da tabela SigCdEve
    this_cCodigo     = ""   && Codigo   char(10)
    this_cNome       = ""   && Nome     char(100)
    this_cEvento     = ""   && Evento   char(100)
    this_cStatus     = ""   && Status   char(50)
    this_cGrupo      = ""   && Grupo    char(10)  (ref SigCdGcr.Codigos)
    this_cConta      = ""   && Conta    char(10)  (ref SigCdCli.Iclis)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdEve"
            THIS.this_cCampoChave = "Codigo"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "EVEBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigo   = TratarNulo(Codigo,   "C")
                THIS.this_cNome     = TratarNulo(Nome,     "C")
                THIS.this_cEvento   = TratarNulo(Evento,   "C")
                THIS.this_cStatus   = TratarNulo(Status,   "C")
                THIS.this_cGrupo    = TratarNulo(Grupo,    "C")
                THIS.this_cConta    = TratarNulo(Conta,    "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "EVEBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cCodigo)
            MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarCodigoExistente(THIS.this_cCodigo)
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " Cadastrado!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cNome)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarCodigoExistente - Verifica se Codigo ja existe no banco
    *--------------------------------------------------------------------------
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdEve" + ;
                " WHERE Codigo = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
                SELECT cursor_4c_ChkCod
                loc_lExiste = (cursor_4c_ChkCod.qtd > 0)
                USE IN cursor_4c_ChkCod
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "EVEBO.VerificarCodigoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigCdEve
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdEve (Codigo, Nome, Evento, Status, Grupo, Conta)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodigo)>>,
                    <<EscaparSQL(THIS.this_cNome)>>,
                    <<EscaparSQL(THIS.this_cEvento)>>,
                    <<EscaparSQL(THIS.this_cStatus)>>,
                    <<EscaparSQL(THIS.this_cGrupo)>>,
                    <<EscaparSQL(THIS.this_cConta)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir evento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "EVEBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigCdEve
    * Nota: Codigo (chave de negocio) nao e alteravel pelo usuario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdEve
                SET Nome   = <<EscaparSQL(THIS.this_cNome)>>,
                    Evento = <<EscaparSQL(THIS.this_cEvento)>>,
                    Status = <<EscaparSQL(THIS.this_cStatus)>>,
                    Grupo  = <<EscaparSQL(THIS.this_cGrupo)>>,
                    Conta  = <<EscaparSQL(THIS.this_cConta)>>
                WHERE Codigo = <<EscaparSQL(THIS.this_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar evento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "EVEBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigCdEve
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdEve WHERE Codigo = " + ;
                EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir evento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "EVEBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com colunas do grid: Codigo, Nome, Grupo, Conta
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (Codigo C(10), Nome C(100), Grupo C(10), Conta C(10))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT Codigo, Nome, Grupo, Conta FROM SigCdEve"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY Codigo"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        SET NULL ON
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        SET NULL OFF
                        IF USED("cursor_4c_DadosTmp")
                            USE IN cursor_4c_DadosTmp
                        ENDIF
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar eventos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar eventos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "EVEBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo Codigo (chave de negocio)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Codigo, Nome, Evento, Status, Grupo, Conta" + ;
                " FROM SigCdEve WHERE Codigo = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Evento n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar evento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "EVEBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterDescricaoGrupo - Obtem descricao do grupo em SigCdGcr
    * Chamado pelo Form em BOParaForm para popular txt_4c_DGrupo
    *--------------------------------------------------------------------------
    PROCEDURE ObterDescricaoGrupo(par_cGrupo)
        LOCAL loc_cSQL, loc_nResultado, loc_cDescricao
        loc_cDescricao = ""

        IF EMPTY(par_cGrupo)
            RETURN loc_cDescricao
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 Descrs FROM SigCdGcr WHERE Codigos = " + ;
                EscaparSQL(par_cGrupo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoDesc")
            IF loc_nResultado >= 0 AND USED("cursor_4c_GrupoDesc")
                SELECT cursor_4c_GrupoDesc
                IF !EOF()
                    loc_cDescricao = TratarNulo(Descrs, "C")
                ENDIF
                USE IN cursor_4c_GrupoDesc
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao obter descri" + CHR(231) + CHR(227) + "o do grupo:" + CHR(13) + loException.Message, "EVEBO.ObterDescricaoGrupo")
        ENDTRY

        RETURN loc_cDescricao
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterDescricaoConta - Obtem descricao da conta em SigCdCli
    * Chamado pelo Form em BOParaForm para popular txt_4c_DConta
    *--------------------------------------------------------------------------
    PROCEDURE ObterDescricaoConta(par_cConta)
        LOCAL loc_cSQL, loc_nResultado, loc_cDescricao
        loc_cDescricao = ""

        IF EMPTY(par_cConta)
            RETURN loc_cDescricao
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 Rclis FROM SigCdCli WHERE Iclis = " + ;
                EscaparSQL(par_cConta)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaDesc")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ContaDesc")
                SELECT cursor_4c_ContaDesc
                IF !EOF()
                    loc_cDescricao = TratarNulo(Rclis, "C")
                ENDIF
                USE IN cursor_4c_ContaDesc
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao obter descri" + CHR(231) + CHR(227) + "o da conta:" + CHR(13) + loException.Message, "EVEBO.ObterDescricaoConta")
        ENDTRY

        RETURN loc_cDescricao
    ENDPROC

ENDDEFINE

