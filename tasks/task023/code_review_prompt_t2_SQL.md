# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CRSIGCDV' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: RCLIS, GRUPOS, DATAS

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
  ControlSource = ""
  ControlSource = ""
SELECT crResu 
	lcQryPar = [Select GrPadVens From SigCdPam]	
	If (.poDataMgr.SqlExecute(lcQryPar, 'crSigCdPam') < 1)
		lcQryCta = [Select iclis,rclis From SigCdCli ] + ;
		If (.poDataMgr.SqlExecute(lcQryCta, 'SigCdCli') < 1)
lcQuery = [Select a.*, b.rclis as descri, c.rclis as repr, ] + ;
	      [From SigCdVis a ] + ;
	      [Inner Join SigCdCli b on a.iclis=b.iclis ] + ;
	      [Inner Join SigCdCli c on a.Contas=c.iclis ] + ;	      
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdVis') < 1)
insert into CsCabecalho (cb_empresa,cb_titulo,cb_periodo);
Select crSigCdVis

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREVIS.prg) - TRECHOS RELEVANTES PARA PASS SQL (1434 linhas total):

*-- Linhas 835 a 853:
835:             ENDIF
836:             loc_cArquivo = PUTFILE("Salvar como...", "SigReVis", "XLS")
837:             IF !EMPTY(loc_cArquivo)
838:                 SELECT (loc_cCursor)
839:                 COPY TO (loc_cArquivo) TYPE XLS
840:                 MsgInfo("Arquivo exportado com sucesso:" + CHR(13) + ;
841:                     loc_cArquivo, "Excel")
842:             ENDIF
843:         CATCH TO loc_oErro
844:             MsgErro(loc_oErro.Message + CHR(13) + ;
845:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
846:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
847:         ENDTRY
848:     ENDPROC
849: 
850:     *--------------------------------------------------------------------------
851:     * BtnSairClick - Fecha o formulario
852:     *--------------------------------------------------------------------------
853:     PROCEDURE BtnSairClick()

*-- Linhas 1000 a 1018:
1000:             "SigCdCli", "cursor_4c_BuscaRepr", "iclis", loc_cValor, ;
1001:             "Sele" + CHR(231) + CHR(227) + "o de Representante", ;
1002:             .F., .T., ;
1003:             "Grupos = " + EscaparSQL(THIS.this_oRelatorio.this_cGrupo))
1004:         IF VARTYPE(loc_oBusca) = "O"
1005:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1006:                 loc_oPg.txt_4c_CdRepr.Value = ALLTRIM(cursor_4c_BuscaRepr.iclis)
1007:                 loc_oPg.txt_4c_DsRepr.Value = ALLTRIM(cursor_4c_BuscaRepr.rclis)
1008:             ELSE
1009:                 IF !loc_oBusca.this_lAchouRegistro
1010:                 loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
1011:                 loc_oBusca.mAddColuna("rclis", "", "Nome")
1012:                 loc_oBusca.Show()
1013:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaRepr")
1014:                     loc_oPg.txt_4c_CdRepr.Value = ALLTRIM(cursor_4c_BuscaRepr.iclis)
1015:                     loc_oPg.txt_4c_DsRepr.Value = ALLTRIM(cursor_4c_BuscaRepr.rclis)
1016:                 ENDIF
1017:                 ENDIF
1018:             ENDIF

*-- Linhas 1035 a 1053:
1035:             "SigCdCli", "cursor_4c_BuscaRepr", "rclis", loc_cValor, ;
1036:             "Sele" + CHR(231) + CHR(227) + "o de Representante", ;
1037:             .F., .T., ;
1038:             "Grupos = " + EscaparSQL(THIS.this_oRelatorio.this_cGrupo))
1039:         IF VARTYPE(loc_oBusca) = "O"
1040:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1041:                 loc_oPg.txt_4c_DsRepr.Value = ALLTRIM(cursor_4c_BuscaRepr.rclis)
1042:                 loc_oPg.txt_4c_CdRepr.Value = ALLTRIM(cursor_4c_BuscaRepr.iclis)
1043:             ELSE
1044:                 IF !loc_oBusca.this_lAchouRegistro
1045:                 loc_oBusca.mAddColuna("rclis", "", "Nome")
1046:                 loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
1047:                 loc_oBusca.Show()
1048:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaRepr")
1049:                     loc_oPg.txt_4c_DsRepr.Value = ALLTRIM(cursor_4c_BuscaRepr.rclis)
1050:                     loc_oPg.txt_4c_CdRepr.Value = ALLTRIM(cursor_4c_BuscaRepr.iclis)
1051:                 ENDIF
1052:                 ENDIF
1053:             ENDIF

