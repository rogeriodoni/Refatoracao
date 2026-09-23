# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: TPTRANS, TPS, RECTRANS, CPROCS

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
  ControlSource = "crSigPrTro.TpTrans"
  ControlSource = "crSigPrTro.Ordems"
  ControlSource = "crSigPrTro.Dbf"
  ControlSource = "crSigPrTro.RecTrans"
  ControlSource = "crSigPrTro.Indice"
  ControlSource = "crSigPrTro.Chave"
  ControlSource = "crSigPrTro.CProcs"
  ControlSource = "crSigPrTro.Tps"
  ControlSource = "crSigPrTro.Obs"
  ControlSource = "crSigPrTro.Comparacao"
  ControlSource = "crSigPrTro.Fotos"
lcQryTron = [Select * From SigPrTro Where TpTrans = '] + ThisForm.TpTrans + [' Order BY RecTrans,Tps,ordems]
Select crSigPrTro
Select crSigPrTro
	lcQuery = [Select * ] + ;
				[From SigPrTro ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalTron') < 1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormTPR.prg) - TRECHOS RELEVANTES PARA PASS SQL (1381 linhas total):

*-- Linhas 47 a 65:
47: *   VISUALIZAR, Cancelar sempre habilitado). Integracao concluida:
48: *   config.prg carrega TPRBO.prg/FormTPR.prg via ADIR() dinamico (sem SET
49: *   PROCEDURE manual); menu.prg tem DEFINE BAR 187 OF popCadastros +
50: *   ON SELECTION + PROCEDURE AbrirFormTPR(). Form completo e integrado.
51: *==============================================================================
52: 
53: DEFINE CLASS FormTPR AS FormBase
54: 
55:     *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width/Caption EXATOS do original)
56:     Height      = 600
57:     Width       = 1000
58:     Caption     = "Subtipos de Transportes"
59:     AutoCenter  = .T.
60:     ShowWindow  = 1
61:     WindowType  = 1
62:     ControlBox  = .F.
63:     TitleBar    = 0
64:     Themes      = .F.
65:     BorderStyle = 2

