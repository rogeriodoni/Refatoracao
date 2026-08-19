# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CSERIFAB, CDATAS, LNMOV, CIMPFABS, CCOOS, CMODELOS, CODIGO
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CSERIFAB, CDATAS, LNMOV, CIMPFABS, CCOOS, CMODELOS, CODIGO

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
  ControlSource = "crSigFiGfd.cdoctos"
  ControlSource = "crSigFiGfd.ccrzs"
  ControlSource = "crSigFiGfd.ccdcs"
  ControlSource = "crSigFiGfd.cgrgs"
  ControlSource = "crSigFiGfd.cgnfs"
  ControlSource = "crSigFiGfd.ccoos"
  ControlSource = "crSigFiGfd.cHoras"
  ControlSource = "crSigFiGfd.cmodelos"
  ControlSource = "crSigFiGfd.tdtData"
  ControlSource = "crSigFiGfd.cserifab"
lcQuery = [select b.cmarcas, a.*, ?lcDatas As tdtData  from SigFiGfd a inner join SigFiMpm b on a.cmodelos = b.cModelos ] + ;
SELECT CRTIPOMOV
		ThisForm.Podatamgr.sqlExecute([Select cModelos From SigFiMpf Where cImpfabs = '] +  fDecriptografar(Thisform.Pagina.Lista.GetSerieFab.Value) + ['], [crTmpFab])
    lcQuery = [Select cCOOs From SigFiGfd Where cSerifab = '] + ThisForm.Pagina.Dados.Get_codigo.Value + [' ] + ;
	Thisform.poDatamgr.SqlExecute(lcQuery, [crTmpLgRFD])
SELECT crSigFiGfd
	lcQuery = [SELECT cMFAdis FROM SigFiMpm WHERE cModelos = '] + crSigFiGfd.cModelos + [']
	Thisform.poDatamgr.sqlExecute(lcquery, [crTmpImpm])
	lcQuery = [SELECT cNumUsuars FROM SigFiMpf WHERE cImpFabs = '] + fDecriptografar(crSigFiGfd.cSeriFab) + [']
	Thisform.poDatamgr.sqlExecute(lcquery, [crTmpImpf])
	SELECT crSigFiGfd
   	Lcquery = [select b.cmarcas,a.cmodelos,a.cimpfabs from SigFiMpf a inner join  SigFiMpm b on a.cmodelos=b.cmodelos]
   	thisform.podatamgr.sqlexecute(lcquery,[crtmpimp])
    SELECT crtmpimp 
    SELECT CRTIPOMOV

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormLGR.prg) - TRECHOS RELEVANTES PARA PASS SQL (1502 linhas total):

*-- Linhas 3 a 21:
3: * Migrado de: SIGCDLGR.SCX (frmcadastro)
4: * Herda de: FormBase
5: * BO: LGRBO
6: * Tabela: SigFiGfd (JOIN SigFiMpm para marca do modelo)
7: *==============================================================================
8: 
9: DEFINE CLASS FormLGR AS FormBase
10: 
11:     *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
12:     Height       = 600
13:     Width        = 1000
14:     Caption      = "Dados Gerenciais Fiscais"
15:     AutoCenter   = .T.
16:     ShowWindow   = 1
17:     WindowType   = 1
18:     ControlBox   = .F.
19:     Closable     = .F.
20:     MaxButton    = .F.
21:     TitleBar     = 0

*-- Linhas 412 a 430:
412:             .HighlightBackColor = RGB(255, 255, 255)
413:             .HighlightForeColor = RGB(15, 41, 104)
414:             .HighlightStyle    = 2
415:             .DeleteMark        = .F.
416:             .RecordMark        = .F.
417:             .RowHeight         = 16
418:             .ScrollBars        = 3
419:             .ReadOnly          = .T.
420:             .Visible           = .T.
421:         ENDWITH
422: 
423:         *-- BINDEVENTs dos botoes CRUD (PUBLIC methods - sem PROTECTED)
424:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
425:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
426:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
427:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
428:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
429:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
430: 

