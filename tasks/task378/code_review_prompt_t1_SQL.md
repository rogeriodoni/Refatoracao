# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (7)
- [GRID-SQL] Campo 'Codigos' usado em ControlSource de cursor_4c_Dados mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Descrs' usado em ControlSource de cursor_4c_Dados mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Opers' usado em ControlSource de cursor_4c_Dados mas NAO aparece no SELECT SQL
- [SQL-TABELA] Tabela 'SigMvTtl' usada no BO migrado mas NAO aparece no codigo original. Pode ser tabela inventada/confundida.
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'OCOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPO, CODIGOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCRS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPO, CODIGOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPO, CODIGOS

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
  ControlSource = "crSigOpOco.codigos"
  ControlSource = "crSigOpOco.descrs"
  ControlSource = "crSigOpOco.grupos"
  ControlSource = "crSigOpOco.contas"
  ControlSource = ""
  ControlSource = "crSigOpOco.dcontas"
  ControlSource = "crSigOpOco.contabs"
  ControlSource = "crSigOpOco.notas"
select crSigOpOco
lcSql = [Select TitOpcS, TitOpcN, TitOpcA From SigCdPac]
If ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalParac') < 1
Select LocalParac
select crSigOpOco
Select crSigOpOco
Select crSigOpOco
	SELECT crSigCdGcr
select crSigOpOco
select crSigOpOco
select crSigOpOco

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormCOC.prg) - TRECHOS RELEVANTES PARA PASS SQL (1491 linhas total):

*-- Linhas 357 a 375:
357:             .HighlightBackColor = RGB(255, 255, 255)
358:             .HighlightForeColor = RGB(15, 41, 104)
359:             .HighlightStyle     = 2
360:             .DeleteMark         = .F.
361:             .RecordMark         = .F.
362:             .RowHeight          = 16
363:             .ScrollBars         = 2
364:             .GridLines          = 3
365:             .Visible            = .T.
366:             .Column1.Width            = 80
367:             .Column2.Width            = 600
368:             .Column3.Width            = 80
369:             .Column1.Header1.FontBold = .T.
370:             .Column2.Header1.FontBold = .T.
371:             .Column3.Header1.FontBold = .T.
372:         ENDWITH
373: 
374:         THIS.TornarControlesVisiveis(loc_oPagina)
375:     ENDPROC