*-- Linhas 1070 a 1093:
1070:             loc_oPg.txt_4c_DsRepr.Value = ""
1071:             RETURN
1072:         ENDIF
1073:         loc_cSQL = "SELECT iclis, rclis FROM SigCdCli" + ;
1074:             " WHERE Grupos = " + EscaparSQL(THIS.this_oRelatorio.this_cGrupo) + ;
1075:             " AND iclis = " + EscaparSQL(loc_cValor)
1076:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ReprVal")
1077:         IF loc_nResult > 0
1078:             SELECT cursor_4c_ReprVal
1079:             IF !EOF()
1080:                 loc_oPg.txt_4c_DsRepr.Value = ALLTRIM(cursor_4c_ReprVal.rclis)
1081:             ELSE
1082:                 loc_oPg.txt_4c_DsRepr.Value = ""
1083:                 THIS.AbrirBuscaCdRepr()
1084:             ENDIF
1085:         ELSE
1086:             loc_oPg.txt_4c_DsRepr.Value = ""
1087:             THIS.AbrirBuscaCdRepr()
1088:         ENDIF
1089:         IF USED("cursor_4c_ReprVal")
1090:             USE IN cursor_4c_ReprVal
1091:         ENDIF
1092:         THIS.AtualizarEstadoCamposDescricao()
1093:     ENDPROC

*-- Linhas 1103 a 1126:
1103:             loc_oPg.txt_4c_CdRepr.Value = ""
1104:             RETURN
1105:         ENDIF
1106:         loc_cSQL = "SELECT iclis, rclis FROM SigCdCli" + ;
1107:             " WHERE Grupos = " + EscaparSQL(THIS.this_oRelatorio.this_cGrupo) + ;
1108:             " AND rclis LIKE " + EscaparSQL(loc_cValor + "%")
1109:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ReprVal2")
1110:         IF loc_nResult > 0
1111:             SELECT cursor_4c_ReprVal2
1112:             IF !EOF()
1113:                 loc_oPg.txt_4c_CdRepr.Value = ALLTRIM(cursor_4c_ReprVal2.iclis)
1114:                 loc_oPg.txt_4c_DsRepr.Value = ALLTRIM(cursor_4c_ReprVal2.rclis)
1115:             ELSE
1116:                 THIS.AbrirBuscaDsRepr()
1117:             ENDIF
1118:         ELSE
1119:             THIS.AbrirBuscaDsRepr()
1120:         ENDIF
1121:         IF USED("cursor_4c_ReprVal2")
1122:             USE IN cursor_4c_ReprVal2
1123:         ENDIF
1124:         THIS.AtualizarEstadoCamposDescricao()
1125:     ENDPROC
1126: 

*-- Linhas 1207 a 1229:
1207:             loc_oPg.txt_4c_DsConta.Value = ""
1208:             RETURN
1209:         ENDIF
1210:         loc_cSQL = "SELECT iclis, rclis FROM SigCdCli" + ;
1211:             " WHERE iclis = " + EscaparSQL(loc_cValor)
1212:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaVal")
1213:         IF loc_nResult > 0
1214:             SELECT cursor_4c_ContaVal
1215:             IF !EOF()
1216:                 loc_oPg.txt_4c_DsConta.Value = ALLTRIM(cursor_4c_ContaVal.rclis)
1217:             ELSE
1218:                 loc_oPg.txt_4c_DsConta.Value = ""
1219:                 THIS.AbrirBuscaCdConta()
1220:             ENDIF
1221:         ELSE
1222:             loc_oPg.txt_4c_DsConta.Value = ""
1223:             THIS.AbrirBuscaCdConta()
1224:         ENDIF
1225:         IF USED("cursor_4c_ContaVal")
1226:             USE IN cursor_4c_ContaVal
1227:         ENDIF
1228:         THIS.AtualizarEstadoCamposDescricao()
1229:     ENDPROC