*-- Linhas 851 a 904:
851:                     loc_oGrid.ColumnCount  = 8
852: 
853:                     WITH loc_oGrid
854:                         .Column1.ControlSource    = "cursor_4c_Dados.cserifab"
855:                         .Column1.Width            = 120
856:                         .Column1.Header1.Caption  = "S" + CHR(233) + "rie"
857:                         .Column1.ReadOnly         = .T.
858: 
859:                         .Column2.ControlSource    = "cursor_4c_Dados.cmarcas"
860:                         .Column2.Width            = 120
861:                         .Column2.Header1.Caption  = "Marca"
862:                         .Column2.ReadOnly         = .T.
863: 
864:                         .Column3.ControlSource    = "cursor_4c_Dados.cmodelos"
865:                         .Column3.Width            = 100
866:                         .Column3.Header1.Caption  = "Modelo"
867:                         .Column3.ReadOnly         = .T.
868: 
869:                         .Column4.ControlSource    = "cursor_4c_Dados.ccoos"
870:                         .Column4.Width            = 60
871:                         .Column4.Header1.Caption  = "COO"
872:                         .Column4.ReadOnly         = .T.
873: 
874:                         .Column5.ControlSource    = "cursor_4c_Dados.cdatas"
875:                         .Column5.Width            = 80
876:                         .Column5.Header1.Caption  = "Data"
877:                         .Column5.ReadOnly         = .T.
878: 
879:                         .Column6.ControlSource    = "cursor_4c_Dados.choras"
880:                         .Column6.Width            = 60
881:                         .Column6.Header1.Caption  = "Hora"
882:                         .Column6.ReadOnly         = .T.
883: 
884:                         .Column7.ControlSource    = "cursor_4c_Dados.ctipos"
885:                         .Column7.Width            = 60
886:                         .Column7.Header1.Caption  = "Tipo"
887:                         .Column7.ReadOnly         = .T.
888: 
889:                         .Column8.ControlSource    = "cursor_4c_Dados.cincmans"
890:                         .Column8.Width            = 60
891:                         .Column8.Header1.Caption  = "Inc.Man."
892:                         .Column8.ReadOnly         = .T.
893:                     ENDWITH
894: 
895:                     THIS.FormatarGridLista(loc_oGrid)
896:                     loc_oGrid.Refresh()
897:                     loc_lResultado = .T.
898:                 ENDIF
899:             ENDIF
900:         CATCH TO loc_oErro
901:             MsgErro("Erro em FormLGR.CarregarLista:" + CHR(13) + loc_oErro.Message, "Erro")
902:             loc_lResultado = .F.
903:         ENDTRY
904: 

*-- Linhas 947 a 965:
947:             RETURN
948:         ENDIF
949: 
950:         SELECT cursor_4c_Dados
951:         loc_cIdChaves = ALLTRIM(cidchaves)
952: 
953:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
954:             THIS.this_cModoAtual = "VISUALIZAR"
955:             THIS.BOParaForm()
956:             THIS.HabilitarCampos(.F.)
957:             THIS.AjustarBotoesPorModo()
958:             THIS.AlternarPagina(2)
959:         ENDIF
960:     ENDPROC
961: 
962:     *==========================================================================
963:     * BtnAlterarClick - Carrega registro selecionado para edicao
964:     * Regra do legado: so permite alterar registros com cincmans='M' (manual)
965:     *==========================================================================

*-- Linhas 973 a 991:
973:             RETURN
974:         ENDIF
975: 
976:         SELECT cursor_4c_Dados
977:         loc_cIdChaves = ALLTRIM(cidchaves)
978:         loc_cIncMans  = ALLTRIM(cincmans)
979: 
980:         IF loc_cIncMans <> "M"
981:             MsgAviso("Registro n" + CHR(227) + "o inclu" + CHR(237) + ;
982:                      "do manualmente, n" + CHR(227) + "o pode ser Alterado.", "Aviso")
983:             RETURN
984:         ENDIF
985: 
986:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
987:             THIS.this_oBusinessObject.EditarRegistro()
988:             THIS.this_cModoAtual = "ALTERAR"
989:             THIS.BOParaForm()
990:             THIS.HabilitarCampos(.T.)
991:             THIS.AjustarBotoesPorModo()

*-- Linhas 1006 a 1024:
1006:             RETURN
1007:         ENDIF
1008: 
1009:         SELECT cursor_4c_Dados
1010:         loc_cIdChaves = ALLTRIM(cidchaves)
1011:         loc_cIncMans  = ALLTRIM(cincmans)
1012: 
1013:         IF loc_cIncMans <> "M"
1014:             MsgAviso("Registro n" + CHR(227) + "o inclu" + CHR(237) + ;
1015:                      "do manualmente, n" + CHR(227) + "o pode ser Exclu" + CHR(237) + "do.", "Aviso")
1016:             RETURN
1017:         ENDIF
1018: 
1019:         IF MsgConfirma("Deseja excluir este registro?", "Confirma" + CHR(231) + CHR(227) + "o")
1020:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
1021:                 IF THIS.this_oBusinessObject.Excluir()
1022:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "")
1023:                     THIS.CarregarLista()
1024:                 ENDIF