*-- Linhas 831 a 856:
831: 
832:         TRY
833:             IF THIS.this_oBusinessObject.Buscar(THIS.this_cFiltroAtual)
834:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
835:                 loc_oGrid.ColumnCount = 3
836:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
837:                 loc_oGrid.ColumnCount  = 3
838:                 WITH loc_oGrid
839:                     .Column1.ControlSource    = "cursor_4c_Dados.Codigos"
840:                     .Column2.ControlSource    = "cursor_4c_Dados.Descrs"
841:                     .Column3.ControlSource    = "cursor_4c_Dados.Opers"
842:                     .Column1.Width            = 80
843:                     .Column2.Width            = 600
844:                     .Column3.Width            = 80
845:                     .Column1.Header1.Caption  = "C" + CHR(243) + "digo"
846:                     .Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
847:                     .Column3.Header1.Caption  = "Opera" + CHR(231) + CHR(227) + "o"
848:                     .Column1.Header1.FontBold = .T.
849:                     .Column2.Header1.FontBold = .T.
850:                     .Column3.Header1.FontBold = .T.
851:                 ENDWITH
852:                 THIS.FormatarGridLista(loc_oGrid)
853:                 loc_lSucesso = .T.
854:             ENDIF
855:         CATCH TO loc_oErro
856:             MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 896 a 970:
896:     *--------------------------------------------------------------------------
897:     PROCEDURE BtnVisualizarClick()
898:         LOCAL loc_cCodigo
899:         loc_cCodigo = ""
900: 
901:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
902:             SELECT cursor_4c_Dados
903:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)
904:         ENDIF
905: 
906:         IF EMPTY(loc_cCodigo)
907:             MsgAviso("Selecione um registro na lista.", "Visualizar")
908:             RETURN
909:         ENDIF
910: 
911:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
912:             THIS.this_cModoAtual = "VISUALIZAR"
913:             THIS.BOParaForm()
914:             THIS.HabilitarCampos(.F.)
915:             THIS.AlternarPagina(2)
916:         ENDIF
917:     ENDPROC
918: 
919:     *--------------------------------------------------------------------------
920:     * BtnAlterarClick - Carrega registro selecionado para edicao
921:     *--------------------------------------------------------------------------
922:     PROCEDURE BtnAlterarClick()
923:         LOCAL loc_cCodigo
924:         loc_cCodigo = ""
925: 
926:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
927:             SELECT cursor_4c_Dados
928:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)
929:         ENDIF
930: 
931:         IF EMPTY(loc_cCodigo)
932:             MsgAviso("Selecione um registro na lista.", "Alterar")
933:             RETURN
934:         ENDIF
935: 
936:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
937:             THIS.this_oBusinessObject.EditarRegistro()
938:             THIS.this_cModoAtual = "ALTERAR"
939:             THIS.BOParaForm()
940:             THIS.HabilitarCampos(.T.)
941:             THIS.AlternarPagina(2)
942:         ENDIF
943:     ENDPROC
944: 
945:     *--------------------------------------------------------------------------
946:     * BtnExcluirClick - Exclui registro selecionado apos confirmacao
947:     *--------------------------------------------------------------------------
948:     PROCEDURE BtnExcluirClick()
949:         LOCAL loc_cCodigo, loc_lConfirmou
950:         loc_cCodigo    = ""
951:         loc_lConfirmou = .F.
952: 
953:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
954:             SELECT cursor_4c_Dados
955:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)
956:         ENDIF
957: 
958:         IF EMPTY(loc_cCodigo)
959:             MsgAviso("Selecione um registro na lista.", "Excluir")
960:             RETURN
961:         ENDIF
962: 
963:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
964:             loc_lConfirmou = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro '" + ;
965:                 ALLTRIM(THIS.this_oBusinessObject.this_cCodigos) + " - " + ;
966:                 ALLTRIM(THIS.this_oBusinessObject.this_cDescrs) + "'?", ;
967:                 "Confirmar Exclus" + CHR(227) + "o")
968: 
969:             IF loc_lConfirmou
970:                 IF THIS.this_oBusinessObject.Excluir()

*-- Linhas 988 a 1007:
988:         IF VARTYPE(loc_cBusca) = "C"
989:             loc_cBusca = ALLTRIM(loc_cBusca)
990:             IF !EMPTY(loc_cBusca)
991:                 THIS.this_cFiltroAtual = "(Codigos LIKE " + EscaparSQL("%" + loc_cBusca + "%") + ;
992:                     " OR Descrs LIKE " + EscaparSQL("%" + loc_cBusca + "%") + ")"
993:             ELSE
994:                 THIS.this_cFiltroAtual = ""
995:             ENDIF
996:             THIS.CarregarLista()
997:         ENDIF
998:     ENDPROC
999: 
1000:     *--------------------------------------------------------------------------
1001:     * BtnEncerrarClick - Fecha o formulario
1002:     *--------------------------------------------------------------------------
1003:     PROCEDURE BtnEncerrarClick()
1004:         THIS.Release()
1005:     ENDPROC
1006: 
1007:     *--------------------------------------------------------------------------

*-- Linhas 1119 a 1137:
1119:             ENDIF
1120: 
1121:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
1122:                 SELECT cursor_4c_BuscaGrupo
1123:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value = ;
1124:                     ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
1125:             ENDIF
1126: 
1127:             loc_oBusca.Release()
1128:         ENDIF
1129: 
1130:         IF USED("cursor_4c_BuscaGrupo")
1131:             USE IN cursor_4c_BuscaGrupo
1132:         ENDIF
1133:     ENDPROC
1134: 
1135:     *--------------------------------------------------------------------------
1136:     * TeclaContaC - Trata F4 no campo Conta para abrir lookup
1137:     *--------------------------------------------------------------------------

