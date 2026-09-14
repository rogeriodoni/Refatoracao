# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [GRID-SQL] Campo 'Codigos' usado em ControlSource de cursor_4c_Dados mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Descrs' usado em ControlSource de cursor_4c_Dados mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Opers' usado em ControlSource de cursor_4c_Dados mas NAO aparece no SELECT SQL
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCOC.prg) - TRECHOS RELEVANTES PARA PASS SQL (1494 linhas total):

*-- Linhas 361 a 379:
361:             .HighlightBackColor = RGB(255, 255, 255)
362:             .HighlightForeColor = RGB(15, 41, 104)
363:             .HighlightStyle     = 2
364:             .DeleteMark         = .F.
365:             .RecordMark         = .F.
366:             .RowHeight          = 16
367:             .ScrollBars         = 2
368:             .GridLines          = 3
369:             .Visible            = .T.
370:             .Column1.Width            = 80
371:             .Column2.Width            = 600
372:             .Column3.Width            = 80
373:             .Column1.Header1.FontBold = .T.
374:             .Column2.Header1.FontBold = .T.
375:             .Column3.Header1.FontBold = .T.
376:         ENDWITH
377: 
378:         THIS.TornarControlesVisiveis(loc_oPagina)
379:     ENDPROC

*-- Linhas 835 a 860:
835: 
836:         TRY
837:             IF THIS.this_oBusinessObject.Buscar(THIS.this_cFiltroAtual)
838:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
839:                 loc_oGrid.ColumnCount = 3
840:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
841:                 loc_oGrid.ColumnCount  = 3
842:                 WITH loc_oGrid
843:                     .Column1.ControlSource    = "cursor_4c_Dados.Codigos"
844:                     .Column2.ControlSource    = "cursor_4c_Dados.Descrs"
845:                     .Column3.ControlSource    = "cursor_4c_Dados.Opers"
846:                     .Column1.Width            = 80
847:                     .Column2.Width            = 600
848:                     .Column3.Width            = 80
849:                     .Column1.Header1.Caption  = "C" + CHR(243) + "digo"
850:                     .Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
851:                     .Column3.Header1.Caption  = "Opera" + CHR(231) + CHR(227) + "o"
852:                     .Column1.Header1.FontBold = .T.
853:                     .Column2.Header1.FontBold = .T.
854:                     .Column3.Header1.FontBold = .T.
855:                 ENDWITH
856:                 THIS.FormatarGridLista(loc_oGrid)
857:                 loc_lSucesso = .T.
858:             ENDIF
859:         CATCH TO loc_oErro
860:             MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 900 a 974:
900:     *--------------------------------------------------------------------------
901:     PROCEDURE BtnVisualizarClick()
902:         LOCAL loc_cCodigo
903:         loc_cCodigo = ""
904: 
905:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
906:             SELECT cursor_4c_Dados
907:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)
908:         ENDIF
909: 
910:         IF EMPTY(loc_cCodigo)
911:             MsgAviso("Selecione um registro na lista.", "Visualizar")
912:             RETURN
913:         ENDIF
914: 
915:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
916:             THIS.this_cModoAtual = "VISUALIZAR"
917:             THIS.BOParaForm()
918:             THIS.HabilitarCampos(.F.)
919:             THIS.AlternarPagina(2)
920:         ENDIF
921:     ENDPROC
922: 
923:     *--------------------------------------------------------------------------
924:     * BtnAlterarClick - Carrega registro selecionado para edicao
925:     *--------------------------------------------------------------------------
926:     PROCEDURE BtnAlterarClick()
927:         LOCAL loc_cCodigo
928:         loc_cCodigo = ""
929: 
930:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
931:             SELECT cursor_4c_Dados
932:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)
933:         ENDIF
934: 
935:         IF EMPTY(loc_cCodigo)
936:             MsgAviso("Selecione um registro na lista.", "Alterar")
937:             RETURN
938:         ENDIF
939: 
940:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
941:             THIS.this_oBusinessObject.EditarRegistro()
942:             THIS.this_cModoAtual = "ALTERAR"
943:             THIS.BOParaForm()
944:             THIS.HabilitarCampos(.T.)
945:             THIS.AlternarPagina(2)
946:         ENDIF
947:     ENDPROC
948: 
949:     *--------------------------------------------------------------------------
950:     * BtnExcluirClick - Exclui registro selecionado apos confirmacao
951:     *--------------------------------------------------------------------------
952:     PROCEDURE BtnExcluirClick()
953:         LOCAL loc_cCodigo, loc_lConfirmou
954:         loc_cCodigo    = ""
955:         loc_lConfirmou = .F.
956: 
957:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
958:             SELECT cursor_4c_Dados
959:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)
960:         ENDIF
961: 
962:         IF EMPTY(loc_cCodigo)
963:             MsgAviso("Selecione um registro na lista.", "Excluir")
964:             RETURN
965:         ENDIF
966: 
967:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
968:             loc_lConfirmou = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro '" + ;
969:                 ALLTRIM(THIS.this_oBusinessObject.this_cCodigos) + " - " + ;
970:                 ALLTRIM(THIS.this_oBusinessObject.this_cDescrs) + "'?", ;
971:                 "Confirmar Exclus" + CHR(227) + "o")
972: 
973:             IF loc_lConfirmou
974:                 IF THIS.this_oBusinessObject.Excluir()

