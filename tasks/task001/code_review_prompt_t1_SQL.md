# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCRICAOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: AUTOS, CODIGOS

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormDepartamento.prg) - TRECHOS RELEVANTES PARA PASS SQL (1200 linhas total):

*-- Linhas 274 a 292:
274:             .GridLines     = 3
275:             .GridLineWidth = 1
276:             .GridColor     = RGB(200, 200, 200)
277:             .DeleteMark    = .F.
278:             .RecordMark    = .F.
279:             .ReadOnly      = .T.
280:             .FontName      = "Tahoma"
281:             .FontSize      = 8
282:             .BackColor     = RGB(255, 255, 255)
283:             .Visible       = .T.
284: 
285:             .Column1.Width           = 80
286:             .Column1.ReadOnly        = .T.
287:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
288: 
289:             .Column2.Width           = 290
290:             .Column2.ReadOnly        = .T.
291:             .Column2.Header1.Caption = "Departamento"
292: 

*-- Linhas 654 a 674:
654:                         LOCAL loc_oGrid
655:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
656:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
657:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
658:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descricaos"
659:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.diretors"
660:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
661:                         loc_oGrid.Column2.Header1.Caption = "Departamento"
662:                         loc_oGrid.Column3.Header1.Caption = "Diretor"
663:                         THIS.FormatarGridLista(loc_oGrid)
664:                         loc_lResultado = .T.
665:                     ENDIF
666:                 ELSE
667:                     loc_lResultado = .T.
668:                 ENDIF
669:             ENDIF
670:         CATCH TO loException
671:             THIS.this_cMensagemErro = "Linha: " + TRANSFORM(loException.LineNo) + " - " + loException.Message
672:             MostrarErro("Erro ao carregar lista:" + CHR(13) + THIS.this_cMensagemErro, "Erro")
673:             loc_lResultado = .F.
674:         ENDTRY

*-- Linhas 759 a 777:
759:         loc_cCodigo = ""
760: 
761:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
762:             SELECT cursor_4c_Dados
763:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
764:         ENDIF
765: 
766:         IF EMPTY(loc_cCodigo)
767:             MostrarErro("Selecione um registro na lista.", "Aten" + CHR(231) + CHR(227) + "o")
768:             RETURN
769:         ENDIF
770: 
771:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
772:             THIS.this_cModoAtual = "VISUALIZAR"
773:             THIS.BOParaForm()
774:             THIS.HabilitarCampos(.F.)
775:             THIS.AjustarBotoesPorModo()
776:             THIS.AlternarPagina(2)
777:         ELSE

*-- Linhas 787 a 805:
787:         loc_cCodigo = ""
788: 
789:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
790:             SELECT cursor_4c_Dados
791:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
792:         ENDIF
793: 
794:         IF EMPTY(loc_cCodigo)
795:             MostrarErro("Selecione um registro na lista.", "Aten" + CHR(231) + CHR(227) + "o")
796:             RETURN
797:         ENDIF
798: 
799:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
800:             THIS.this_oBusinessObject.EditarRegistro()
801:             THIS.this_cModoAtual = "ALTERAR"
802:             THIS.BOParaForm()
803:             THIS.HabilitarCampos(.T.)
804:             THIS.AjustarBotoesPorModo()
805:             THIS.AlternarPagina(2)

*-- Linhas 818 a 836:
818:         loc_lConfirma  = .F.
819: 
820:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
821:             SELECT cursor_4c_Dados
822:             loc_cCodigo    = ALLTRIM(cursor_4c_Dados.codigos)
823:             loc_cDescricao = ALLTRIM(cursor_4c_Dados.descricaos)
824:         ENDIF
825: 
826:         IF EMPTY(loc_cCodigo)
827:             MostrarErro("Selecione um registro na lista.", "Aten" + CHR(231) + CHR(227) + "o")
828:             RETURN
829:         ENDIF
830: 
831:         loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do departamento:" + CHR(13) + ;
832:             loc_cDescricao + " (" + loc_cCodigo + ")?", ;
833:             "Confirmar Exclus" + CHR(227) + "o")
834: 
835:         IF !loc_lConfirma
836:             RETURN

*-- Linhas 867 a 901:
867:                 loc_oBusca.Show()
868: 
869:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDpt")
870:                     SELECT cursor_4c_BuscaDpt
871:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaDpt.codigos)
872:                 ENDIF
873: 
874:                 loc_oBusca.Release()
875:             ENDIF
876: 
877:         CATCH TO loException
878:             MostrarErro("Erro ao abrir busca:" + CHR(13) + loException.Message, "Erro")
879:         ENDTRY
880: 
881:         IF USED("cursor_4c_BuscaDpt")
882:             USE IN cursor_4c_BuscaDpt
883:         ENDIF
884: 
885:         IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
886:             SELECT cursor_4c_Dados
887:             LOCATE FOR ALLTRIM(codigos) = loc_cCodigo
888:             THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
889:         ENDIF
890:     ENDPROC
891: 
892:     *--------------------------------------------------------------------------
893:     * BtnEncerrarClick - Fechar o formulario
894:     *--------------------------------------------------------------------------
895:     PROCEDURE BtnEncerrarClick()
896:         THIS.Release()
897:     ENDPROC
898: 
899:     *--------------------------------------------------------------------------
900:     * HabilitarCampos - Habilita ou desabilita campos de edicao (Page2)
901:     *--------------------------------------------------------------------------

