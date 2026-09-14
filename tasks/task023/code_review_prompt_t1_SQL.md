# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CRSIGCDV' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: RCLIS, GRUPOS, DATAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'VENDAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: RCLIS, GRUPOS, DATAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PEDIDOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: RCLIS, GRUPOS, DATAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: RCLIS, GRUPOS, DATAS

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREVIS.prg) - TRECHOS RELEVANTES PARA PASS SQL (1431 linhas total):

*-- Linhas 832 a 850:
832:             ENDIF
833:             loc_cArquivo = PUTFILE("Salvar como...", "SigReVis", "XLS")
834:             IF !EMPTY(loc_cArquivo)
835:                 SELECT (loc_cCursor)
836:                 COPY TO (loc_cArquivo) TYPE XLS
837:                 MsgInfo("Arquivo exportado com sucesso:" + CHR(13) + ;
838:                     loc_cArquivo, "Excel")
839:             ENDIF
840:         CATCH TO loc_oErro
841:             MsgErro(loc_oErro.Message + CHR(13) + ;
842:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
843:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
844:         ENDTRY
845:     ENDPROC
846: 
847:     *--------------------------------------------------------------------------
848:     * BtnSairClick - Fecha o formulario
849:     *--------------------------------------------------------------------------
850:     PROCEDURE BtnSairClick()

*-- Linhas 997 a 1015:
997:             "SigCdCli", "cursor_4c_BuscaRepr", "iclis", loc_cValor, ;
998:             "Sele" + CHR(231) + CHR(227) + "o de Representante", ;
999:             .F., .T., ;
1000:             "Grupos = " + EscaparSQL(THIS.this_oRelatorio.this_cGrupo))
1001:         IF VARTYPE(loc_oBusca) = "O"
1002:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1003:                 loc_oPg.txt_4c_CdRepr.Value = ALLTRIM(cursor_4c_BuscaRepr.iclis)
1004:                 loc_oPg.txt_4c_DsRepr.Value = ALLTRIM(cursor_4c_BuscaRepr.rclis)
1005:             ELSE
1006:                 IF !loc_oBusca.this_lAchouRegistro
1007:                 loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
1008:                 loc_oBusca.mAddColuna("rclis", "", "Nome")
1009:                 loc_oBusca.Show()
1010:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaRepr")
1011:                     loc_oPg.txt_4c_CdRepr.Value = ALLTRIM(cursor_4c_BuscaRepr.iclis)
1012:                     loc_oPg.txt_4c_DsRepr.Value = ALLTRIM(cursor_4c_BuscaRepr.rclis)
1013:                 ENDIF
1014:                 ENDIF
1015:             ENDIF

*-- Linhas 1032 a 1050:
1032:             "SigCdCli", "cursor_4c_BuscaRepr", "rclis", loc_cValor, ;
1033:             "Sele" + CHR(231) + CHR(227) + "o de Representante", ;
1034:             .F., .T., ;
1035:             "Grupos = " + EscaparSQL(THIS.this_oRelatorio.this_cGrupo))
1036:         IF VARTYPE(loc_oBusca) = "O"
1037:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1038:                 loc_oPg.txt_4c_DsRepr.Value = ALLTRIM(cursor_4c_BuscaRepr.rclis)
1039:                 loc_oPg.txt_4c_CdRepr.Value = ALLTRIM(cursor_4c_BuscaRepr.iclis)
1040:             ELSE
1041:                 IF !loc_oBusca.this_lAchouRegistro
1042:                 loc_oBusca.mAddColuna("rclis", "", "Nome")
1043:                 loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
1044:                 loc_oBusca.Show()
1045:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaRepr")
1046:                     loc_oPg.txt_4c_DsRepr.Value = ALLTRIM(cursor_4c_BuscaRepr.rclis)
1047:                     loc_oPg.txt_4c_CdRepr.Value = ALLTRIM(cursor_4c_BuscaRepr.iclis)
1048:                 ENDIF
1049:                 ENDIF
1050:             ENDIF

*-- Linhas 1067 a 1090:
1067:             loc_oPg.txt_4c_DsRepr.Value = ""
1068:             RETURN
1069:         ENDIF
1070:         loc_cSQL = "SELECT iclis, rclis FROM SigCdCli" + ;
1071:             " WHERE Grupos = " + EscaparSQL(THIS.this_oRelatorio.this_cGrupo) + ;
1072:             " AND iclis = " + EscaparSQL(loc_cValor)
1073:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ReprVal")
1074:         IF loc_nResult > 0
1075:             SELECT cursor_4c_ReprVal
1076:             IF !EOF()
1077:                 loc_oPg.txt_4c_DsRepr.Value = ALLTRIM(cursor_4c_ReprVal.rclis)
1078:             ELSE
1079:                 loc_oPg.txt_4c_DsRepr.Value = ""
1080:                 THIS.AbrirBuscaCdRepr()
1081:             ENDIF
1082:         ELSE
1083:             loc_oPg.txt_4c_DsRepr.Value = ""
1084:             THIS.AbrirBuscaCdRepr()
1085:         ENDIF
1086:         IF USED("cursor_4c_ReprVal")
1087:             USE IN cursor_4c_ReprVal
1088:         ENDIF
1089:         THIS.AtualizarEstadoCamposDescricao()
1090:     ENDPROC