*-- Linhas 1160 a 1185:
1160:         ENDIF
1161: 
1162:         LOCAL loc_cSQL, loc_nResult
1163:         loc_cSQL = "SELECT TOP 1 Iclis, Rclis FROM SigCdCli" + ;
1164:                    " WHERE Iclis = " + EscaparSQL(loc_cConta)
1165: 
1166:         IF USED("cursor_4c_ChkConta")
1167:             USE IN cursor_4c_ChkConta
1168:         ENDIF
1169: 
1170:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkConta")
1171: 
1172:         IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ChkConta") = 0
1173:             THIS.AbrirBuscaContaC()
1174:         ENDIF
1175: 
1176:         IF USED("cursor_4c_ChkConta")
1177:             USE IN cursor_4c_ChkConta
1178:         ENDIF
1179: 
1180:         THIS.AtualizarHabilitacaoDconta()
1181:     ENDPROC
1182: 
1183:     *--------------------------------------------------------------------------
1184:     * AbrirBuscaContaC - Abre picker FormBuscaAuxiliar para conta credito (SigCdCli)
1185:     *--------------------------------------------------------------------------

*-- Linhas 1206 a 1224:
1206:             ENDIF
1207: 
1208:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaContaC")
1209:                 SELECT cursor_4c_BuscaContaC
1210:                 loc_oPg2.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaContaC.Iclis)
1211:                 THIS.this_cUltimoContas     = ALLTRIM(cursor_4c_BuscaContaC.Iclis)
1212:             ENDIF
1213: 
1214:             loc_oBusca.Release()
1215:         ENDIF
1216: 
1217:         IF USED("cursor_4c_BuscaContaC")
1218:             USE IN cursor_4c_BuscaContaC
1219:         ENDIF
1220: 
1221:         THIS.AtualizarHabilitacaoDconta()
1222:     ENDPROC
1223: 
1224:     *--------------------------------------------------------------------------

*-- Linhas 1247 a 1272:
1247:         ENDIF
1248: 
1249:         LOCAL loc_cSQL, loc_nResult
1250:         loc_cSQL = "SELECT TOP 1 Iclis, Rclis FROM SigCdCli" + ;
1251:                    " WHERE Iclis = " + EscaparSQL(loc_cDConta)
1252: 
1253:         IF USED("cursor_4c_ChkDConta")
1254:             USE IN cursor_4c_ChkDConta
1255:         ENDIF
1256: 
1257:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDConta")
1258: 
1259:         IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ChkDConta") = 0
1260:             THIS.AbrirBuscaDconta()
1261:         ENDIF
1262: 
1263:         IF USED("cursor_4c_ChkDConta")
1264:             USE IN cursor_4c_ChkDConta
1265:         ENDIF
1266:     ENDPROC
1267: 
1268:     *--------------------------------------------------------------------------
1269:     * AbrirBuscaDconta - Abre picker FormBuscaAuxiliar para conta debito (SigCdCli)
1270:     *--------------------------------------------------------------------------
1271:     PROCEDURE AbrirBuscaDconta()
1272:         LOCAL loc_oPg2

*-- Linhas 1291 a 1309:
1291:             ENDIF
1292: 
1293:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDConta")
1294:                 SELECT cursor_4c_BuscaDConta
1295:                 loc_oPg2.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaDConta.Iclis)
1296:                 THIS.this_cUltimoDContas     = ALLTRIM(cursor_4c_BuscaDConta.Iclis)
1297:             ENDIF
1298: 
1299:             loc_oBusca.Release()
1300:         ENDIF
1301: 
1302:         IF USED("cursor_4c_BuscaDConta")
1303:             USE IN cursor_4c_BuscaDConta
1304:         ENDIF
1305:     ENDPROC
1306: 
1307:     *--------------------------------------------------------------------------
1308:     * AtualizarHabilitacaoDconta - Habilita DConta apenas quando Conta esta vazio
1309:     * Replica logica When do campo Get_dconta no legado