*-- Linhas 1131 a 1154:
1131:         *-- Verificar se usuario existe exatamente em SigCdUsu
1132:         loc_lSucesso = .F.
1133:         TRY
1134:             loc_cSQL = "SELECT Usuarios FROM SigCdUsu WHERE Usuarios = " + ;
1135:                 EscaparSQL(loc_cDiretor) + " AND cAtivos <> 'N'"
1136:             IF USED("cursor_4c_ValidaUsu")
1137:                 USE IN cursor_4c_ValidaUsu
1138:             ENDIF
1139:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaUsu")
1140:             IF loc_nRet > 0 AND !EOF("cursor_4c_ValidaUsu")
1141:                 *-- Encontrado exatamente - ok
1142:                 loc_lSucesso = .T.
1143:             ENDIF
1144:             IF USED("cursor_4c_ValidaUsu")
1145:                 USE IN cursor_4c_ValidaUsu
1146:             ENDIF
1147:         CATCH TO loException
1148:             MostrarErro("Erro ao validar diretor:" + CHR(13) + loException.Message, "Erro")
1149:             IF USED("cursor_4c_ValidaUsu")
1150:                 USE IN cursor_4c_ValidaUsu
1151:             ENDIF
1152:         ENDTRY
1153: 
1154:         IF loc_lSucesso

*-- Linhas 1167 a 1185:
1167:                 loc_oBusca.Show()
1168: 
1169:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUsu")
1170:                     SELECT cursor_4c_BuscaUsu
1171:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Diretores.Value = ALLTRIM(cursor_4c_BuscaUsu.Usuarios)
1172:                     THIS.this_cUltimoDiretorValidado = ALLTRIM(cursor_4c_BuscaUsu.Usuarios)
1173:                 ELSE
1174:                     *-- Usuario pressionou ESC - limpar campo (comportamento legado)
1175:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Diretores.Value = ""
1176:                     THIS.this_cUltimoDiretorValidado = ""
1177:                 ENDIF
1178: 
1179:                 loc_oBusca.Release()
1180:             ENDIF
1181:         CATCH TO loException
1182:             MostrarErro("Erro ao abrir busca de diretores:" + CHR(13) + loException.Message, "Erro")
1183:         ENDTRY
1184: 
1185:         IF USED("cursor_4c_BuscaUsu")