*-- Linhas 1100 a 1123:
1100:             loc_oPg.txt_4c_CdRepr.Value = ""
1101:             RETURN
1102:         ENDIF
1103:         loc_cSQL = "SELECT iclis, rclis FROM SigCdCli" + ;
1104:             " WHERE Grupos = " + EscaparSQL(THIS.this_oRelatorio.this_cGrupo) + ;
1105:             " AND rclis LIKE " + EscaparSQL(loc_cValor + "%")
1106:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ReprVal2")
1107:         IF loc_nResult > 0
1108:             SELECT cursor_4c_ReprVal2
1109:             IF !EOF()
1110:                 loc_oPg.txt_4c_CdRepr.Value = ALLTRIM(cursor_4c_ReprVal2.iclis)
1111:                 loc_oPg.txt_4c_DsRepr.Value = ALLTRIM(cursor_4c_ReprVal2.rclis)
1112:             ELSE
1113:                 THIS.AbrirBuscaDsRepr()
1114:             ENDIF
1115:         ELSE
1116:             THIS.AbrirBuscaDsRepr()
1117:         ENDIF
1118:         IF USED("cursor_4c_ReprVal2")
1119:             USE IN cursor_4c_ReprVal2
1120:         ENDIF
1121:         THIS.AtualizarEstadoCamposDescricao()
1122:     ENDPROC
1123: 

*-- Linhas 1204 a 1226:
1204:             loc_oPg.txt_4c_DsConta.Value = ""
1205:             RETURN
1206:         ENDIF
1207:         loc_cSQL = "SELECT iclis, rclis FROM SigCdCli" + ;
1208:             " WHERE iclis = " + EscaparSQL(loc_cValor)
1209:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaVal")
1210:         IF loc_nResult > 0
1211:             SELECT cursor_4c_ContaVal
1212:             IF !EOF()
1213:                 loc_oPg.txt_4c_DsConta.Value = ALLTRIM(cursor_4c_ContaVal.rclis)
1214:             ELSE
1215:                 loc_oPg.txt_4c_DsConta.Value = ""
1216:                 THIS.AbrirBuscaCdConta()
1217:             ENDIF
1218:         ELSE
1219:             loc_oPg.txt_4c_DsConta.Value = ""
1220:             THIS.AbrirBuscaCdConta()
1221:         ENDIF
1222:         IF USED("cursor_4c_ContaVal")
1223:             USE IN cursor_4c_ContaVal
1224:         ENDIF
1225:         THIS.AtualizarEstadoCamposDescricao()
1226:     ENDPROC

*-- Linhas 1236 a 1258:
1236:             loc_oPg.txt_4c_CdConta.Value = ""
1237:             RETURN
1238:         ENDIF
1239:         loc_cSQL = "SELECT iclis, rclis FROM SigCdCli" + ;
1240:             " WHERE rclis LIKE " + EscaparSQL(loc_cValor + "%")
1241:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaVal2")
1242:         IF loc_nResult > 0
1243:             SELECT cursor_4c_ContaVal2
1244:             IF !EOF()
1245:                 loc_oPg.txt_4c_CdConta.Value = ALLTRIM(cursor_4c_ContaVal2.iclis)
1246:                 loc_oPg.txt_4c_DsConta.Value = ALLTRIM(cursor_4c_ContaVal2.rclis)
1247:             ELSE
1248:                 THIS.AbrirBuscaDsConta()
1249:             ENDIF
1250:         ELSE
1251:             THIS.AbrirBuscaDsConta()
1252:         ENDIF
1253:         IF USED("cursor_4c_ContaVal2")
1254:             USE IN cursor_4c_ContaVal2
1255:         ENDIF
1256:         THIS.AtualizarEstadoCamposDescricao()
1257:     ENDPROC
1258: 


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

            *-- Filtro venda: 1=Sim (Vendas=1), 2=Nao (Vendas=0), 3=Ambos (sem filtro)
            IF THIS.this_nOpcaoVenda = 1
                loc_cWhere = loc_cWhere + " AND a.Vendas = 1"
            ENDIF
            IF THIS.this_nOpcaoVenda = 2
                loc_cWhere = loc_cWhere + " AND a.Vendas = 0"
            ENDIF

            *-- Filtro pedido: 1=Sim (Pedidos=1), 2=Nao (Pedidos=0), 3=Ambos (sem filtro)
            IF THIS.this_nOpcaoPedido = 1
                loc_cWhere = loc_cWhere + " AND a.Pedidos = 1"
            ENDIF
            IF THIS.this_nOpcaoPedido = 2
                loc_cWhere = loc_cWhere + " AND a.Pedidos = 0"
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
            loc_cSQL = "SELECT Razas FROM SigCdEmp" + ;
                " WHERE Cemps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
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