### BO (C:\4c\projeto\app\classes\COCBO.prg):
*==============================================================================
* COCBO.prg - Business Object para Ocorrencias de Titulos (COC)
* Tabela: SigOpOco | PK: Codigos
* Schema: Codigos char(10), Descrs char(30), Grupos char, Contas char,
*         DContas char, Opers char(2), Contabs numeric, Notas numeric
*==============================================================================

DEFINE CLASS COCBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento com campos da tabela SigOpOco)
    this_cCodigos  = ""    && Codigos  CHAR(10) - Codigo da Ocorrencia (PK)
    this_cDescrs   = ""    && Descrs   CHAR(30) - Descricao
    this_cGrupos   = ""    && Grupos   CHAR     - Codigo do Grupo (FK->SigCdGcr.Codigos)
    this_cContas   = ""    && Contas   CHAR     - Conta (FK->SigCdCli)
    this_cDContas  = ""    && DContas  CHAR     - Descricao da Conta (D-conta)
    this_cOpers    = ""    && Opers    CHAR(2)  - Tipo de Operacao ("DB"=Debito, "CR"=Credito)
    this_nContabs  = 0     && Contabs  NUMERIC  - Lanca Contabilidade (1=Sim, 2=Nao)
    this_nNotas    = 0     && Notas    NUMERIC  - Opcao SNA (1=Sim, 2=Nao, 3=Ambos)

    *-- Parametros de SigCdPac para captions do OpcaoSNA
    this_cTitOpcS  = "Sim"
    this_cTitOpcN  = "N" + CHR(227) + "o"
    this_cTitOpcA  = "Ambos"

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigOpOco"
        THIS.this_cCampoChave = "Codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigos)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarParametros - Carrega parametros de SigCdPac (captions OpcaoSNA)
    *--------------------------------------------------------------------------
    FUNCTION CarregarParametros()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT TitOpcS, TitOpcN, TitOpcA FROM SigCdPac"

            IF USED("cursor_4c_Params")
                TABLEREVERT(.T., "cursor_4c_Params")
                USE IN cursor_4c_Params
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Params")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Params") > 0
                SELECT cursor_4c_Params
                GO TOP
                THIS.this_cTitOpcS = IIF(!EMPTY(ALLTRIM(TratarNulo(TitOpcS, "C"))), ;
                    ALLTRIM(TratarNulo(TitOpcS, "C")), "Sim")
                THIS.this_cTitOpcN = IIF(!EMPTY(ALLTRIM(TratarNulo(TitOpcN, "C"))), ;
                    ALLTRIM(TratarNulo(TitOpcN, "C")), "N" + CHR(227) + "o")
                THIS.this_cTitOpcA = IIF(!EMPTY(ALLTRIM(TratarNulo(TitOpcA, "C"))), ;
                    ALLTRIM(TratarNulo(TitOpcA, "C")), "Ambos")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "COCBO.CarregarParametros")
        ENDTRY

        IF USED("cursor_4c_Params")
            USE IN cursor_4c_Params
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Retorna todos os registros com filtro opcional
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Codigos, Descrs, Grupos, Contas, DContas," + ;
                       " Opers, Contabs, Notas" + ;
                       " FROM SigOpOco"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + ALLTRIM(par_cFiltro)
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY Codigos"

            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar registros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "COCBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo codigo (PK)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Codigos, Descrs, Grupos, Contas, DContas," + ;
                       " Opers, Contabs, Notas" + ;
                       " FROM SigOpOco" + ;
                       " WHERE Codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))

            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResult < 0
                    MostrarErro("Erro ao carregar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "COCBO.CarregarPorCodigo")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigos = TratarNulo(Codigos, "C")
            THIS.this_cDescrs  = TratarNulo(Descrs,  "C")
            THIS.this_cGrupos  = TratarNulo(Grupos,  "C")
            THIS.this_cContas  = TratarNulo(Contas,  "C")
            THIS.this_cDContas = TratarNulo(DContas, "C")
            THIS.this_cOpers   = TratarNulo(Opers,   "C")
            THIS.this_nContabs = TratarNulo(Contabs, "N")
            THIS.this_nNotas   = TratarNulo(Notas,   "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarGrupo - Valida/busca grupo em SigCdGcr pelo codigo
    *--------------------------------------------------------------------------
    FUNCTION BuscarGrupo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr" + ;
                       " WHERE Codigos = " + EscaparSQL(ALLTRIM(par_cCodigo)) + ;
                       " ORDER BY Codigos"

            IF USED("cursor_4c_BuscaGrupo")
                TABLEREVERT(.T., "cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")

            IF loc_nResult >= 0
                loc_lSucesso = RECCOUNT("cursor_4c_BuscaGrupo") > 0
            ELSE
                MostrarErro("Erro ao buscar grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "COCBO.BuscarGrupo")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarCodigoExiste - Verifica se codigo ja existe na tabela
    *--------------------------------------------------------------------------
    FUNCTION VerificarCodigoExiste(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigOpOco" + ;
                       " WHERE Codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))

            IF USED("cursor_4c_ChkExiste")
                TABLEREVERT(.T., "cursor_4c_ChkExiste")
                USE IN cursor_4c_ChkExiste
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkExiste")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ChkExiste") > 0
                SELECT cursor_4c_ChkExiste
                loc_lExiste = (cursor_4c_ChkExiste.nExiste > 0)
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "COCBO.VerificarCodigoExiste")
        ENDTRY

        IF USED("cursor_4c_ChkExiste")
            USE IN cursor_4c_ChkExiste
        ENDIF

        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigOpOco (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigOpOco" + ;
                       " (Codigos, Descrs, Grupos, Contas, DContas, Opers, Contabs, Notas)" + ;
                       " VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCodigos)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDescrs))  + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cGrupos))  + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cContas))  + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDContas)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cOpers))   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nContabs)   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNotas)     + ;
                       ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "COCBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigOpOco (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigOpOco SET" + ;
                       " Descrs  = " + EscaparSQL(ALLTRIM(THIS.this_cDescrs))  + ", " + ;
                       " Grupos  = " + EscaparSQL(ALLTRIM(THIS.this_cGrupos))  + ", " + ;
                       " Contas  = " + EscaparSQL(ALLTRIM(THIS.this_cContas))  + ", " + ;
                       " DContas = " + EscaparSQL(ALLTRIM(THIS.this_cDContas)) + ", " + ;
                       " Opers   = " + EscaparSQL(ALLTRIM(THIS.this_cOpers))   + ", " + ;
                       " Contabs = " + FormatarNumeroSQL(THIS.this_nContabs)   + ", " + ;
                       " Notas   = " + FormatarNumeroSQL(THIS.this_nNotas)     + ;
                       " WHERE Codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigos))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "COCBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigOpOco (PROTECTED)
    * Verifica integridade referencial antes de excluir
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_nDependentes
        loc_lSucesso = .F.

        TRY
            *-- Verificar se existem movimentos referenciando esta ocorrencia
            loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigMvTtl" + ;
                       " WHERE Ocos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigos))

            IF USED("cursor_4c_ChkDep")
                TABLEREVERT(.T., "cursor_4c_ChkDep")
                USE IN cursor_4c_ChkDep
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDep")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ChkDep") > 0
                SELECT cursor_4c_ChkDep
                loc_nDependentes = cursor_4c_ChkDep.nExiste
            ELSE
                loc_nDependentes = 0
            ENDIF

            IF USED("cursor_4c_ChkDep")
                USE IN cursor_4c_ChkDep
            ENDIF

            IF loc_nDependentes > 0
                MostrarErro("Existem movimentos utilizando esta ocorr" + CHR(234) + "ncia.", ;
                    "Imposs" + CHR(237) + "vel Exclus" + CHR(227) + "o...")
            ELSE
                loc_cSQL = "DELETE FROM SigOpOco" + ;
                           " WHERE Codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigos))

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao excluir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "COCBO.ExecutarExclusao")
            IF USED("cursor_4c_ChkDep")
                USE IN cursor_4c_ChkDep
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