*-- Linhas 1058 a 1076:
1058:     ENDPROC
1059: 
1060:     *==========================================================================
1061:     * BtnSalvarClick - Valida e salva registro (INSERT ou UPDATE via BO)
1062:     *==========================================================================
1063:     PROCEDURE BtnSalvarClick()
1064:         LOCAL loc_oPg2
1065:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1066: 
1067:         *-- Validacoes de UI antes do TRY (nao usar RETURN dentro de TRY)
1068:         IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Modelo.Value))
1069:             MsgAviso("Modelo n" + CHR(227) + "o pode estar em branco.", "Aviso")
1070:             loc_oPg2.txt_4c_Modelo.SetFocus
1071:             RETURN
1072:         ENDIF
1073: 
1074:         THIS.FormParaBO()
1075: 
1076:         IF THIS.this_oBusinessObject.Salvar()

*-- Linhas 1227 a 1259:
1227:         ENDIF
1228: 
1229:         *-- Buscar serie exata em SigFiMpf
1230:         IF THIS.this_oBusinessObject.BuscarImpressoras("a.cimpfabs = " + EscaparSQL(loc_cSerifab))
1231:             IF USED("cursor_4c_Impressoras") AND RECCOUNT("cursor_4c_Impressoras") = 1
1232:                 SELECT cursor_4c_Impressoras
1233:                 loc_oPg1.txt_4c_SerieFab.Value = ALLTRIM(cimpfabs)
1234:                 USE IN cursor_4c_Impressoras
1235:                 RETURN
1236:             ENDIF
1237:             IF USED("cursor_4c_Impressoras")
1238:                 USE IN cursor_4c_Impressoras
1239:             ENDIF
1240:         ENDIF
1241: 
1242:         *-- Nao encontrou exato: buscar por LIKE e exibir picker
1243:         IF !THIS.this_oBusinessObject.BuscarImpressoras( ;
1244:                 "a.cimpfabs LIKE " + EscaparSQL(loc_cSerifab + "%"))
1245:             THIS.this_oBusinessObject.BuscarImpressoras("")
1246:         ELSE
1247:             IF USED("cursor_4c_Impressoras") AND RECCOUNT("cursor_4c_Impressoras") = 0
1248:                 USE IN cursor_4c_Impressoras
1249:                 THIS.this_oBusinessObject.BuscarImpressoras("")
1250:             ENDIF
1251:         ENDIF
1252: 
1253:         IF USED("cursor_4c_Impressoras")
1254:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1255:             IF VARTYPE(loc_oBusca) = "O"
1256:                 loc_oBusca.DefinirCursor("cursor_4c_Impressoras", "cimpfabs", "cmarcas", ;
1257:                     "S" + CHR(233) + "rie de Fabrica" + CHR(231) + CHR(227) + "o")
1258:                 loc_oBusca.Mostrar()
1259:                 IF !EMPTY(ALLTRIM(loc_oBusca.cCodigoSelecionado))

*-- Linhas 1303 a 1335:
1303:         ENDIF
1304: 
1305:         *-- Buscar modelo exato em SigFiMpm
1306:         IF THIS.this_oBusinessObject.BuscarModelos("cModelos = " + EscaparSQL(loc_cModelo))
1307:             IF USED("cursor_4c_Modelos") AND RECCOUNT("cursor_4c_Modelos") = 1
1308:                 SELECT cursor_4c_Modelos
1309:                 loc_oPg2.txt_4c_Modelo.Value = ALLTRIM(cModelos)
1310:                 USE IN cursor_4c_Modelos
1311:                 RETURN
1312:             ENDIF
1313:             IF USED("cursor_4c_Modelos")
1314:                 USE IN cursor_4c_Modelos
1315:             ENDIF
1316:         ENDIF
1317: 
1318:         *-- Nao encontrou: buscar por LIKE e exibir picker
1319:         IF !THIS.this_oBusinessObject.BuscarModelos( ;
1320:                 "cModelos LIKE " + EscaparSQL(loc_cModelo + "%"))
1321:             THIS.this_oBusinessObject.BuscarModelos("")
1322:         ELSE
1323:             IF USED("cursor_4c_Modelos") AND RECCOUNT("cursor_4c_Modelos") = 0
1324:                 USE IN cursor_4c_Modelos
1325:                 THIS.this_oBusinessObject.BuscarModelos("")
1326:             ENDIF
1327:         ENDIF
1328: 
1329:         IF USED("cursor_4c_Modelos")
1330:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1331:             IF VARTYPE(loc_oBusca) = "O"
1332:                 loc_oBusca.DefinirCursor("cursor_4c_Modelos", "cModelos", "cMarcas", "Modelos")
1333:                 loc_oBusca.Mostrar()
1334:                 IF !EMPTY(ALLTRIM(loc_oBusca.cCodigoSelecionado))
1335:                     loc_oPg2.txt_4c_Modelo.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)