*-- Linhas 1239 a 1261:
1239:             loc_oPg.txt_4c_CdConta.Value = ""
1240:             RETURN
1241:         ENDIF
1242:         loc_cSQL = "SELECT iclis, rclis FROM SigCdCli" + ;
1243:             " WHERE rclis LIKE " + EscaparSQL(loc_cValor + "%")
1244:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaVal2")
1245:         IF loc_nResult > 0
1246:             SELECT cursor_4c_ContaVal2
1247:             IF !EOF()
1248:                 loc_oPg.txt_4c_CdConta.Value = ALLTRIM(cursor_4c_ContaVal2.iclis)
1249:                 loc_oPg.txt_4c_DsConta.Value = ALLTRIM(cursor_4c_ContaVal2.rclis)
1250:             ELSE
1251:                 THIS.AbrirBuscaDsConta()
1252:             ENDIF
1253:         ELSE
1254:             THIS.AbrirBuscaDsConta()
1255:         ENDIF
1256:         IF USED("cursor_4c_ContaVal2")
1257:             USE IN cursor_4c_ContaVal2
1258:         ENDIF
1259:         THIS.AtualizarEstadoCamposDescricao()
1260:     ENDPROC
1261: 


### BO (C:\4c\projeto\app\classes\SIGREVISBO.prg):
*==============================================================================
* SIGREVISBO.PRG
* Business Object para Relatorio de Visitas (SIGREVIS)
* Herda de RelatorioBase
*
* Tabela principal: SigCdVis
* Relatorio FRX: SigReVis.frx
*
* Filtros:
*   - Periodo (data inicial / data final)
*   - Conta   (codigo + descricao - campo iclis/rclis de SigCdCli)
*   - Representante (codigo + descricao - campo iclis/rclis de SigCdCli,
*                    filtrado por Grupos = this_cGrupo)
*   - Opcao Venda  (1=Sim / 2=Nao / 3=Ambos)
*   - Opcao Pedido (1=Sim / 2=Nao / 3=Ambos)
*==============================================================================