*-- Linhas 992 a 1010:
992:         IF VARTYPE(loc_cBusca) = "C"
993:             loc_cBusca = ALLTRIM(loc_cBusca)
994:             IF !EMPTY(loc_cBusca)
995:                 THIS.this_cFiltroAtual = "Codigos LIKE " + EscaparSQL("%" + loc_cBusca + "%")
996:             ELSE
997:                 THIS.this_cFiltroAtual = ""
998:             ENDIF
999:             THIS.CarregarLista()
1000:         ENDIF
1001:     ENDPROC
1002: 
1003:     *--------------------------------------------------------------------------
1004:     * BtnEncerrarClick - Fecha o formulario
1005:     *--------------------------------------------------------------------------
1006:     PROCEDURE BtnEncerrarClick()
1007:         THIS.Release()
1008:     ENDPROC
1009: 
1010:     *--------------------------------------------------------------------------

*-- Linhas 1122 a 1140:
1122:             ENDIF
1123: 
1124:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
1125:                 SELECT cursor_4c_BuscaGrupo
1126:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value = ;
1127:                     ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
1128:             ENDIF
1129: 
1130:             loc_oBusca.Release()
1131:         ENDIF
1132: 
1133:         IF USED("cursor_4c_BuscaGrupo")
1134:             USE IN cursor_4c_BuscaGrupo
1135:         ENDIF
1136:     ENDPROC
1137: 
1138:     *--------------------------------------------------------------------------
1139:     * TeclaContaC - Trata F4 no campo Conta para abrir lookup
1140:     *--------------------------------------------------------------------------

*-- Linhas 1163 a 1188:
1163:         ENDIF
1164: 
1165:         LOCAL loc_cSQL, loc_nResult
1166:         loc_cSQL = "SELECT TOP 1 Iclis, Rclis FROM SigCdCli" + ;
1167:                    " WHERE Iclis = " + EscaparSQL(loc_cConta)
1168: 
1169:         IF USED("cursor_4c_ChkConta")
1170:             USE IN cursor_4c_ChkConta
1171:         ENDIF
1172: 
1173:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkConta")
1174: 
1175:         IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ChkConta") = 0
1176:             THIS.AbrirBuscaContaC()
1177:         ENDIF
1178: 
1179:         IF USED("cursor_4c_ChkConta")
1180:             USE IN cursor_4c_ChkConta
1181:         ENDIF
1182: 
1183:         THIS.AtualizarHabilitacaoDconta()
1184:     ENDPROC
1185: 
1186:     *--------------------------------------------------------------------------
1187:     * AbrirBuscaContaC - Abre picker FormBuscaAuxiliar para conta credito (SigCdCli)
1188:     *--------------------------------------------------------------------------

*-- Linhas 1209 a 1227:
1209:             ENDIF
1210: 
1211:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaContaC")
1212:                 SELECT cursor_4c_BuscaContaC
1213:                 loc_oPg2.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaContaC.Iclis)
1214:                 THIS.this_cUltimoContas     = ALLTRIM(cursor_4c_BuscaContaC.Iclis)
1215:             ENDIF
1216: 
1217:             loc_oBusca.Release()
1218:         ENDIF
1219: 
1220:         IF USED("cursor_4c_BuscaContaC")
1221:             USE IN cursor_4c_BuscaContaC
1222:         ENDIF
1223: 
1224:         THIS.AtualizarHabilitacaoDconta()
1225:     ENDPROC
1226: 
1227:     *--------------------------------------------------------------------------

*-- Linhas 1250 a 1275:
1250:         ENDIF
1251: 
1252:         LOCAL loc_cSQL, loc_nResult
1253:         loc_cSQL = "SELECT TOP 1 Iclis, Rclis FROM SigCdCli" + ;
1254:                    " WHERE Iclis = " + EscaparSQL(loc_cDConta)
1255: 
1256:         IF USED("cursor_4c_ChkDConta")
1257:             USE IN cursor_4c_ChkDConta
1258:         ENDIF
1259: 
1260:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDConta")
1261: 
1262:         IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ChkDConta") = 0
1263:             THIS.AbrirBuscaDconta()
1264:         ENDIF
1265: 
1266:         IF USED("cursor_4c_ChkDConta")
1267:             USE IN cursor_4c_ChkDConta
1268:         ENDIF
1269:     ENDPROC
1270: 
1271:     *--------------------------------------------------------------------------
1272:     * AbrirBuscaDconta - Abre picker FormBuscaAuxiliar para conta debito (SigCdCli)
1273:     *--------------------------------------------------------------------------
1274:     PROCEDURE AbrirBuscaDconta()
1275:         LOCAL loc_oPg2

*-- Linhas 1294 a 1312:
1294:             ENDIF
1295: 
1296:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDConta")
1297:                 SELECT cursor_4c_BuscaDConta
1298:                 loc_oPg2.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaDConta.Iclis)
1299:                 THIS.this_cUltimoDContas     = ALLTRIM(cursor_4c_BuscaDConta.Iclis)
1300:             ENDIF
1301: 
1302:             loc_oBusca.Release()
1303:         ENDIF
1304: 
1305:         IF USED("cursor_4c_BuscaDConta")
1306:             USE IN cursor_4c_BuscaDConta
1307:         ENDIF
1308:     ENDPROC
1309: 
1310:     *--------------------------------------------------------------------------
1311:     * AtualizarHabilitacaoDconta - Habilita DConta apenas quando Conta esta vazio
1312:     * Replica logica When do campo Get_dconta no legado


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
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigOpOco" + ;
                       " WHERE Codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigos))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "COCBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