### BO (C:\4c\projeto\app\classes\LGRBO.prg):
*==============================================================================
* LGRBO.prg - Business Object para Livro de Gerenciamento Fiscal (SigFiGfd)
* Herda de: BusinessBase
* Tabela: SigFiGfd
* PK: cidchaves (gerado via SYS(2015)+SYS(2015))
*==============================================================================

DEFINE CLASS LGRBO AS BusinessBase

    *-- Propriedades da classe
    this_cTabela      = "SigFiGfd"
    this_cCampoChave  = "cidchaves"

    *--------------------------------------------------------------------------
    * Propriedades mapeadas da tabela SigFiGfd
    *--------------------------------------------------------------------------
    this_cIdChaves  = ""    && cidchaves char(20) - PK
    this_cSerifab   = ""    && cserifab  char(20) - Serie de Fabricacao (FK SigFiMpf)
    this_cModelos   = ""    && cmodelos  char(20) - Modelo (FK SigFiMpm)
    this_cCoos      = ""    && ccoos     char(6)  - COO
    this_cGnfs      = ""    && cgnfs     char(6)  - Cupom nao Fiscal
    this_cGrgs      = ""    && cgrgs     char(6)  - Relatorios Gerenciais
    this_cCdcs      = ""    && ccdcs     char(4)  - Demonstrativo Credito e Debito
    this_cCrzs      = ""    && ccrzs     char(6)  - Reducao Z
    this_cDoctos    = ""    && cdoctos   char(2)  - Tipo de Documento
    this_cDatas     = ""    && cdatas    char(8)  - Data YYYYMMDD (sem barras)
    this_cHoras     = ""    && choras    char(6)  - Hora HHMMSS
    this_cIncMans   = ""    && cincmans  char(1)  - Flag inclusao manual ('M')
    this_cTipos     = ""    && ctipos    char(3)  - Tipo (ex: 'E16')
    this_cMfs       = ""    && cmfs      char(1)  - Memoria Fiscal
    this_cUsuarios  = ""    && cusuarios char(2)  - Usuario
    this_cCancel    = ""    && ccancel   char(1)  - Flag cancelamento
    this_cDescons   = ""    && cdescons  char(13) - Desconto
    this_cDescrs    = ""    && cdescrs   char(100) - Descricao
    this_cFpagtos   = ""    && cfpagtos  char(14) - Forma de Pagamento
    this_cItems     = ""    && citems    char(4)  - Item
    this_cPros      = ""    && cpros     char(14) - Pro
    this_cQtds      = ""    && cqtds     char(7)  - Quantidade
    this_cTribs     = ""    && ctribs    char(7)  - Tributos
    this_cUnids     = ""    && cunids    char(3)  - Unidade
    this_cValors    = ""    && cvalors   char(14) - Valor
    this_cLocals    = ""    && locals    char(10) - Local
    this_cDocorigs  = ""    && cdocorigs char(10) - Documento de origem
    this_cConcatda  = ""    && concatda  text     - Concatenado
    this_lCopias    = .F.   && copias    bit      - Copias
    this_nNtrans    = 0     && ntrans    numeric(6,0) - Numero transacao
    this_dDatatrans = {}    && datatrans datetime - Data transacao auditoria

    *-- Propriedade auxiliar da juncao (SigFiMpm.cmarcas - apenas para exibicao no grid)
    this_cMarcas    = ""    && cmarcas (vem de SigFiMpm via JOIN)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigFiGfd"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Para o sistema de auditoria do BusinessBase
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cIdChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Lista registros com JOIN SigFiMpm para exibir marca
    * par_cFiltro: filtro WHERE adicional (sem a palavra WHERE)
    * par_cSerifab: serie de fabricacao para filtrar
    * par_dDtini: data inicio do periodo
    * par_dDtfim: data fim do periodo
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cSerifab, par_dDtini, par_dDtfim)
        LOCAL loc_cSQL, loc_cSerifab, loc_cDtini, loc_cDtfim, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSerifab = IIF(VARTYPE(par_cSerifab) = "C", ALLTRIM(par_cSerifab), "")
            loc_cDtini   = IIF(VARTYPE(par_dDtini) = "D" AND !EMPTY(par_dDtini), ;
                               STRTRAN(DTOC(par_dDtini), "/", ""), "")
            loc_cDtfim   = IIF(VARTYPE(par_dDtfim) = "D" AND !EMPTY(par_dDtfim), ;
                               STRTRAN(DTOC(par_dDtfim), "/", ""), "")

            loc_cSQL = "SELECT b.cmarcas, a.cidchaves, a.cserifab, a.cmodelos," + ;
                       " a.ccoos, a.cgnfs, a.cgrgs, a.ccdcs, a.ccrzs, a.cdoctos," + ;
                       " a.cdatas, a.choras, a.cincmans, a.ctipos, a.cmfs," + ;
                       " a.cusuarios, a.ccancel, a.cdescons, a.cdescrs," + ;
                       " a.cfpagtos, a.citems, a.cpros, a.cqtds, a.ctribs," + ;
                       " a.cunids, a.cvalors, a.locals, a.ntrans, a.cdocorigs" + ;
                       " FROM SigFiGfd a" + ;
                       " INNER JOIN SigFiMpm b ON a.cmodelos = b.cModelos"

            IF !EMPTY(loc_cSerifab) OR !EMPTY(loc_cDtini) OR !EMPTY(loc_cDtfim)
                loc_cSQL = loc_cSQL + " WHERE"
                IF !EMPTY(loc_cSerifab)
                    loc_cSQL = loc_cSQL + " a.cserifab = " + EscaparSQL(loc_cSerifab)
                    IF !EMPTY(loc_cDtini) OR !EMPTY(loc_cDtfim)
                        loc_cSQL = loc_cSQL + " AND"
                    ENDIF
                ENDIF
                IF !EMPTY(loc_cDtini) AND !EMPTY(loc_cDtfim)
                    loc_cSQL = loc_cSQL + " a.cdatas BETWEEN " + EscaparSQL(loc_cDtini) + ;
                               " AND " + EscaparSQL(loc_cDtfim)
                ELSE
                    IF !EMPTY(loc_cDtini)
                    loc_cSQL = loc_cSQL + " a.cdatas >= " + EscaparSQL(loc_cDtini)
                ELSE
                    IF !EMPTY(loc_cDtfim)
                    loc_cSQL = loc_cSQL + " a.cdatas <= " + EscaparSQL(loc_cDtfim)
                    ENDIF
                    ENDIF
                ENDIF
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.cdatas, a.ccoos"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar registros: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.Buscar: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pelo cidchaves (PK)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cIdChaves)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cIdChaves) <> "C" OR EMPTY(par_cIdChaves)
                MsgErro("Chave inv" + CHR(225) + "lida para carregamento.", "Erro")
            ELSE
                loc_cSQL = "SELECT b.cmarcas, a.*" + ;
                           " FROM SigFiGfd a" + ;
                           " INNER JOIN SigFiMpm b ON a.cmodelos = b.cModelos" + ;
                           " WHERE a.cidchaves = " + EscaparSQL(ALLTRIM(par_cIdChaves))

                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_Carrega")
                    TABLEREVERT(.T., "cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
                IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgErro("Registro n" + CHR(227) + "o encontrado.", "Aviso")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.CarregarPorCodigo: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Popula propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cIdChaves  = TratarNulo(cidchaves, "C")
            THIS.this_cSerifab   = TratarNulo(cserifab,  "C")
            THIS.this_cModelos   = TratarNulo(cmodelos,  "C")
            THIS.this_cCoos      = TratarNulo(ccoos,     "C")
            THIS.this_cGnfs      = TratarNulo(cgnfs,     "C")
            THIS.this_cGrgs      = TratarNulo(cgrgs,     "C")
            THIS.this_cCdcs      = TratarNulo(ccdcs,     "C")
            THIS.this_cCrzs      = TratarNulo(ccrzs,     "C")
            THIS.this_cDoctos    = TratarNulo(cdoctos,   "C")
            THIS.this_cDatas     = TratarNulo(cdatas,    "C")
            THIS.this_cHoras     = TratarNulo(choras,    "C")
            THIS.this_cIncMans   = TratarNulo(cincmans,  "C")
            THIS.this_cTipos     = TratarNulo(ctipos,    "C")
            THIS.this_cMfs       = TratarNulo(cmfs,      "C")
            THIS.this_cUsuarios  = TratarNulo(cusuarios, "C")
            THIS.this_cCancel    = TratarNulo(ccancel,   "C")
            THIS.this_cDescons   = TratarNulo(cdescons,  "C")
            THIS.this_cDescrs    = TratarNulo(cdescrs,   "C")
            THIS.this_cFpagtos   = TratarNulo(cfpagtos,  "C")
            THIS.this_cItems     = TratarNulo(citems,    "C")
            THIS.this_cPros      = TratarNulo(cpros,     "C")
            THIS.this_cQtds      = TratarNulo(cqtds,     "C")
            THIS.this_cTribs     = TratarNulo(ctribs,    "C")
            THIS.this_cUnids     = TratarNulo(cunids,    "C")
            THIS.this_cValors    = TratarNulo(cvalors,   "C")
            THIS.this_cLocals    = TratarNulo(locals,    "C")
            THIS.this_nNtrans    = TratarNulo(ntrans,    "N")
            THIS.this_cDocorigs  = TratarNulo(cdocorigs, "C")
            THIS.this_lCopias    = (TratarNulo(copias,   "N") <> 0)
            IF TYPE("cmarcas") = "C"
                THIS.this_cMarcas = TratarNulo(cmarcas, "C")
            ENDIF
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigFiGfd
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cNovaChave
        loc_lSucesso = .F.

        TRY
            loc_cNovaChave = SYS(2015) + SYS(2015)
            THIS.this_cIdChaves = loc_cNovaChave

            loc_cSQL = "INSERT INTO SigFiGfd" + ;
                       " (cidchaves, cserifab, cmodelos, ccoos, cgnfs, cgrgs," + ;
                       "  ccdcs, ccrzs, cdoctos, cdatas, choras, cincmans," + ;
                       "  ctipos, cmfs, cusuarios, ccancel, cdescons, cdescrs," + ;
                       "  cfpagtos, citems, cpros, cqtds, ctribs, cunids," + ;
                       "  cvalors, locals, ntrans, cdocorigs, copias)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cIdChaves)  + ", " + ;
                       EscaparSQL(THIS.this_cSerifab)   + ", " + ;
                       EscaparSQL(THIS.this_cModelos)   + ", " + ;
                       EscaparSQL(THIS.this_cCoos)      + ", " + ;
                       EscaparSQL(THIS.this_cGnfs)      + ", " + ;
                       EscaparSQL(THIS.this_cGrgs)      + ", " + ;
                       EscaparSQL(THIS.this_cCdcs)      + ", " + ;
                       EscaparSQL(THIS.this_cCrzs)      + ", " + ;
                       EscaparSQL(THIS.this_cDoctos)    + ", " + ;
                       EscaparSQL(THIS.this_cDatas)     + ", " + ;
                       EscaparSQL(THIS.this_cHoras)     + ", " + ;
                       EscaparSQL(THIS.this_cIncMans)   + ", " + ;
                       EscaparSQL(THIS.this_cTipos)     + ", " + ;
                       EscaparSQL(THIS.this_cMfs)       + ", " + ;
                       EscaparSQL(THIS.this_cUsuarios)  + ", " + ;
                       EscaparSQL(THIS.this_cCancel)    + ", " + ;
                       EscaparSQL(THIS.this_cDescons)   + ", " + ;
                       EscaparSQL(THIS.this_cDescrs)    + ", " + ;
                       EscaparSQL(THIS.this_cFpagtos)   + ", " + ;
                       EscaparSQL(THIS.this_cItems)     + ", " + ;
                       EscaparSQL(THIS.this_cPros)      + ", " + ;
                       EscaparSQL(THIS.this_cQtds)      + ", " + ;
                       EscaparSQL(THIS.this_cTribs)     + ", " + ;
                       EscaparSQL(THIS.this_cUnids)     + ", " + ;
                       EscaparSQL(THIS.this_cValors)    + ", " + ;
                       EscaparSQL(THIS.this_cLocals)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNtrans) + ", " + ;
                       EscaparSQL(THIS.this_cDocorigs)  + ", " + ;
                       IIF(THIS.this_lCopias, "1", "0") + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.Inserir: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigFiGfd
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigFiGfd SET" + ;
                       "  cserifab  = " + EscaparSQL(THIS.this_cSerifab)  + "," + ;
                       "  cmodelos  = " + EscaparSQL(THIS.this_cModelos)  + "," + ;
                       "  ccoos     = " + EscaparSQL(THIS.this_cCoos)     + "," + ;
                       "  cgnfs     = " + EscaparSQL(THIS.this_cGnfs)     + "," + ;
                       "  cgrgs     = " + EscaparSQL(THIS.this_cGrgs)     + "," + ;
                       "  ccdcs     = " + EscaparSQL(THIS.this_cCdcs)     + "," + ;
                       "  ccrzs     = " + EscaparSQL(THIS.this_cCrzs)     + "," + ;
                       "  cdoctos   = " + EscaparSQL(THIS.this_cDoctos)   + "," + ;
                       "  cdatas    = " + EscaparSQL(THIS.this_cDatas)    + "," + ;
                       "  choras    = " + EscaparSQL(THIS.this_cHoras)    + "," + ;
                       "  cincmans  = " + EscaparSQL(THIS.this_cIncMans)  + "," + ;
                       "  ctipos    = " + EscaparSQL(THIS.this_cTipos)    + "," + ;
                       "  cmfs      = " + EscaparSQL(THIS.this_cMfs)      + "," + ;
                       "  cusuarios = " + EscaparSQL(THIS.this_cUsuarios) + "," + ;
                       "  ccancel   = " + EscaparSQL(THIS.this_cCancel)   + "," + ;
                       "  cdescons  = " + EscaparSQL(THIS.this_cDescons)  + "," + ;
                       "  cdescrs   = " + EscaparSQL(THIS.this_cDescrs)   + "," + ;
                       "  cfpagtos  = " + EscaparSQL(THIS.this_cFpagtos)  + "," + ;
                       "  citems    = " + EscaparSQL(THIS.this_cItems)    + "," + ;
                       "  cpros     = " + EscaparSQL(THIS.this_cPros)     + "," + ;
                       "  cqtds     = " + EscaparSQL(THIS.this_cQtds)     + "," + ;
                       "  ctribs    = " + EscaparSQL(THIS.this_cTribs)    + "," + ;
                       "  cunids    = " + EscaparSQL(THIS.this_cUnids)    + "," + ;
                       "  cvalors   = " + EscaparSQL(THIS.this_cValors)   + "," + ;
                       "  locals    = " + EscaparSQL(THIS.this_cLocals)   + "," + ;
                       "  ntrans    = " + FormatarNumeroSQL(THIS.this_nNtrans) + "," + ;
                       "  cdocorigs = " + EscaparSQL(THIS.this_cDocorigs) + "," + ;
                       "  copias    = " + IIF(THIS.this_lCopias, "1", "0") + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.Atualizar: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigFiGfd
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigFiGfd WHERE cidchaves = " + ;
                       EscaparSQL(THIS.this_cIdChaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.ExecutarExclusao: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarAntesDeSalvar - Validacoes de negocio antes do INSERT/UPDATE
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarAntesDeSalvar()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cSerifab)
            MsgErro("S" + CHR(233) + "rie de Fabrica" + CHR(231) + CHR(227) + "o n" + ;
                    CHR(227) + "o pode estar em branco.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_cCoos = "000000"
            MsgErro("COO n" + CHR(227) + "o pode estar em branco.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cGnfs)
            MsgErro("Cupom n" + CHR(227) + "o Fiscal n" + CHR(227) + ;
                    "o pode estar em branco.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cGrgs)
            MsgErro("Relat" + CHR(243) + "rios Gerenciais n" + CHR(227) + ;
                    "o pode estar em branco.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cCdcs)
            MsgErro("Demonstrativo D" + CHR(233) + "bito e Cr" + CHR(233) + "dito n" + ;
                    CHR(227) + "o pode estar em branco.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cCrzs)
            MsgErro("Redu" + CHR(231) + CHR(227) + "o Z n" + CHR(227) + ;
                    "o pode estar em branco.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cDoctos)
            MsgErro("Tipo de Documento n" + CHR(227) + "o pode estar em branco.", ;
                    "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cDatas)
            MsgErro("Data do Movimento n" + CHR(227) + "o pode estar em branco.", ;
                    "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cHoras)
            MsgErro("Hora do Movimento n" + CHR(227) + "o pode estar em branco.", ;
                    "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarCOODuplicado - Verifica se COO ja existe para a serie (INSERT)
    *--------------------------------------------------------------------------
    FUNCTION VerificarCOODuplicado(par_cSerifab, par_cCoos)
        LOCAL loc_cSQL, loc_nResult, loc_lDuplicado
        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT ccoos FROM SigFiGfd" + ;
                       " WHERE cserifab = " + EscaparSQL(ALLTRIM(par_cSerifab)) + ;
                       " AND ccoos = " + EscaparSQL(ALLTRIM(par_cCoos))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_VerCoo")
                TABLEREVERT(.T., "cursor_4c_VerCoo")
                USE IN cursor_4c_VerCoo
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerCoo")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_VerCoo") > 0
                loc_lDuplicado = .T.
            ENDIF

            IF USED("cursor_4c_VerCoo")
                USE IN cursor_4c_VerCoo
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.VerificarCOODuplicado: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lDuplicado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterModeloDaSerie - Busca o modelo associado a uma serie de fabricacao
    * (faz query em SigFiMpf pois cserifab e criptografado)
    *--------------------------------------------------------------------------
    FUNCTION ObterModeloDaSerie(par_cSerifab)
        LOCAL loc_cSQL, loc_nResult, loc_cModelo
        loc_cModelo = ""

        TRY
            loc_cSQL = "SELECT cModelos FROM SigFiMpf WHERE cImpFabs = " + ;
                       EscaparSQL(ALLTRIM(par_cSerifab))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_TmpFab")
                TABLEREVERT(.T., "cursor_4c_TmpFab")
                USE IN cursor_4c_TmpFab
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpFab")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_TmpFab") > 0
                SELECT cursor_4c_TmpFab
                loc_cModelo = ALLTRIM(cModelos)
            ENDIF

            IF USED("cursor_4c_TmpFab")
                USE IN cursor_4c_TmpFab
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.ObterModeloDaSerie: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_cModelo
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterMFAdis - Busca o cMFAdis do modelo (tabela SigFiMpm)
    *--------------------------------------------------------------------------
    FUNCTION ObterMFAdis(par_cModelos)
        LOCAL loc_cSQL, loc_nResult, loc_cMFAdis
        loc_cMFAdis = ""

        TRY
            loc_cSQL = "SELECT cMFAdis FROM SigFiMpm WHERE cModelos = " + ;
                       EscaparSQL(ALLTRIM(par_cModelos))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_TmpMpm")
                TABLEREVERT(.T., "cursor_4c_TmpMpm")
                USE IN cursor_4c_TmpMpm
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMpm")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_TmpMpm") > 0
                SELECT cursor_4c_TmpMpm
                loc_cMFAdis = ALLTRIM(cMFAdis)
            ENDIF

            IF USED("cursor_4c_TmpMpm")
                USE IN cursor_4c_TmpMpm
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.ObterMFAdis: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_cMFAdis
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterNumUsuars - Busca o cNumUsuars de uma serie (tabela SigFiMpf)
    *--------------------------------------------------------------------------
    FUNCTION ObterNumUsuars(par_cSerifabDecriptografada)
        LOCAL loc_cSQL, loc_nResult, loc_cNumUsuars
        loc_cNumUsuars = ""

        TRY
            loc_cSQL = "SELECT cNumUsuars FROM SigFiMpf WHERE cImpFabs = " + ;
                       EscaparSQL(ALLTRIM(par_cSerifabDecriptografada))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_TmpMpf")
                TABLEREVERT(.T., "cursor_4c_TmpMpf")
                USE IN cursor_4c_TmpMpf
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMpf")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_TmpMpf") > 0
                SELECT cursor_4c_TmpMpf
                loc_cNumUsuars = ALLTRIM(cNumUsuars)
            ENDIF

            IF USED("cursor_4c_TmpMpf")
                USE IN cursor_4c_TmpMpf
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.ObterNumUsuars: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_cNumUsuars
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarImpressoras - Busca lista de impressoras (SigFiMpf JOIN SigFiMpm)
    * Retorna cursor cursor_4c_Impressoras com campos: cimpfabs, cmarcas, cmodelos
    *--------------------------------------------------------------------------
    FUNCTION BuscarImpressoras(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT b.cmarcas, a.cmodelos, a.cimpfabs" + ;
                       " FROM SigFiMpf a" + ;
                       " INNER JOIN SigFiMpm b ON a.cmodelos = b.cmodelos"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Impressoras")
                TABLEREVERT(.T., "cursor_4c_Impressoras")
                USE IN cursor_4c_Impressoras
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Impressoras")
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar impressoras: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.BuscarImpressoras: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarModelos - Busca lista de modelos (SigFiMpm)
    * Retorna cursor cursor_4c_Modelos com campos: cModelos, cMarcas
    *--------------------------------------------------------------------------
    FUNCTION BuscarModelos(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cModelos, cMarcas FROM SigFiMpm"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Modelos")
                TABLEREVERT(.T., "cursor_4c_Modelos")
                USE IN cursor_4c_Modelos
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Modelos")
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar modelos: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.BuscarModelos: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