DEFINE CLASS SIGREVISBO AS RelatorioBase

    *-- Filtro: periodo
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *-- Filtro: conta (iclis / rclis de SigCdCli)
    this_cCdConta       = ""
    this_cDsConta       = ""

    *-- Filtro: representante (iclis / rclis de SigCdCli, filtrado por Grupos)
    this_cCdRepr        = ""
    this_cDsRepr        = ""

    *-- Filtro: opcoes (1=Sim, 2=Nao, 3=Ambos - espelha Value do OptionGroup original)
    this_nOpcaoVenda    = 3
    this_nOpcaoPedido   = 3

    *-- Grupo padrao do usuario logado (GrPadVens de SigCdPam)
    *   Corresponde a propriedade custom 'antgru' do form legado SIGREVIS
    this_cGrupo         = ""

    *-- .T. quando o representante foi bloqueado automaticamente no Init
    *   (usuario sem permissao ALTCONTA em SIGCDVIS via fChecaAcesso)
    this_lReprBloqueado = .F.

    *-- Nome do cursor de saida populado por PrepararDados()
    this_cCursorDados   = "crSigCdVis"

    *--------------------------------------------------------------------------
    * Init - Configura BO do relatorio de visitas
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdVis"
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarFiltros - Carrega parametros iniciais e grupo padrao do usuario.
    * Chamado pelo form em InicializarForm().
    * Equivalente ao bloco de Init() do form legado SIGREVIS que carrega
    * GrPadVens de SigCdPam e verifica permissao ALTCONTA via fChecaAcesso.
    *--------------------------------------------------------------------------
    PROCEDURE InicializarFiltros()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            *-- Buscar grupo padrao do usuario (GrPadVens de SigCdPam)
            loc_cSQL = "SELECT GrPadVens FROM SigCdPam"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar par" + CHR(226) + ;
                    "metros do sistema (SigCdPam)"
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_Pam
            THIS.this_cGrupo = ALLTRIM(GrPadVens)
            USE IN cursor_4c_Pam

            *-- Sistema novo: acesso irrestrito a conta/representante para todos os usuarios
            THIS.this_lReprBloqueado = .F.

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta cursor crSigCdVis com dados de visitas conforme
    * filtros definidos nas propriedades this_*.
    * Equivalente ao metodo 'processamento' do form legado SIGREVIS.
    * Tambem cria cursor CsCabecalho para cabecalho do relatorio FRX.
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_nResult
        LOCAL loc_dDtI, loc_dDtF, loc_cDtFSQL
        LOCAL loc_cEmpresa, loc_cTitulo, loc_cPeriodo
        loc_lSucesso = .F.
        TRY
            *-- Normalizar datas: sem data = faixa maxima historica
            loc_dDtI = IIF(EMPTY(THIS.this_dDtInicial), {^1900-01-01}, THIS.this_dDtInicial)
            loc_dDtF = IIF(EMPTY(THIS.this_dDtFinal),   {^2099-12-31}, THIS.this_dDtFinal)

            *-- Data final com 23:59:59 para cobrir dia inteiro (campo DATETIME)
            loc_cDtFSQL = "'" + ;
                PADL(YEAR(loc_dDtF),  4, "0") + "-" + ;
                PADL(MONTH(loc_dDtF), 2, "0") + "-" + ;
                PADL(DAY(loc_dDtF),   2, "0") + " 23:59:59'"

            *-- Clausula WHERE adicional com filtros opcionais
            loc_cWhere = ""

            *-- Filtro conta (iclis de SigCdCli)
            IF !EMPTY(ALLTRIM(THIS.this_cCdConta))
                loc_cWhere = loc_cWhere + ;
                    " AND a.iclis = " + EscaparSQL(ALLTRIM(THIS.this_cCdConta))
            ENDIF

            *-- Filtro representante (Contas de SigCdVis = iclis de SigCdCli)
            IF !EMPTY(ALLTRIM(THIS.this_cCdRepr))
                loc_cWhere = loc_cWhere + ;
                    " AND a.Contas = " + EscaparSQL(ALLTRIM(THIS.this_cCdRepr))
            ENDIF

            *-- Fechar cursor anterior se existir
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            *-- Query principal: SigCdVis com JOIN duplo em SigCdCli
            *-- b = conta do cliente (a.iclis), c = representante (a.Contas)
            loc_cSQL = "SELECT a.*," + ;
                " b.rclis AS descri," + ;
                " c.rclis AS repr," + ;
                " CASE WHEN a.vendas=1 THEN 'Sim'" + ;
                "      ELSE 'N" + CHR(227) + "o' END AS descvendas," + ;
                " CASE WHEN a.pedidos=1 THEN 'Sim'" + ;
                "      ELSE 'N" + CHR(227) + "o' END AS descpedidos" + ;
                " FROM SigCdVis a" + ;
                " INNER JOIN SigCdCli b ON a.iclis = b.iclis" + ;
                " INNER JOIN SigCdCli c ON a.Contas = c.iclis" + ;
                " WHERE a.Grupos = " + EscaparSQL(THIS.this_cGrupo) + ;
                " AND a.Datas BETWEEN " + FormatarDataSQL(loc_dDtI) + ;
                " AND " + loc_cDtFSQL + ;
                loc_cWhere + ;
                " ORDER BY a.Contas"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao buscar dados de visitas"
                loc_lSucesso = .F.
            ENDIF

            *-- Cursor de cabecalho para o relatorio (CsCabecalho)
            loc_cEmpresa = ""
            loc_cSQL = "SELECT Razas FROM SigCdEmp"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpCab") > 0
                SELECT cursor_4c_EmpCab
                IF !EOF()
                    loc_cEmpresa = ALLTRIM(cursor_4c_EmpCab.Razas)
                ENDIF
                USE IN cursor_4c_EmpCab
            ENDIF

            loc_cTitulo  = "Relat" + CHR(243) + "rio de Visitas"
            loc_cPeriodo = "Per" + CHR(237) + "odo: " + DTOC(loc_dDtI) + ;
                " " + CHR(150) + " " + DTOC(loc_dDtF)

            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
            CREATE CURSOR CsCabecalho (cb_empresa C(80), cb_titulo C(80), cb_periodo C(80))
            INSERT INTO CsCabecalho (cb_empresa, cb_titulo, cb_periodo) ;
                VALUES (loc_cEmpresa, loc_cTitulo, loc_cPeriodo)

            SELECT (THIS.this_cCursorDados)
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Restaura filtros a partir de um cursor de configuracao
    * salva (filtros usados anteriormente pelo usuario).
    *
    * Espera um cursor com os campos opcionais:
    *   dt_inicial, dt_final  (data)
    *   cd_conta,   ds_conta  (char)
    *   cd_repr,    ds_repr   (char)
    *   opc_venda,  opc_pedido (numerico 1/2/3)
    *
    * Cada campo eh aplicado somente se existir no cursor (uso de TYPE() para
    * verificar presenca). Util para "ultimo filtro usado" sem quebrar quando
    * o esquema do cursor evoluir.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        TRY
            IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
                THIS.this_cMensagemErro = "Cursor de filtros n" + CHR(227) + ;
                    "o dispon" + CHR(237) + "vel: " + TRANSFORM(par_cAliasCursor)
                loc_lSucesso = .F.
            ENDIF

            loc_cAlias = ALLTRIM(par_cAliasCursor)
            SELECT (loc_cAlias)
            IF EOF()
                THIS.this_cMensagemErro = "Cursor de filtros vazio"
                loc_lSucesso = .F.
            ENDIF

            *-- Periodo
            IF TYPE(loc_cAlias + ".dt_inicial") = "D"
                THIS.this_dDtInicial = EVALUATE(loc_cAlias + ".dt_inicial")
            ENDIF
            IF TYPE(loc_cAlias + ".dt_final") = "D"
                THIS.this_dDtFinal = EVALUATE(loc_cAlias + ".dt_final")
            ENDIF

            *-- Conta
            IF TYPE(loc_cAlias + ".cd_conta") = "C"
                THIS.this_cCdConta = ALLTRIM(EVALUATE(loc_cAlias + ".cd_conta"))
            ENDIF
            IF TYPE(loc_cAlias + ".ds_conta") = "C"
                THIS.this_cDsConta = ALLTRIM(EVALUATE(loc_cAlias + ".ds_conta"))
            ENDIF

            *-- Representante
            IF TYPE(loc_cAlias + ".cd_repr") = "C"
                THIS.this_cCdRepr = ALLTRIM(EVALUATE(loc_cAlias + ".cd_repr"))
            ENDIF
            IF TYPE(loc_cAlias + ".ds_repr") = "C"
                THIS.this_cDsRepr = ALLTRIM(EVALUATE(loc_cAlias + ".ds_repr"))
            ENDIF

            *-- Opcoes Venda/Pedido (manter dentro de 1..3, default 3=Ambos)
            IF TYPE(loc_cAlias + ".opc_venda") = "N"
                THIS.this_nOpcaoVenda = IIF(BETWEEN(EVALUATE(loc_cAlias + ".opc_venda"), 1, 3), ;
                    EVALUATE(loc_cAlias + ".opc_venda"), 3)
            ENDIF
            IF TYPE(loc_cAlias + ".opc_pedido") = "N"
                THIS.this_nOpcaoPedido = IIF(BETWEEN(EVALUATE(loc_cAlias + ".opc_pedido"), 1, 3), ;
                    EVALUATE(loc_cAlias + ".opc_pedido"), 3)
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - BLOQUEADO: relatorios nao persistem dados.
    *
    * Override defensivo: caso o BO seja usado por engano como CRUD, retorna
    * erro explicito ao inves de corromper o banco com INSERT vazio.
    * Equivale a recusa do form legado SIGREVIS, que nao tinha botao "Incluir".
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: relat" + CHR(243) + ;
            "rios de visitas n" + CHR(227) + "o gravam registros." + CHR(13) + ;
            "Use PrepararDados() seguido de Imprimir()."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - BLOQUEADO: relatorios nao persistem dados.
    *
    * Override defensivo: simetrico a Inserir(). Reports nao modificam SigCdVis;
    * apenas extraem dados via SELECT em PrepararDados().
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: relat" + CHR(243) + ;
            "rios de visitas n" + CHR(227) + "o alteram registros." + CHR(13) + ;
            "Use PrepararDados() seguido de Imprimir()."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha cursores abertos por InicializarFiltros e PrepararDados
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Pam")
            USE IN cursor_4c_Pam
        ENDIF
        IF USED("cursor_4c_EmpCab")
            USE IN cursor_4c_EmpCab
        ENDIF
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        IF USED("CsCabecalho")
            USE IN CsCabecalho
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

