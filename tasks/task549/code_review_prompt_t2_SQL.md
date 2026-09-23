# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: USUARIOS

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
  ControlSource = "crSigCdUep.Emps"
  ControlSource = "crSigCdUep.usuarios"
		lcQuery = [Select Usuarios From SigCdUep ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalBus]) < 1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormUep.prg) - TRECHOS RELEVANTES PARA PASS SQL (1216 linhas total):

*-- Linhas 379 a 397:
379:             .HighlightBackColor = RGB(255, 255, 255)
380:             .HighlightForeColor = RGB(15, 41, 104)
381:             .HighlightStyle     = 2
382:             .DeleteMark         = .F.
383:             .RecordMark         = .F.
384:             .RowHeight          = 16
385:             .ScrollBars         = 2
386:             .GridLines          = 3
387:             .Visible            = .T.
388:         ENDWITH
389:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
390: 
391:         THIS.TornarControlesVisiveis(loc_oPagina)
392:     ENDPROC
393: 
394:     *===========================================================================
395:     * ConfigurarPaginaDados - Estrutura base de Page2 (Dados)
396:     * Cabecalho (identico ao da Lista, regra #11) + campos txt_4c_Usuarios/
397:     * txt_4c_Empresa (Fase 5/8). cnt_4c_BotoesAcao ainda SEM botoes

*-- Linhas 596 a 633:
596: 
597:     *===========================================================================
598:     * CarregarLista - Carrega dados no grid da Page1
599:     * OBRIGATORIO: Reconfigura ControlSource e Headers APOS RecordSource (Problema 2/48)
600:     * OBRIGATORIO: GO TOP + Refresh apos popular cursor (CLAUDE.md regra #21a)
601:     *===========================================================================
602:     PROCEDURE CarregarLista()
603:         LOCAL loc_lResultado, loc_oGrid
604:         loc_lResultado = .F.
605: 
606:         TRY
607:             IF !THIS.this_oBusinessObject.Buscar("")
608:                 loc_lResultado = .F.
609:             ELSE
610:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
611: 
612:                 *-- RecordSource FORA do WITH (Problema 36), ANTES de ControlSource
613:                 loc_oGrid.ColumnCount = 2
614:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
615: 
616:                 *-- ControlSource APOS RecordSource (auto-bind seria sobrescrito - Problema 48)
617:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Usuarios"
618:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Emps"
619: 
620:                 loc_oGrid.Column1.Width = 600
621:                 loc_oGrid.Column2.Width = 280
622: 
623:                 *-- Headers APOS RecordSource (OBRIGATORIO - RecordSource reseta captions)
624:                 loc_oGrid.Column1.Header1.Caption = "Usu" + CHR(225) + "rio"
625:                 loc_oGrid.Column2.Header1.Caption = "Empresa"
626: 
627:                 IF USED("cursor_4c_Dados")
628:                     GO TOP IN cursor_4c_Dados
629:                 ENDIF
630: 
631:                 THIS.FormatarGridLista(loc_oGrid)
632:                 loc_oGrid.Refresh()
633:                 loc_lResultado = .T.

*-- Linhas 814 a 832:
814:                 ENDIF
815: 
816:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUsuario")
817:                     SELECT cursor_4c_BuscaUsuario
818:                     loc_cUsuario = ALLTRIM(cursor_4c_BuscaUsuario.Usuarios)
819:                 ENDIF
820: 
821:                 loc_oBusca.Release()
822:             ENDIF
823: 
824:             IF USED("cursor_4c_BuscaUsuario")
825:                 USE IN cursor_4c_BuscaUsuario
826:             ENDIF
827: 
828:             loc_oPagina.txt_4c_Usuarios.Value = loc_cUsuario
829:             THIS.this_cUltimoUsuarioValidado  = loc_cUsuario
830: 
831:         CATCH TO loException
832:             MostrarErro("Erro ao buscar usu" + CHR(225) + "rio:" + CHR(13) + loException.Message, ;

*-- Linhas 896 a 914:
896:                 ENDIF
897: 
898:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpresa")
899:                     SELECT cursor_4c_BuscaEmpresa
900:                     loc_cEmpresa = ALLTRIM(cursor_4c_BuscaEmpresa.Cemps)
901:                 ENDIF
902: 
903:                 loc_oBusca.Release()
904:             ENDIF
905: 
906:             IF USED("cursor_4c_BuscaEmpresa")
907:                 USE IN cursor_4c_BuscaEmpresa
908:             ENDIF
909: 
910:             IF EMPTY(loc_cEmpresa)
911:                 MsgAviso("Empresa Inv" + CHR(225) + "lida!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
912:             ENDIF
913: 
914:             loc_oPagina.txt_4c_Empresa.Value = loc_cEmpresa

*-- Linhas 983 a 1001:
983:         loc_cCodigo = ""
984: 
985:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
986:             SELECT cursor_4c_Dados
987:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cIdChaves)
988:         ENDIF
989: 
990:         IF EMPTY(loc_cCodigo)
991:             MsgAviso("Selecione um registro para visualizar.")
992:         ELSE
993:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
994:                 THIS.this_cModoAtual = "VISUALIZAR"
995:                 THIS.BOParaForm()
996:                 THIS.HabilitarCampos(.F.)
997:                 THIS.AjustarBotoesPorModo()
998:                 THIS.AlternarPagina(2)
999:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus()
1000:             ENDIF
1001:         ENDIF

*-- Linhas 1010 a 1028:
1010:         loc_cCodigo = ""
1011: 
1012:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1013:             SELECT cursor_4c_Dados
1014:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cIdChaves)
1015:         ENDIF
1016: 
1017:         IF EMPTY(loc_cCodigo)
1018:             MsgAviso("Selecione um registro para alterar.")
1019:         ELSE
1020:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1021:                 THIS.this_oBusinessObject.EditarRegistro()
1022:                 THIS.this_cModoAtual = "ALTERAR"
1023:                 THIS.BOParaForm()
1024:                 THIS.HabilitarCampos(.T.)
1025:                 THIS.AjustarBotoesPorModo()
1026:                 THIS.AlternarPagina(2)
1027:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Empresa.SetFocus()
1028:             ENDIF

*-- Linhas 1039 a 1057:
1039:         loc_cUsuario = ""
1040: 
1041:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1042:             SELECT cursor_4c_Dados
1043:             loc_cCodigo  = ALLTRIM(cursor_4c_Dados.cIdChaves)
1044:             loc_cUsuario = ALLTRIM(cursor_4c_Dados.Usuarios)
1045:         ENDIF
1046: 
1047:         IF EMPTY(loc_cCodigo)
1048:             MsgAviso("Selecione um registro para excluir.")
1049:         ELSE
1050:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1051:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do usu" + CHR(225) + "rio [" + ;
1052:                         loc_cUsuario + "]?", "Confirmar Exclus" + CHR(227) + "o")
1053:                     IF THIS.this_oBusinessObject.Excluir()
1054:                         MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
1055:                         THIS.CarregarLista()
1056:                     ENDIF
1057:                 ENDIF

*-- Linhas 1079 a 1129:
1079:                 loc_oBusca.Show()
1080: 
1081:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUep")
1082:                     SELECT cursor_4c_BuscaUep
1083:                     loc_cUsuario = ALLTRIM(cursor_4c_BuscaUep.Usuarios)
1084:                 ENDIF
1085: 
1086:                 loc_oBusca.Release()
1087:             ENDIF
1088: 
1089:             IF USED("cursor_4c_BuscaUep")
1090:                 USE IN cursor_4c_BuscaUep
1091:             ENDIF
1092: 
1093:             IF !EMPTY(loc_cUsuario) AND USED("cursor_4c_Dados")
1094:                 SELECT cursor_4c_Dados
1095:                 LOCATE FOR ALLTRIM(Usuarios) == loc_cUsuario
1096:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
1097:             ENDIF
1098: 
1099:         CATCH TO loException
1100:             MostrarErro("Erro na busca:" + CHR(13) + loException.Message, "FormUep.BtnBuscarClick")
1101:             IF USED("cursor_4c_BuscaUep")
1102:                 USE IN cursor_4c_BuscaUep
1103:             ENDIF
1104:         ENDTRY
1105:     ENDPROC
1106: 
1107:     *===========================================================================
1108:     * BtnSalvarClick - Confirma inclusao/alteracao (Grupo_Salva.Salva no legado)
1109:     * PUBLIC: BINDEVENT requer metodo publico
1110:     *
1111:     * Transcricao literal do legado (CLAUDE.md regra #17 - nao reescrever):
1112:     *   - INCLUIR/ALTERAR: Usuarios e Empresa obrigatorios
1113:     *   - Apenas em INCLUIR: verifica duplicidade de Usuarios em SigCdUep
1114:     *     ANTES de gravar (Select Usuarios From SigCdUep Where Usuarios =
1115:     *     Padr(valor,3) - o PADR(,3) e literal do fonte original)
1116:     *===========================================================================
1117:     PROCEDURE BtnSalvarClick()
1118:         LOCAL loc_oPagina, loc_cUsuarios, loc_cEmpresa, loc_cSQL, loc_nResultado, loc_lProsseguir
1119:         loc_oPagina      = THIS.pgf_4c_Paginas.Page2
1120:         loc_cUsuarios    = ALLTRIM(loc_oPagina.txt_4c_Usuarios.Value)
1121:         loc_cEmpresa     = ALLTRIM(loc_oPagina.txt_4c_Empresa.Value)
1122:         loc_lProsseguir  = .T.
1123: 
1124:         IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1125:             IF EMPTY(loc_cUsuarios)
1126:                 MsgAviso("Usu" + CHR(225) + "rio Inv" + CHR(225) + "lido!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
1127:                 loc_oPagina.txt_4c_Usuarios.SetFocus()
1128:                 loc_lProsseguir = .F.
1129:             ENDIF

*-- Linhas 1140 a 1161:
1140:                         USE IN cursor_4c_VerificaUep
1141:                     ENDIF
1142: 
1143:                     loc_cSQL = "SELECT Usuarios FROM SigCdUep WHERE Usuarios = " + ;
1144:                         EscaparSQL(PADR(loc_cUsuarios, 3))
1145: 
1146:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerificaUep")
1147: 
1148:                     IF loc_nResultado < 0
1149:                         MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o")
1150:                         loc_lProsseguir = .F.
1151:                     ELSE
1152:                         IF USED("cursor_4c_VerificaUep")
1153:                             GO TOP IN cursor_4c_VerificaUep
1154:                             IF !EOF("cursor_4c_VerificaUep")
1155:                                 MsgAviso("Usu" + CHR(225) + "rio J" + CHR(225) + " Cadastrado!!!", ;
1156:                                     "Aten" + CHR(231) + CHR(227) + "o!!!")
1157:                                 loc_oPagina.txt_4c_Usuarios.SetFocus()
1158:                                 loc_lProsseguir = .F.
1159:                             ENDIF
1160:                         ENDIF
1161:                     ENDIF


### BO (C:\4c\projeto\app\classes\UepBO.prg):
*====================================================================
* UepBO.prg
*
* Business Object para Cadastro de Usuarios Fixos Por Empresa
* Tabela: SigCdUep
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS UepBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdUep)
    this_cIdChaves = ""    && cidchaves char(20) - PK (Fortyus)
    this_cUsuarios = ""    && usuarios  char(10) - Codigo do Usuario (FK SigCdUsu.Usuarios)
    this_cEmps     = ""    && emps      char(3)  - Filtro de Empresa

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdUep"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "UepBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cIdChaves)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cIdChaves = TratarNulo(cIdChaves, "C")
                THIS.this_cUsuarios = TratarNulo(Usuarios,  "C")
                THIS.this_cEmps     = TratarNulo(Emps,      "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "UepBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigCdUep
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cIdChaves)
                THIS.this_cIdChaves = fUniqueIds()
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdUep (cIdChaves, Usuarios, Emps)
                VALUES (
                    <<EscaparSQL(THIS.this_cIdChaves)>>,
                    <<EscaparSQL(THIS.this_cUsuarios)>>,
                    <<EscaparSQL(THIS.this_cEmps)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir usu" + CHR(225) + "rio fixo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "UepBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdUep
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdUep
                SET Usuarios = <<EscaparSQL(THIS.this_cUsuarios)>>,
                    Emps     = <<EscaparSQL(THIS.this_cEmps)>>
                WHERE cIdChaves = <<EscaparSQL(THIS.this_cIdChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar usu" + CHR(225) + "rio fixo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "UepBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdUep
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdUep WHERE cIdChaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir usu" + CHR(225) + "rio fixo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "UepBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com cIdChaves, Usuarios, Emps
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (cIdChaves C(20), Usuarios C(10), Emps C(3))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT cIdChaves, Usuarios, Emps FROM SigCdUep"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY Usuarios"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar usu" + CHR(225) + "rios fixos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "UepBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (cIdChaves)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cIdChaves, Usuarios, Emps" + ;
                " FROM SigCdUep WHERE cIdChaves = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Usu" + CHR(225) + "rio fixo n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar usu" + CHR(225) + "rio fixo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "UepBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