*-- Linhas 398 a 416:
398:             .HighlightBackColor = RGB(255, 255, 255)
399:             .HighlightForeColor = RGB(15, 41, 104)
400:             .HighlightStyle     = 2
401:             .DeleteMark         = .F.
402:             .RecordMark         = .F.
403:             .RowHeight          = 16
404:             .ScrollBars         = 2
405:             .GridLines          = 3
406:             .Visible            = .T.
407:         ENDWITH
408: 
409:         THIS.TornarControlesVisiveis(loc_oPagina)
410:     ENDPROC
411: 
412:     *===========================================================================
413:     * ConfigurarPaginaDados - Estrutura base de Page2 (Dados)
414:     * Cabecalho completo (regra #11 - faixa nas duas paginas) + container de
415:     * botoes de acao ainda VAZIO (Confirmar/Cancelar entram em fase posterior).
416:     *===========================================================================

*-- Linhas 985 a 1059:
985: 
986:     *===========================================================================
987:     * CarregarLista - Busca subtipos de transporte e popula grd_4c_Lista
988:     * Legado: "Select * From SigPrTro Where TpTrans = ? Order BY RecTrans,Tps,ordems"
989:     * (TPRBO.Buscar cobre a mesma ordenacao; filtro por TpTrans fica para o
990:     * BtnBuscarClick, ja que este form nao restringe a lista a um TpTrans fixo)
991:     *===========================================================================
992:     PROCEDURE CarregarLista()
993:         LOCAL loc_lSucesso, loc_oGrid
994:         loc_lSucesso = .F.
995: 
996:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
997:             IF !USED("cursor_4c_Dados")
998:                 SET NULL ON
999:                 CREATE CURSOR cursor_4c_Dados (cidchaves C(20), tptrans C(6), tps C(1), ;
1000:                     rectrans C(1), dbf C(8), obs C(40), cprocs C(15), indice C(15), ;
1001:                     ordems N(2,0), fotos N(1,0))
1002:                 SET NULL OFF
1003:             ENDIF
1004:             RETURN .T.
1005:         ENDIF
1006: 
1007:         TRY
1008:             IF !THIS.this_oBusinessObject.Buscar("")
1009:                 loc_lSucesso = .F.
1010:             ELSE
1011:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1012: 
1013:                 *-- RecordSource e ColumnCount FORA de WITH (Problema 36); ControlSource
1014:                 *-- e Header1.Caption SEMPRE redefinidos APOS o RecordSource (Problema 48)
1015:                 loc_oGrid.ColumnCount  = 3
1016:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
1017:                 loc_oGrid.ColumnCount  = 7
1018: 
1019:                 WITH loc_oGrid
1020:                     .Column1.ControlSource   = "cursor_4c_Dados.tptrans"
1021:                     .Column1.Width           = 90
1022:                     .Column1.Header1.Caption = "Tipo Transporte"
1023: 
1024:                     .Column2.ControlSource   = "cursor_4c_Dados.tps"
1025:                     .Column2.Width           = 60
1026:                     .Column2.Header1.Caption = "C" + CHR(243) + "digo"
1027: 
1028:                     .Column3.ControlSource   = "cursor_4c_Dados.obs"
1029:                     .Column3.Width           = 260
1030:                     .Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1031: 
1032:                     .Column4.ControlSource   = "cursor_4c_Dados.rectrans"
1033:                     .Column4.Width           = 70
1034:                     .Column4.Header1.Caption = "Tipo (T/R)"
1035: 
1036:                     .Column5.ControlSource   = "cursor_4c_Dados.dbf"
1037:                     .Column5.Width           = 100
1038:                     .Column5.Header1.Caption = "Tabela"
1039: 
1040:                     .Column6.ControlSource   = "cursor_4c_Dados.cprocs"
1041:                     .Column6.Width           = 140
1042:                     .Column6.Header1.Caption = "Processo"
1043: 
1044:                     .Column7.ControlSource   = "cursor_4c_Dados.ordems"
1045:                     .Column7.Width           = 60
1046:                     .Column7.Header1.Caption = "Ordem"
1047: 
1048:                     .Refresh()
1049:                 ENDWITH
1050: 
1051:                 THIS.FormatarGridLista(loc_oGrid)
1052:                 loc_lSucesso = .T.
1053:             ENDIF
1054:         CATCH TO loException
1055:             MostrarErro("Erro ao carregar lista de subtipos de transporte:" + CHR(13) + ;
1056:                 loException.Message, "FormTPR.CarregarLista")
1057:             loc_lSucesso = .F.
1058:         ENDTRY
1059: 

*-- Linhas 1258 a 1276:
1258:             RETURN .F.
1259:         ENDIF
1260: 
1261:         SELECT cursor_4c_Dados
1262:         IF EOF("cursor_4c_Dados")
1263:             MsgAviso("Nenhum subtipo de transporte selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
1264:             RETURN .F.
1265:         ENDIF
1266: 
1267:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cidchaves)
1268: 
1269:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1270:             THIS.BOParaForm()
1271:             THIS.this_cModoAtual = "VISUALIZAR"
1272:             THIS.HabilitarCampos(.F.)
1273:             THIS.AjustarBotoesPorModo()
1274:             THIS.AlternarPagina(2)
1275:         ENDIF
1276:     ENDPROC

*-- Linhas 1286 a 1304:
1286:             RETURN .F.
1287:         ENDIF
1288: 
1289:         SELECT cursor_4c_Dados
1290:         IF EOF("cursor_4c_Dados")
1291:             MsgAviso("Nenhum subtipo de transporte selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
1292:             RETURN .F.
1293:         ENDIF
1294: 
1295:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cidchaves)
1296: 
1297:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1298:             THIS.this_oBusinessObject.EditarRegistro()
1299:             THIS.BOParaForm()
1300:             THIS.this_cModoAtual = "ALTERAR"
1301:             THIS.HabilitarCampos(.T.)
1302:             THIS.AjustarBotoesPorModo()
1303:             THIS.AlternarPagina(2)
1304:         ENDIF

*-- Linhas 1315 a 1333:
1315:             RETURN .F.
1316:         ENDIF
1317: 
1318:         SELECT cursor_4c_Dados
1319:         IF EOF("cursor_4c_Dados")
1320:             MsgAviso("Nenhum subtipo de transporte selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
1321:             RETURN .F.
1322:         ENDIF
1323: 
1324:         loc_cCodigo    = ALLTRIM(cursor_4c_Dados.cidchaves)
1325:         loc_cDescricao = ALLTRIM(cursor_4c_Dados.obs)
1326: 
1327:         loc_lConfirmado = MsgConfirma("Excluir o subtipo de transporte [" + loc_cDescricao + "]?", ;
1328:             "Confirmar Exclus" + CHR(227) + "o")
1329: 
1330:         IF loc_lConfirmado
1331:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1332:                 IF THIS.this_oBusinessObject.Excluir()
1333:                     MsgInfo("Subtipo de transporte exclu" + CHR(237) + "do com sucesso.", "Sucesso")


### BO (C:\4c\projeto\app\classes\TPRBO.prg):
*====================================================================
* TPRBO.prg
*
* Business Object para Cadastro de Subtipos de Transportes
* Tabela: SigPrTro
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS TPRBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigPrTro)
    this_cIdChaves   = ""    && cidchaves char(20) - PK
    this_cTpTrans    = ""    && tptrans   char(6)
    this_cTps        = ""    && tps       char(1)
    this_cRecTrans   = ""    && rectrans  char(1) - T/R
    this_cDbf        = ""    && dbf       char(8)
    this_cObs        = ""    && obs       char(40)
    this_cCProcs     = ""    && cprocs    char(15)
    this_nOrdems     = 0     && ordems    numeric(2,0)
    this_cIndice     = ""    && indice    char(15)
    this_cChave      = ""    && chave     char(40)
    this_cComparacao = ""    && comparacao text
    this_nFotos      = 0     && fotos     numeric(1,0) - 1=Sim/2=Nao

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrTro"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "TPRBO.Init")
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
    * InicializarValoresPadrao - Hook chamado por NovoRegistro
    * NOTA: this_cTpTrans (filtro/grupo de transporte da tela) deve ser
    * atribuido pelo Form APOS chamar NovoRegistro() - equivale ao legado
    * "Replace TpTrans With ThisForm.TpTrans" feito no Grupo_op.Click(Inserir)
    *====================================================================
    PROTECTED PROCEDURE InicializarValoresPadrao()
        THIS.this_cIdChaves   = ""
        THIS.this_cTpTrans    = ""
        THIS.this_cTps        = ""
        THIS.this_cRecTrans   = ""
        THIS.this_cDbf        = ""
        THIS.this_cObs        = ""
        THIS.this_cCProcs     = ""
        THIS.this_nOrdems     = 0
        THIS.this_cIndice     = ""
        THIS.this_cChave      = ""
        THIS.this_cComparacao = ""
        THIS.this_nFotos      = 1   && legado: op_fotos.Value default = 1 (Sim)
    ENDPROC

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
                THIS.this_cIdChaves   = TratarNulo(cidchaves,  "C")
                THIS.this_cTpTrans    = TratarNulo(tptrans,    "C")
                THIS.this_cTps        = TratarNulo(tps,        "C")
                THIS.this_cRecTrans   = TratarNulo(rectrans,   "C")
                THIS.this_cDbf        = TratarNulo(dbf,        "C")
                THIS.this_cObs        = TratarNulo(obs,        "C")
                THIS.this_cCProcs     = TratarNulo(cprocs,     "C")
                THIS.this_nOrdems     = TratarNulo(ordems,     "N")
                THIS.this_cIndice     = TratarNulo(indice,     "C")
                THIS.this_cChave      = TratarNulo(chave,      "C")
                THIS.this_cComparacao = TratarNulo(comparacao, "C")
                THIS.this_nFotos      = TratarNulo(fotos,      "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "TPRBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    * Transcricao literal das validacoes de Pagina.Dados.Grupo_Salva.Salva.Click,
    * getRecTrans.Valid, getCProcs.Valid e getTps.Valid do legado SIGCDTPR
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido, loc_cRecTrans, loc_cCProcs, loc_cTps, loc_cDbf
        loc_lValido   = .T.
        loc_cRecTrans = ALLTRIM(UPPER(NVL(THIS.this_cRecTrans, "")))
        loc_cCProcs   = ALLTRIM(UPPER(NVL(THIS.this_cCProcs, "")))
        loc_cTps      = ALLTRIM(UPPER(NVL(THIS.this_cTps, "")))
        loc_cDbf      = ALLTRIM(NVL(THIS.this_cDbf, ""))

        *-- Obrigatorio Informar a Descricao do Transporte
        IF EMPTY(THIS.this_cObs)
            MsgAviso("Obrigat" + CHR(243) + "rio Informar a Descri" + CHR(231) + CHR(227) + "o do Transporte!!!")
            loc_lValido = .F.
        ENDIF

        *-- Obrigatorio Informar o Codigo do Transporte
        IF loc_lValido AND EMPTY(loc_cTps)
            MsgAviso("Obrigat" + CHR(243) + "rio Informar o C" + CHR(243) + "digo do Transporte!!!")
            loc_lValido = .F.
        ENDIF

        *-- Obrigatorio Informar o Tipo do Transporte
        IF loc_lValido AND EMPTY(loc_cRecTrans)
            MsgAviso("Obrigat" + CHR(243) + "rio Informar o Tipo do Transporte!!!")
            loc_lValido = .F.
        ENDIF

        *-- O Tipo do Transporte Tem Que Ser T ou R
        IF loc_lValido AND !INLIST(loc_cRecTrans, "T", "R")
            MsgAviso("O Tipo do Transporte Tem Que Ser T ou R!!!")
            loc_lValido = .F.
        ENDIF

        *-- Obrigatorio Informar a Tabela do Transporte
        IF loc_lValido AND EMPTY(loc_cDbf)
            MsgAviso("Obrigat" + CHR(243) + "rio Informar a Tabela do Transporte!!!")
            loc_lValido = .F.
        ENDIF

        *-- getCProcs.Valid: lista de processos validos depende do Tipo (T/R)
        IF loc_lValido AND !EMPTY(loc_cCProcs)
            IF loc_cRecTrans = "T"
                IF !INLIST(loc_cCProcs, "COPIA", "PRODUTO", "CLIENTE", "PROETI", ;
                        "TRANSFERE", "SITUACAO", "CHDEVOL", "BALANCO", "CPF", "ETIQUETA", ;
                        "COMPLEMENTO", "COMPLECLI", "EMPCLIENTE", "DATATRANS", "APAGA", ;
                        "SIGMVHST", "SIGMVCCR", "SALDO", "TRANSFEREC", "CADCLIENTES")
                    MsgAviso("Os Processos V" + CHR(225) + "lidos s" + CHR(227) + "o: COPIA, PRODUTO, CLIENTE, PROETI, TRANSFERE, " + CHR(13) + ;
                        "SITUACAO, CHDEVOL, BALANCO, CPF, ETIQUETA, COMPLEMENTO, COMPLECLI, " + ;
                        "EMPCLIENTE,DATATRANS,APAGA,SIGMVHST,SIGMVCCR,SALDO,TRANSFEREC,CADCLIENTES")
                    loc_lValido = .F.
                ENDIF
            ELSE
                IF !INLIST(loc_cCProcs, "INSERIR", "COPIA", "APAGA", "ATUALIZA", "TRANSFERE", ;
                        "BAIXA VALPAGS", "SITUCHDEV", "INTERATIVO", "CURSOR", "COMANDO", ;
                        "ETIQUETA", "EXCLUSIVO", "TRANSF ETQ", "ATUACPF")
                    MsgAviso("Os Processos V" + CHR(225) + "lidos s" + CHR(227) + "o: INSERIR,COPIA,APAGA,ATUALIZA,TRANSFERE,TRANSF ETQ, " + CHR(13) + ;
                        "BAIXA VALPAGS,SITUCHDEV,ETIQUETA,INTERATIVO,EXCLUSIVO,CURSOR,COMANDO ")
                    loc_lValido = .F.
                ENDIF
            ENDIF
        ENDIF

        *-- getCProcs.Valid / getTps.Valid: COMPLEMENTO/COMPLECLI exige codigo LETRA (A-Z)
        IF loc_lValido AND INLIST(loc_cCProcs, "COMPLEMENTO", "COMPLECLI")
            IF EMPTY(loc_cTps) OR ASC(loc_cTps) < 65 OR ASC(loc_cTps) > 90
                MsgAviso("C" + CHR(243) + "digo do Transporte deve ser Letra")
                loc_lValido = .F.
            ENDIF
        ENDIF

        *-- getCProcs.Valid: ATUACPF somente para o arquivo SigCdCli
        IF loc_lValido AND loc_cCProcs = "ATUACPF" AND UPPER(loc_cDbf) != "SIGCDCLI"
            MsgAviso("Tipo AtuaCpf " + CHR(233) + " utilizado somente para o Arquivo SigCdCli !!!")
            loc_lValido = .F.
        ENDIF

        *-- Salva.Click: verifica duplicidade (TpTrans+Tps+RecTrans+CProcs), exceto o proprio registro
        IF loc_lValido
            IF THIS.VerificarDuplicidade(THIS.this_cTpTrans, loc_cTps, loc_cRecTrans, loc_cCProcs, THIS.this_cIdChaves)
                MsgAviso("C" + CHR(243) + "digo do Transporte J" + CHR(225) + " Cadastrado!!!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * VerificarDuplicidade - Verifica se ja existe outro registro com a
    * mesma combinacao TpTrans+Tps+RecTrans+CProcs (Salva.Click - LocalTron)
    *====================================================================
    PROCEDURE VerificarDuplicidade(par_cTpTrans, par_cTps, par_cRecTrans, par_cCProcs, par_cIdChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigPrTro" + ;
                " WHERE tptrans = "  + EscaparSQL(par_cTpTrans) + ;
                " AND tps = "        + EscaparSQL(par_cTps) + ;
                " AND rectrans = "   + EscaparSQL(par_cRecTrans) + ;
                " AND cprocs = "     + EscaparSQL(par_cCProcs) + ;
                " AND cidchaves <> " + EscaparSQL(par_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkTro")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkTro")
                SELECT cursor_4c_ChkTro
                loc_lExiste = (cursor_4c_ChkTro.qtd > 0)
                USE IN cursor_4c_ChkTro
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar duplicidade:" + CHR(13) + loException.Message, "TPRBO.VerificarDuplicidade")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigPrTro
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- cidchaves e a PK fisica da tabela (Legado: "Replace cIdChaves With fUniqueIds()" no Salva.Click/INSERIR)
            THIS.this_cIdChaves = LEFT(fUniqueIds(), 20)

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPrTro (cidchaves, tptrans, tps, rectrans, dbf, obs, cprocs, ordems, indice, chave, comparacao, fotos)
                VALUES (
                    <<EscaparSQL(THIS.this_cIdChaves)>>,
                    <<EscaparSQL(THIS.this_cTpTrans)>>,
                    <<EscaparSQL(THIS.this_cTps)>>,
                    <<EscaparSQL(THIS.this_cRecTrans)>>,
                    <<EscaparSQL(THIS.this_cDbf)>>,
                    <<EscaparSQL(THIS.this_cObs)>>,
                    <<EscaparSQL(THIS.this_cCProcs)>>,
                    <<FormatarNumeroSQL(THIS.this_nOrdems, 0)>>,
                    <<EscaparSQL(THIS.this_cIndice)>>,
                    <<EscaparSQL(THIS.this_cChave)>>,
                    <<EscaparSQL(THIS.this_cComparacao)>>,
                    <<FormatarNumeroSQL(THIS.this_nFotos, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir subtipo de transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "TPRBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigPrTro
    * (tptrans e cidchaves nao sao alterados - Legado nao os reatribui no ALTERAR)
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigPrTro
                SET tps        = <<EscaparSQL(THIS.this_cTps)>>,
                    rectrans   = <<EscaparSQL(THIS.this_cRecTrans)>>,
                    dbf        = <<EscaparSQL(THIS.this_cDbf)>>,
                    obs        = <<EscaparSQL(THIS.this_cObs)>>,
                    cprocs     = <<EscaparSQL(THIS.this_cCProcs)>>,
                    ordems     = <<FormatarNumeroSQL(THIS.this_nOrdems, 0)>>,
                    indice     = <<EscaparSQL(THIS.this_cIndice)>>,
                    chave      = <<EscaparSQL(THIS.this_cChave)>>,
                    comparacao = <<EscaparSQL(THIS.this_cComparacao)>>,
                    fotos      = <<FormatarNumeroSQL(THIS.this_nFotos, 0)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cIdChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar subtipo de transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "TPRBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigPrTro
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrTro WHERE cidchaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir subtipo de transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "TPRBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados (colunas exibidas na Grade da Page1)
    * Legado: "Select * From SigPrTro Where TpTrans = ? Order BY RecTrans,Tps,ordems"
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (cidchaves C(20), tptrans C(6), tps C(1), ;
                        rectrans C(1), dbf C(8), obs C(40), cprocs C(15), indice C(15), ;
                        ordems N(2,0), fotos N(1,0))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT cidchaves, tptrans, tps, rectrans, dbf, obs, cprocs, indice, ordems, fotos" + ;
                    " FROM SigPrTro"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY rectrans, tps, ordems"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar subtipos de transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "TPRBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (cidchaves)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, tptrans, tps, rectrans, dbf, obs, cprocs, ordems, indice, chave, comparacao, fotos" + ;
                " FROM SigPrTro WHERE cidchaves = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Subtipo de Transporte n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar subtipo de transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "TPRBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