### BO (C:\4c\projeto\app\classes\DepartamentoBO.prg):
*==============================================================================
* DepartamentoBO.prg - Business Object para Cadastro de Departamentos
* Tabela: SigCdDpt
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS DepartamentoBO AS BusinessBase

    *-- Chave primaria
    this_cCodigo     = ""     && codigos C(10)

    *-- Campos descritivos
    this_cDescricao  = ""     && Descricaos C(40)
    this_cDiretor    = ""     && Diretors C(10) - FK SigCdUsu.Usuarios

    *-- Campos numericos (OptionGroups: 1=Sim, 2=Nao)
    this_nChkSubs    = 2      && nChkSubs N - Obriga Subclas. Encerramento
    this_nChkTipos   = 2      && nChkTipos N - Tipo
    this_nAutos      = 2      && autos N - Automatico

    *==========================================================================
    * Init - Configura tabela e campo chave
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdDpt"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna PK para auditoria
    *==========================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDPROC

    *==========================================================================
    * LimparDados - Reseta todas as propriedades
    *==========================================================================
    PROTECTED PROCEDURE LimparDados()
        THIS.this_cCodigo    = ""
        THIS.this_cDescricao = ""
        THIS.this_cDiretor   = ""
        THIS.this_nChkSubs   = 2
        THIS.this_nChkTipos  = 2
        THIS.this_nAutos     = 2
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida campos obrigatorios
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cCodigo))
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo obrigat" + CHR(243) + "rio"
            RETURN .F.
        ENDIF
        IF EMPTY(ALLTRIM(THIS.this_cDescricao))
            THIS.this_cMensagemErro = "Descri" + CHR(231) + CHR(227) + "o obrigat" + CHR(243) + "ria"
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Popula propriedades a partir de cursor
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        SELECT (par_cAliasCursor)
        THIS.this_cCodigo    = ALLTRIM(NVL(codigos,    ""))
        THIS.this_cDescricao = ALLTRIM(NVL(descricaos, ""))
        THIS.this_cDiretor   = ALLTRIM(NVL(diretors,   ""))
        THIS.this_nChkSubs   = NVL(nchksubs,  2)
        THIS.this_nChkTipos  = NVL(nchktipos, 2)
        THIS.this_nAutos     = NVL(autos,     2)
        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro por PK
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lSucesso, loc_nRet, loc_cSQL
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT codigos, descricaos, diretors, nchksubs, nchktipos, autos" + ;
                       " FROM SigCdDpt WHERE codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))
            IF USED("cursor_4c_DptLoad")
                USE IN cursor_4c_DptLoad
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DptLoad")
            IF loc_nRet > 0
                IF !EOF("cursor_4c_DptLoad")
                    THIS.CarregarDoCursor("cursor_4c_DptLoad")
                    THIS.this_lNovoRegistro = .F.
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Departamento n" + CHR(227) + "o encontrado: " + ALLTRIM(par_cCodigo)
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro SQLEXEC ao carregar departamento: " + TRANSFORM(loc_nRet)
            ENDIF
            IF USED("cursor_4c_DptLoad")
                USE IN cursor_4c_DptLoad
            ENDIF
        CATCH TO loEx
            THIS.this_cMensagemErro = "Linha " + TRANSFORM(loEx.LineNo) + ": " + loEx.Message
            IF USED("cursor_4c_DptLoad")
                USE IN cursor_4c_DptLoad
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - Popula cursor_4c_Dados com lista de departamentos
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lSucesso, loc_nRet, loc_cSQL, loc_cWhere
        loc_lSucesso = .F.
        TRY
            IF !USED("cursor_4c_Dados")
                SET NULL ON
                CREATE CURSOR cursor_4c_Dados (codigos C(10), descricaos C(40), diretors C(10))
                SET NULL OFF
            ENDIF

            loc_cWhere = ""
            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE codigos LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                             " OR descricaos LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%")
            ENDIF
            loc_cSQL = "SELECT codigos, descricaos, diretors FROM SigCdDpt" + ;
                       loc_cWhere + " ORDER BY codigos"
            IF USED("cursor_4c_DadosTemp")
                USE IN cursor_4c_DadosTemp
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTemp")
            IF loc_nRet > 0
                IF USED("cursor_4c_Dados")
                    SELECT cursor_4c_Dados
                    ZAP
                    APPEND FROM DBF("cursor_4c_DadosTemp")
                ELSE
                    SET NULL ON
                    SELECT * FROM cursor_4c_DadosTemp INTO CURSOR cursor_4c_Dados READWRITE
                    SET NULL OFF
                ENDIF
                IF USED("cursor_4c_DadosTemp")
                    USE IN cursor_4c_DadosTemp
                ENDIF
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar departamentos"
                IF USED("cursor_4c_DadosTemp")
                    USE IN cursor_4c_DadosTemp
                ENDIF
            ENDIF
        CATCH TO loEx
            THIS.this_cMensagemErro = "Linha " + TRANSFORM(loEx.LineNo) + ": " + loEx.Message
            IF USED("cursor_4c_DadosTemp")
                USE IN cursor_4c_DadosTemp
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - INSERT INTO SigCdDpt
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_nRet, loc_cSQL
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "INSERT INTO SigCdDpt (codigos, descricaos, diretors, nchksubs, nchktipos, autos)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigo) + ", " + ;
                       EscaparSQL(THIS.this_cDescricao) + ", " + ;
                       EscaparSQL(THIS.this_cDiretor) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nChkSubs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nChkTipos) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nAutos) + ")"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("I")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir departamento no banco de dados"
            ENDIF
        CATCH TO loEx
            THIS.this_cMensagemErro = "Linha " + TRANSFORM(loEx.LineNo) + ": " + loEx.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE SigCdDpt
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_nRet, loc_cSQL
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigCdDpt SET " + ;
                       "descricaos = " + EscaparSQL(THIS.this_cDescricao) + ", " + ;
                       "diretors = "   + EscaparSQL(THIS.this_cDiretor) + ", " + ;
                       "nchksubs = "   + FormatarNumeroSQL(THIS.this_nChkSubs) + ", " + ;
                       "nchktipos = "  + FormatarNumeroSQL(THIS.this_nChkTipos) + ", " + ;
                       "autos = "      + FormatarNumeroSQL(THIS.this_nAutos) + ;
                       " WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet >= 0
                THIS.RegistrarAuditoria("A")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar departamento no banco de dados"
            ENDIF
        CATCH TO loEx
            THIS.this_cMensagemErro = "Linha " + TRANSFORM(loEx.LineNo) + ": " + loEx.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - DELETE FROM SigCdDpt
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_nRet, loc_cSQL
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "DELETE FROM SigCdDpt WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("E")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao excluir departamento do banco de dados"
            ENDIF
        CATCH TO loEx
            THIS.this_cMensagemErro = "Linha " + TRANSFORM(loEx.LineNo) + ": " + loEx.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

