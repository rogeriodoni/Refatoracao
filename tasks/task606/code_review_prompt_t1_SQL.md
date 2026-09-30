# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (7)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPODS, CONTADS, EMPDS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPODS, CONTADS, EMPDS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPODS, CONTADS, EMPDS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPODS, CONTADS, EMPDS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RAZAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPODS, CONTADS, EMPDS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPODS, CONTADS, EMPDS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CPFS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPODS, CONTADS, EMPDS

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
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
		lcQuery = [Select GrPadVens ] + ;
				    [From SigCdPam ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalParam') < 1)
		Select CqSigCdCli
lcQuery = [Select a.* ] + ;
		    [From SigMvCab a, SigCdOpe b ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'csTemporario') < 1)
Select csTemporario
Update csTemporario ;

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEs1.prg) - TRECHOS RELEVANTES PARA PASS SQL (1769 linhas total):

*-- Linhas 37 a 78:
37: * SIGPRES1): Width=823, Height=400, BorderStyle=2 (sizable-fixo), sem barra
38: * de titulo (TitleBar=0/ControlBox=.F.), AutoCenter=.T., DataSession=2
39: * (sessao privada - FormBase.Init() ja normaliza SET DATE/CENTURY, regra
40: * CLAUDE.md #9.4; este form nao faz DELETE local nem SEEK sensivel a
41: * SET EXACT, entao nao precisa repor DELETED/EXACT).
42: *
43: * FASE 8 (consolidacao) entregou o par de hooks canonico, com os nomes de
44: * FormBase (ambos PROTECTED PROCEDURE, como na classe base - subclasse nao
45: * alarga escopo de hook):
46: *   - FormParaBO  : controles -> propriedades do BO (era
47: *                   "SincronizarFiltrosComBO"; renomeado para o nome canonico,
48: *                   o comportamento nao mudou). Chamado por BtnConsultarClick.
49: *   - BOParaForm  : BO -> controles, na abertura da tela. NOVO nesta fase - o
50: *                   bloco "With .Container1" do Init legado nao tinha sido
51: *                   migrado, e com ele faltava ".get_cd_empresa.Value = _empr":
52: *                   a Empresa abria VAZIA e todo primeiro Consultar caia em
53: *                   "Empresa Invalida!!!".
54: *
55: * NAO existem aqui, porque o legado SIGPRES1 nao os tem e cria-los seria
56: * inventar superficie (PILAR 1) ou deixar metodo vazio (regra de completude):
57: *   - CarregarLista / grd_*  : o SCX nao tem Grid nem PageFrame; os 7
58: *     "ControlSource" do dump sao TODOS string vazia em TextBox de filtro. O
59: *     resultado da consulta nao eh exibido aqui - vai para a tela filha
60: *     Formsigpres2 pelo cursor csTemporario.
61: *   - BtnSalvarClick / BtnCancelarClick / HabilitarCampos /
62: *     AjustarBotoesPorModo : nao ha Page2 de Dados, nem modo de edicao, nem
63: *     gravacao - o dump nao tem INSERT/UPDATE/DELETE em tabela nenhuma. O
64: *     botao de acao do legado eh o "Consultar" (commandgroup "sair",
65: *     Command1), cujo handler eh BtnConsultarClick.
66: *==============================================================================
67: 
68: DEFINE CLASS FormSigPrEs1 AS FormBase
69: 
70:     *-- Propriedades visuais (SECAO 2 do dump, objeto SIGPRES1)
71:     Width        = 823
72:     Height       = 400
73:     Caption      = "Posi" + CHR(231) + CHR(227) + "o Por Movimenta" + CHR(231) + CHR(227) + "o"
74:     AutoCenter   = .T.
75:     BorderStyle  = 2
76:     ControlBox   = .F.
77:     MaxButton    = .F.
78:     MinButton    = .F.

*-- Linhas 1121 a 1156:
1121:             USE IN cursor_4c_SigPrEs1Cpf
1122:         ENDIF
1123: 
1124:         loc_cSQL = "SELECT Cpfs FROM SigCdCli WHERE IClis = " + EscaparSQL(par_cConta)
1125:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigPrEs1Cpf")
1126: 
1127:         IF loc_nResultado > 0 AND USED("cursor_4c_SigPrEs1Cpf") AND RECCOUNT("cursor_4c_SigPrEs1Cpf") > 0
1128:             loc_cCpf = ALLTRIM(TratarNulo(cursor_4c_SigPrEs1Cpf.Cpfs, ""))
1129:         ENDIF
1130: 
1131:         IF USED("cursor_4c_SigPrEs1Cpf")
1132:             USE IN cursor_4c_SigPrEs1Cpf
1133:         ENDIF
1134: 
1135:         RETURN loc_cCpf
1136:     ENDPROC
1137: 
1138:     *--------------------------------------------------------------------------
1139:     * ValidarMoedaCodigo / ValidarMoedaDescricao - Moeda (SigCdMoe). O legado
1140:     * usa fwbuscaext (CreateObject direto); aqui o Pattern B (CREATEOBJECT com
1141:     * parametros) eh PROIBIDO - substituido por match exato via SQLEXEC e,
1142:     * na falta, THIS.AbrirLookupCanonico (Pattern A, FormBase.prg).
1143:     *--------------------------------------------------------------------------
1144:     PROTECTED PROCEDURE ValidarMoedaCodigo()
1145:         LOCAL loc_oCnt, loc_cValor
1146:         loc_oCnt  = THIS.cnt_4c_Container1
1147:         loc_cValor = ALLTRIM(loc_oCnt.txt_4c__cd_moeda.Value)
1148: 
1149:         IF EMPTY(loc_cValor)
1150:             loc_oCnt.txt_4c__ds_moeda.Value = ""
1151:             RETURN
1152:         ENDIF
1153: 
1154:         THIS.AbrirLookupMoeda(loc_cValor, loc_oCnt.txt_4c__cd_moeda, loc_oCnt.txt_4c__ds_moeda)
1155:     ENDPROC
1156: 

*-- Linhas 1175 a 1195:
1175:             USE IN cursor_4c_SigPrEs1Moe
1176:         ENDIF
1177: 
1178:         loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(par_cValor) + ;
1179:                    " OR dmoes = " + EscaparSQL(par_cValor)
1180:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigPrEs1Moe")
1181: 
1182:         IF loc_nResultado > 0 AND USED("cursor_4c_SigPrEs1Moe") AND RECCOUNT("cursor_4c_SigPrEs1Moe") = 1
1183:             par_oTxtCod.Value  = ALLTRIM(cursor_4c_SigPrEs1Moe.cmoes)
1184:             par_oTxtDesc.Value = ALLTRIM(cursor_4c_SigPrEs1Moe.dmoes)
1185:             loc_lAchou = .T.
1186:         ENDIF
1187: 
1188:         IF USED("cursor_4c_SigPrEs1Moe")
1189:             USE IN cursor_4c_SigPrEs1Moe
1190:         ENDIF
1191: 
1192:         IF !loc_lAchou
1193:             IF !THIS.AbrirLookupCanonico("SigCdMoe", "cmoes", "dmoes", ;
1194:                     "Sele" + CHR(231) + CHR(227) + "o de Moeda", par_cValor, par_oTxtCod, par_oTxtDesc)
1195:                 par_oTxtCod.Value  = ""

*-- Linhas 1278 a 1298:
1278:             USE IN cursor_4c_SigPrEs1Emp
1279:         ENDIF
1280: 
1281:         loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(par_cValor) + ;
1282:                    " OR Razas = " + EscaparSQL(par_cValor)
1283:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigPrEs1Emp")
1284: 
1285:         IF loc_nResultado > 0 AND USED("cursor_4c_SigPrEs1Emp") AND RECCOUNT("cursor_4c_SigPrEs1Emp") = 1
1286:             par_oTxtCod.Value  = ALLTRIM(cursor_4c_SigPrEs1Emp.Cemps)
1287:             par_oTxtDesc.Value = ALLTRIM(cursor_4c_SigPrEs1Emp.Razas)
1288:             loc_lAchou = .T.
1289:         ENDIF
1290: 
1291:         IF USED("cursor_4c_SigPrEs1Emp")
1292:             USE IN cursor_4c_SigPrEs1Emp
1293:         ENDIF
1294: 
1295:         IF !loc_lAchou
1296:             IF !THIS.AbrirLookupCanonico("SigCdEmp", "Cemps", "Razas", ;
1297:                     "Sele" + CHR(231) + CHR(227) + "o de Empresa", par_cValor, par_oTxtCod, par_oTxtDesc)
1298:                 par_oTxtCod.Value  = ""

*-- Linhas 1323 a 1341:
1323:             USE IN cursor_4c_SigPrEs1Ope
1324:         ENDIF
1325: 
1326:         IF SQLEXEC(gnConnHandle, "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cValor), ;
1327:                 "cursor_4c_SigPrEs1Ope") > 0 AND USED("cursor_4c_SigPrEs1Ope") AND RECCOUNT("cursor_4c_SigPrEs1Ope") > 0
1328:             loc_lAchou = .T.
1329:         ENDIF
1330: 
1331:         IF USED("cursor_4c_SigPrEs1Ope")
1332:             USE IN cursor_4c_SigPrEs1Ope
1333:         ENDIF
1334: 
1335:         IF !loc_lAchou
1336:             IF !THIS.AbrirLookupCanonico("SigCdOpe", "Dopes", "Dopes", ;
1337:                     "Sele" + CHR(231) + CHR(227) + "o de Movimenta" + CHR(231) + CHR(227) + "o", ;
1338:                     loc_cValor, loc_oCnt.txt_4c__nm_operacao, .NULL.)
1339:                 loc_oCnt.txt_4c__nm_operacao.Value = ""
1340:             ENDIF
1341:         ENDIF

*-- Linhas 1379 a 1399:
1379:             USE IN cursor_4c_SigPrEs1Cli
1380:         ENDIF
1381: 
1382:         loc_cSQL = "SELECT IClis, RClis, Cpfs FROM SigCdCli WHERE Cpfs = " + ;
1383:             EscaparSQL(PADR(loc_cMascarado, 20))
1384:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigPrEs1Cli")
1385: 
1386:         IF loc_nResultado <= 0 OR !USED("cursor_4c_SigPrEs1Cli") OR RECCOUNT("cursor_4c_SigPrEs1Cli") = 0
1387:             MsgAviso("CPF / CGC n" + CHR(227) + "o encontrado !!!", "Aten" + CHR(231) + CHR(227) + "o")
1388:             IF USED("cursor_4c_SigPrEs1Cli")
1389:                 USE IN cursor_4c_SigPrEs1Cli
1390:             ENDIF
1391:             loc_oCnt.txt_4c_Cpf.SetFocus()
1392:             RETURN
1393:         ENDIF
1394: 
1395:         loc_cIclis = ALLTRIM(cursor_4c_SigPrEs1Cli.IClis)
1396: 
1397:         IF !fAcessoContas(gc_4c_UsuarioLogado, "", "C", loc_cIclis, loc_oCnt.txt_4c_Conta, loc_oCnt.txt_4c_Dconta)
1398:             MsgAviso("Acesso Negado !!", "Aten" + CHR(231) + CHR(227) + "o")
1399:             loc_oCnt.txt_4c_Conta.Value  = ""

*-- Linhas 1519 a 1537:
1519:         THIS.FormParaBO()
1520: 
1521:         *-- ALCANCE do "ThisForm.Enabled" transcrito do legado (linhas 1697-1716
1522:         *-- do dump): o SqlExecute roda ANTES de "ThisForm.Enabled = .f." e, em
1523:         *-- caso de falha, exibe 'Favor Reinicializar o Processo!!!' e faz
1524:         *-- "Return 0" SEM ter desabilitado o form. Manter essa fronteira nao eh
1525:         *-- detalhe: este form eh MODAL (WindowType = 1) e nao tem barra de
1526:         *-- titulo (TitleBar = 0 / ControlBox = .F.), entao form desabilitado
1527:         *-- deixa o usuario SEM SAIDA - nem o Encerrar responde. Cobrir a
1528:         *-- consulta SQL com o Enabled = .F. alargaria o alcance do legado e
1529:         *-- trancaria a tela em todo caminho que nao chegasse ao Enabled = .T.
1530:         loc_lSucesso = loc_oBO.BuscarMovimentacao()
1531: 
1532:         IF !loc_lSucesso
1533:             *-- Legado: Messagebox('Favor Reinicializar o Processo!!!', 16,
1534:             *-- 'Falha na Conexao (csTemporario)'). O texto da mensagem ja vem
1535:             *-- em this_cMensagemErro (SigPrEs1BO.BuscarMovimentacao); aqui vai
1536:             *-- o titulo literal do legado.
1537:             MsgErro(loc_oBO.this_cMensagemErro, ;

*-- Linhas 1649 a 1667:
1649:     *
1650:     * Formsigpres2BO.CarregarDoCursorTemporario() e Formsigpres2.CarregarLista()
1651:     * (grd_4c_Lista.RecordSource) leem o cursor GLOBAL "csTemporario" pelo
1652:     * NOME LITERAL - o mesmo nome que o legado usava (SqlExecute(lcQuery,
1653:     * 'csTemporario')). Por isso o resultado de BuscarMovimentacao()
1654:     * (cursor_4c_Movimentacao, nome canonico do BO) e copiado para um cursor
1655:     * "csTemporario" antes do CREATEOBJECT - renomear quebraria o contrato
1656:     * com a tela filha ja migrada (regra do wrapper: reproduzir o CONTRATO,
1657:     * nao so o nome).
1658:     *--------------------------------------------------------------------------
1659:     PROTECTED PROCEDURE AbrirTelaMovimentacao(par_cNomeOperacao)
1660:         LOCAL loc_oForm, loc_oErro, loc_lFalhou
1661: 
1662:         loc_oForm   = .NULL.
1663:         loc_lFalhou = .F.
1664: 
1665:         *-- O TRY cobre SO a preparacao do cursor e o CREATEOBJECT - o Show()
1666:         *-- fica FORA (CLAUDE.md regra #29). Formsigpres2 tem WindowType = 1,
1667:         *-- entao o Show() BLOQUEIA e a tela filha inteira (cada Valid, cada

*-- Linhas 1675 a 1702:
1675:                 USE IN csTemporario
1676:             ENDIF
1677: 
1678:             SELECT * FROM cursor_4c_Movimentacao INTO CURSOR csTemporario READWRITE
1679: 
1680:             *-- Legado (dump linha 1704): "Index On EmpDopNums Tag EmpDopNums"
1681:             *-- roda no PROPRIO csTemporario, logo apos o SqlExecute. O indice
1682:             *-- que SigPrEs1BO.BuscarMovimentacao cria em cursor_4c_Movimentacao
1683:             *-- NAO atravessa o SELECT ... INTO CURSOR acima - um cursor novo
1684:             *-- nasce sem tag nenhuma. Sem refazer aqui, a tela filha recebe o
1685:             *-- csTemporario SEM a tag e um SEEK nela falharia devolvendo ZERO
1686:             *-- linhas, sem erro e sem log (CLAUDE.md regra #42).
1687:             SELECT csTemporario
1688:             INDEX ON EmpDopNums TAG EmpDopNums
1689: 
1690:             GO TOP IN csTemporario
1691: 
1692:             loc_oForm = CREATEOBJECT("Formsigpres2", par_cNomeOperacao, THIS.DataSessionId, THIS)
1693:         CATCH TO loc_oErro
1694:             loc_oForm   = .NULL.
1695:             loc_lFalhou = .T.
1696:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1697:                 "Erro ao abrir Movimenta" + CHR(231) + CHR(227) + "o")
1698:         ENDTRY
1699: 
1700:         IF VARTYPE(loc_oForm) = "O"
1701:             *-- Legado: "Do Form sigpres2 With lcNmO, ThisForm.DataSessionId,
1702:             *-- ThisForm". Formsigpres2 nao declara DataSession, logo usa a


### BO (C:\4c\projeto\app\classes\SigPrEs1BO.prg):
*------------------------------------------------------------------------------
* SigPrEs1BO.prg - Business Object para Posicao Por Movimentacao
* Form legado: SIGPRES1 (form OPERACIONAL - filtro de relatorio, sem tabela CRUD)
* Herdado de: BusinessBase
*
* O legado nao grava em tabela alguma: monta filtros e consulta SigMvCab +
* SigCdOpe para alimentar a tela filha (sigpres2). Conferido no dump
* tasks\task606\SigPrEs1_form_codigo_fonte.txt: nenhum TABLEUPDATE(), nenhum
* .AddCursor(), e o unico comando de escrita eh
*   Update csTemporario Set PrazoEnts = Iif(IsNull(PrazoEnts), Ctod(''), ...)
* cujo alvo csTemporario eh o CURSOR LOCAL criado por
* poDataMgr.SqlExecute(lcQuery, 'csTemporario') - ou seja, ajuste em memoria
* que nunca volta para o banco.
*
* Por isso este BO deixa Inserir(), Atualizar() e ExecutarExclusao() HERDADOS
* de BusinessBase: a base ja recusa a operacao e reporta pelo ExibirFalha() do
* Salvar(), que eh o comportamento correto aqui. Sobrescrever esses metodos
* exigiria INVENTAR um INSERT/UPDATE, o que a regra #22 do CLAUDE.md proibe
* (a lista de colunas vem do schema, nunca de adivinhacao).
*
* O metodo de negocio real eh BuscarMovimentacao(), equivalente ao
* consulta.Click do SCX original. CarregarDoCursor() le a linha corrente do
* cursor de resultado e ObterChavePrimaria() devolve a chave EmpDopNums dessa
* linha (usada pela auditoria de BusinessBase e pelo handoff para a tela
* filha).
*------------------------------------------------------------------------------
DEFINE CLASS SigPrEs1BO AS BusinessBase

    *-- Configuracao da entidade (form OPERACIONAL - nao ha tabela unica/CRUD)
    this_cTabela     = "SigMvCab"
    this_cCampoChave = ""

    *-- Filtro: Movimentacao / Periodo
    this_cNomeOperacao = ""
    this_dDataInicial  = {}
    this_dDataFinal    = {}
    this_nNumero       = 0
    this_nOperacao     = 0
    this_cStatus       = ""

    *-- Filtro: Grupo / Conta
    this_cGrupo            = ""
    this_cDescricaoGrupo   = ""
    this_cConta            = ""
    this_cDescricaoConta   = ""
    this_cCpfCnpj          = ""

    *-- Filtro: Moeda
    this_cCodigoMoeda    = ""
    this_cDescricaoMoeda = ""

    *-- Filtro: Responsavel
    this_cResponsavel          = ""
    this_cDescricaoResponsavel = ""

    *-- Filtro: Empresa
    this_cCodigoEmpresa    = ""
    this_cDescricaoEmpresa = ""
    this_lEmpresaDestino   = .F.

    *-- Opcoes (OptionGroups do filtro) - valores DEFAULT identicos ao SCX legado
    this_nOpcaoPeriodo    = 1
    this_nOpcaoPendente   = 3
    this_nOpcaoImpressao  = 1
    this_nOpcaoCotacao    = 1

    *-- Parametros do sistema (equivalente ao cursor LocalParam do legado)
    this_cGrupoPadraoResponsavel = ""

    *-- Resultado da consulta (equivalente ao cursor csTemporario do legado)
    this_cCursorResultado = "cursor_4c_Movimentacao"
    this_nTotalRegistros  = 0

    *-- Linha corrente do cursor de resultado, lida por CarregarDoCursor().
    *-- Sao EXATAMENTE as colunas de SigMvCab que o legado nomeia no lcWhere /
    *-- lcQuery do consulta.Click, mais a chave empdopnums usada no Index On -
    *-- nenhuma coluna a mais. Conferidas uma a uma em docs\schema.sql:
    *--   emps char(3)        empds char(3)       dopes char(20)
    *--   datas datetime      prazoents datetime  grupoos char(10)
    *--   grupods char(10)    contaos char(10)    contads char(10)
    *--   nops numeric(10,0)  numes numeric(6,0)  vends char(10)
    *--   chksubn bit         pstatus char(1)     empdopnums char(29)
    this_cRegEmpresa       = ""
    this_cRegEmpresaDest   = ""
    this_cRegOperacao      = ""
    *-- {/:} eh DATETIME vazio (VARTYPE "T"): as colunas datas/prazoents sao
    *-- datetime, e manter o tipo estavel antes e depois da carga evita o erro
    *-- 11 de TTOD() com DATE (regra #16 do CLAUDE.md).
    this_dRegData          = {/:}
    this_dRegPrazoEntrega  = {/:}
    this_cRegGrupoOrigem   = ""
    this_cRegGrupoDestino  = ""
    this_cRegContaOrigem   = ""
    this_cRegContaDestino  = ""
    this_nRegNumeroOp      = 0
    this_nRegNumero        = 0
    this_cRegVendedor      = ""
    this_lRegBaixada       = .F.
    this_cRegStatus        = ""
    this_cRegChave         = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro

        TRY
            loc_lSucesso = DODEFAULT()

            THIS.this_cTabela     = "SigMvCab"
            THIS.this_cCampoChave = ""

            THIS.this_cNomeOperacao = ""
            THIS.this_dDataInicial  = DATE()
            THIS.this_dDataFinal    = DATE()
            THIS.this_nNumero       = 0
            THIS.this_nOperacao     = 0
            THIS.this_cStatus       = ""

            THIS.this_cGrupo          = ""
            THIS.this_cDescricaoGrupo = ""
            THIS.this_cConta          = ""
            THIS.this_cDescricaoConta = ""
            THIS.this_cCpfCnpj        = ""

            THIS.this_cCodigoMoeda    = ""
            THIS.this_cDescricaoMoeda = ""

            THIS.this_cResponsavel          = ""
            THIS.this_cDescricaoResponsavel = ""

            *-- Legado: .get_cd_empresa.Value = _empr
            *-- _EMPR eh variavel do Framework antigo; a fonte canonica no
            *-- sistema novo eh go_4c_Sistema.cCodEmpresa (config.prg).
            THIS.this_cCodigoEmpresa = ""
            IF TYPE("go_4c_Sistema") = "O"
                THIS.this_cCodigoEmpresa = ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))
            ENDIF
            THIS.this_cDescricaoEmpresa = ""
            THIS.this_lEmpresaDestino   = .F.

            THIS.this_nOpcaoPeriodo   = 1
            THIS.this_nOpcaoPendente  = 3
            THIS.this_nOpcaoImpressao = 1
            THIS.this_nOpcaoCotacao   = 1

            THIS.this_cGrupoPadraoResponsavel = ""
            THIS.this_cCursorResultado        = "cursor_4c_Movimentacao"
            THIS.this_nTotalRegistros         = 0

            THIS.LimparLinhaCorrente()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        IF loc_lSucesso
            *-- Equivalente ao SqlExecute("Select GrPadVens From SigCdPam...", "LocalParam")
            *-- do Init legado - usado pela validacao de acesso do Responsavel.
            THIS.CarregarParametrosSistema()
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametrosSistema - Carrega parametros globais de SigCdPam
    * Equivalente ao cursor LocalParam populado no Init do form legado:
    *   Select GrPadVens From SigCdPam Where Not cIdChaves = fUniqueIds()
    * (a comparacao com um id recem-gerado nunca casa, entao devolve a linha
    * unica de parametros da empresa - transcrito literalmente do legado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarParametrosSistema()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_cSQL = "SELECT GrPadVens FROM SigCdPam WHERE NOT cidchaves = " + ;
                    EscaparSQL(fUniqueIds())

                IF USED("cursor_4c_SigPrEs1Pam")
                    USE IN cursor_4c_SigPrEs1Pam
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigPrEs1Pam")

                IF loc_nResultado > 0 AND USED("cursor_4c_SigPrEs1Pam")
                    SELECT cursor_4c_SigPrEs1Pam
                    GO TOP
                    IF !EOF()
                        THIS.this_cGrupoPadraoResponsavel = ALLTRIM(TratarNulo(GrPadVens, ""))
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL()
                ENDIF

                IF USED("cursor_4c_SigPrEs1Pam")
                    USE IN cursor_4c_SigPrEs1Pam
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Reproduz as validacoes do consulta.Click do legado antes
    * de disparar a consulta: Empresa, Operacao (Movimentacao) e Periodo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFiltros()
        LOCAL loc_lValido

        loc_lValido = .T.
        THIS.this_cMensagemErro = ""

        IF EMPTY(ALLTRIM(THIS.this_cCodigoEmpresa))
            THIS.this_cMensagemErro = "Empresa Inv" + CHR(225) + "lida!!!"
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cNomeOperacao))
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!"
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_dDataFinal < THIS.this_dDataInicial
            THIS.this_cMensagemErro = "Per" + CHR(237) + "odo Inv" + CHR(225) + "lido!!! Data Final Menor do Que a Inicial!!!"
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarWhereConsulta - Monta o trecho de filtros da consulta, transcrito
    * literalmente da variavel lcWhere do metodo consulta.Click do legado.
    * Cada filtro so entra na clausula quando o campo correspondente esta
    * preenchido, exatamente como no SCX original.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarWhereConsulta()
        LOCAL loc_cWhere

        loc_cWhere = ""

        IF !EMPTY(ALLTRIM(THIS.this_cNomeOperacao))
            loc_cWhere = loc_cWhere + "a.Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cNomeOperacao)) + " And "
        ENDIF

        IF THIS.this_nOpcaoPeriodo = 1
            loc_cWhere = loc_cWhere + "a.Datas BetWeen " + ;
                FormatarDataSQL(fDtoSQL(THIS.this_dDataInicial)) + " And " + ;
                FormatarDataSQL(fDtoSQL(THIS.this_dDataFinal, "23:59:59")) + " And "
        ELSE
            loc_cWhere = loc_cWhere + "a.PrazoEnts BetWeen " + ;
                FormatarDataSQL(fDtoSQL(THIS.this_dDataInicial)) + " And " + ;
                FormatarDataSQL(fDtoSQL(THIS.this_dDataFinal, "23:59:59")) + " And "
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.this_cGrupo))
            loc_cWhere = loc_cWhere + "(a.GrupoOs = " + EscaparSQL(ALLTRIM(THIS.this_cGrupo)) + ;
                " Or a.GrupoDs = " + EscaparSQL(ALLTRIM(THIS.this_cGrupo)) + ") And "
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.this_cConta))
            loc_cWhere = loc_cWhere + "(a.ContaOs = " + EscaparSQL(ALLTRIM(THIS.this_cConta)) + ;
                " Or a.ContaDs = " + EscaparSQL(ALLTRIM(THIS.this_cConta)) + ") And "
        ENDIF

        IF THIS.this_nOperacao != 0
            loc_cWhere = loc_cWhere + "a.Nops = " + FormatarNumeroSQL(THIS.this_nOperacao, 0) + " And "
        ENDIF

        IF THIS.this_nNumero != 0
            loc_cWhere = loc_cWhere + "a.Numes = " + FormatarNumeroSQL(THIS.this_nNumero, 0) + " And "
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.this_cResponsavel))
            loc_cWhere = loc_cWhere + "a.Vends = " + EscaparSQL(ALLTRIM(THIS.this_cResponsavel)) + " And "
        ENDIF

        DO CASE
            CASE THIS.this_nOpcaoPendente = 1
                loc_cWhere = loc_cWhere + "a.ChkSubn = 0 And "
            CASE THIS.this_nOpcaoPendente = 2
                loc_cWhere = loc_cWhere + "a.ChkSubn = 1 And "
        ENDCASE

        IF !EMPTY(ALLTRIM(THIS.this_cStatus))
            loc_cWhere = loc_cWhere + "a.pStatus = " + EscaparSQL(ALLTRIM(THIS.this_cStatus)) + " And "
        ENDIF

        RETURN loc_cWhere
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarSQLConsulta - Monta a consulta completa, transcrita da variavel
    * lcQuery do metodo consulta.Click do legado (join SigMvCab + SigCdOpe).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarSQLConsulta()
        LOCAL loc_cWhereEmpresa

        loc_cWhereEmpresa = "(a.Emps = " + EscaparSQL(ALLTRIM(THIS.this_cCodigoEmpresa))
        IF THIS.this_lEmpresaDestino
            loc_cWhereEmpresa = loc_cWhereEmpresa + " Or a.Empds = " + EscaparSQL(ALLTRIM(THIS.this_cCodigoEmpresa))
        ENDIF
        loc_cWhereEmpresa = loc_cWhereEmpresa + ") And "

        RETURN "SELECT a.* FROM SigMvCab a, SigCdOpe b WHERE " + ;
            loc_cWhereEmpresa + THIS.MontarWhereConsulta() + "a.Dopes = b.Dopes"
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarMovimentacao - Executa a consulta de posicao por movimentacao.
    * Equivalente ao metodo consulta.Click do legado (sem a parte de UI:
    * SetFocus/MessageBox/Do Form sigpres2 ficam por conta do Form).
    * Popula THIS.this_cCursorResultado (cursor_4c_Movimentacao) e
    * THIS.this_nTotalRegistros. Retorna .F. so quando a consulta falha -
    * zero registros encontrados NAO eh erro, eh resultado valido.
    *--------------------------------------------------------------------------
    FUNCTION BuscarMovimentacao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        THIS.this_cMensagemErro  = ""
        THIS.this_nTotalRegistros = 0
        loc_lSucesso = .F.

        IF !THIS.ValidarFiltros()
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = THIS.MontarSQLConsulta()

            IF USED("cursor_4c_SigPrEs1Tmp")
                USE IN cursor_4c_SigPrEs1Tmp
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigPrEs1Tmp")

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL()
            ELSE
                IF USED("cursor_4c_Movimentacao")
                    USE IN cursor_4c_Movimentacao
                ENDIF

                SELECT * FROM cursor_4c_SigPrEs1Tmp INTO CURSOR cursor_4c_Movimentacao READWRITE

                IF USED("cursor_4c_SigPrEs1Tmp")
                    USE IN cursor_4c_SigPrEs1Tmp
                ENDIF

                SELECT cursor_4c_Movimentacao
                INDEX ON EmpDopNums TAG EmpDopNums

                REPLACE ALL PrazoEnts WITH CTOD("") FOR ISNULL(PrazoEnts)

                *-- Legado: Go Top In csTemporario, e so depois If (Reccount() > 0)
                GO TOP

                THIS.this_nTotalRegistros = RECCOUNT("cursor_4c_Movimentacao")

                *-- Deixa a 1a linha ja carregada nas propriedades this_*Reg*
                *-- (e limpa quando a consulta nao trouxe nada, para nao herdar
                *-- a linha da consulta anterior).
                IF THIS.this_nTotalRegistros > 0
                    THIS.CarregarDoCursor("cursor_4c_Movimentacao")
                ELSE
                    THIS.LimparLinhaCorrente()
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * LimparLinhaCorrente - zera as propriedades da linha corrente do cursor
    * de resultado. Chamado no Init e sempre que a consulta devolve zero linhas,
    * para que uma consulta nova nunca herde a linha da consulta anterior.
    *--------------------------------------------------------------------------
    PROCEDURE LimparLinhaCorrente()
        THIS.this_cRegEmpresa      = ""
        THIS.this_cRegEmpresaDest  = ""
        THIS.this_cRegOperacao     = ""
        THIS.this_dRegData         = {/:}
        THIS.this_dRegPrazoEntrega = {/:}
        THIS.this_cRegGrupoOrigem  = ""
        THIS.this_cRegGrupoDestino = ""
        THIS.this_cRegContaOrigem  = ""
        THIS.this_cRegContaDestino = ""
        THIS.this_nRegNumeroOp     = 0
        THIS.this_nRegNumero       = 0
        THIS.this_cRegVendedor     = ""
        THIS.this_lRegBaixada      = .F.
        THIS.this_cRegStatus       = ""
        THIS.this_cRegChave        = ""

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LerCampoCursor - le um campo do cursor corrente pelo NOME, devolvendo o
    * valor padrao quando o campo nao existe ou vem NULL.
    *
    * EVALUATE eh o caminho CERTO para LEITURA por nome (regra #15); e a
    * existencia do campo se testa com TYPE(alias + "." + campo), NUNCA com
    * PEMSTATUS - PEMSTATUS exige objeto no 1o argumento e dispara erro 11 com
    * alias de cursor.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LerCampoCursor(par_cAlias, par_cCampo, par_uPadrao)
        LOCAL loc_uValor

        loc_uValor = par_uPadrao

        IF TYPE(par_cAlias + "." + par_cCampo) != "U"
            loc_uValor = TratarNulo(EVALUATE(par_cAlias + "." + par_cCampo), par_uPadrao)
        ENDIF

        RETURN loc_uValor
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarChaveEmpDopNums - monta a chave composta EmpDopNums de SigMvCab.
    *
    * Legado (mesma montagem usada em todo o sistema Fortyus):
    *   lcEmpDopNums = <cursor>.Emps + <cursor>.Dopes + Str(<cursor>.Numes, 6)
    *
    * A chave eh POSICIONAL: o padding faz parte dela. Por isso as partes vao
    * com PADR na largura EXATA da coluna do schema, NUNCA com ALLTRIM - a
    * conferencia eh a largura do destino:
    *   emps char(3) + dopes char(20) + Str(numes, 6) = 29 = empdopnums char(29)
    * Com ALLTRIM nas partes a chave encurta, o WHERE nunca casa e o SELECT
    * devolve ZERO linhas em silencio (regra #42 do CLAUDE.md).
    *--------------------------------------------------------------------------
    PROCEDURE MontarChaveEmpDopNums(par_cEmps, par_cDopes, par_nNumes)
        RETURN PADR(NVL(par_cEmps, ""), 3) + ;
               PADR(NVL(par_cDopes, ""), 20) + ;
               STR(NVL(par_nNumes, 0), 6)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - carrega a linha CORRENTE do cursor de resultado nas
    * propriedades this_cReg* / this_nReg* / this_dReg* / this_lReg*.
    *
    * Sao as colunas de SigMvCab que o legado nomeia no consulta.Click; o
    * cursor vem de "Select a.* From SigMvCab a, SigCdOpe b", logo todas estao
    * presentes. NAO move o ponteiro do cursor: quem posiciona eh o chamador
    * (BuscarMovimentacao faz GO TOP, como o "Go Top In csTemporario" legado).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAlias, loc_lSucesso, loc_uChave, loc_oErro

        loc_lSucesso = .F.
        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
                         ALLTRIM(par_cAliasCursor), THIS.this_cCursorResultado)

        IF !USED(loc_cAlias)
            THIS.this_cMensagemErro = "Cursor [" + loc_cAlias + "] n" + CHR(227) + "o est" + CHR(225) + " aberto."
            THIS.LimparLinhaCorrente()
            RETURN .F.
        ENDIF

        IF EOF(loc_cAlias)
            THIS.LimparLinhaCorrente()
            RETURN .F.
        ENDIF

        TRY
            *-- Padrao obrigatorio: SELECT (alias) ANTES de acessar campos
            SELECT (loc_cAlias)

            THIS.this_cRegEmpresa      = ALLTRIM(THIS.LerCampoCursor(loc_cAlias, "emps", ""))
            THIS.this_cRegEmpresaDest  = ALLTRIM(THIS.LerCampoCursor(loc_cAlias, "empds", ""))
            THIS.this_cRegOperacao     = ALLTRIM(THIS.LerCampoCursor(loc_cAlias, "dopes", ""))
            THIS.this_dRegData         = THIS.LerCampoCursor(loc_cAlias, "datas", {/:})
            THIS.this_dRegPrazoEntrega = THIS.LerCampoCursor(loc_cAlias, "prazoents", {/:})
            THIS.this_cRegGrupoOrigem  = ALLTRIM(THIS.LerCampoCursor(loc_cAlias, "grupoos", ""))
            THIS.this_cRegGrupoDestino = ALLTRIM(THIS.LerCampoCursor(loc_cAlias, "grupods", ""))
            THIS.this_cRegContaOrigem  = ALLTRIM(THIS.LerCampoCursor(loc_cAlias, "contaos", ""))
            THIS.this_cRegContaDestino = ALLTRIM(THIS.LerCampoCursor(loc_cAlias, "contads", ""))
            THIS.this_nRegNumeroOp     = THIS.LerCampoCursor(loc_cAlias, "nops", 0)
            THIS.this_nRegNumero       = THIS.LerCampoCursor(loc_cAlias, "numes", 0)
            THIS.this_cRegVendedor     = ALLTRIM(THIS.LerCampoCursor(loc_cAlias, "vends", ""))
            THIS.this_cRegStatus       = ALLTRIM(THIS.LerCampoCursor(loc_cAlias, "pstatus", ""))

            *-- chksubn eh bit: chega como Logico (.T./.F.) ou Numerico (0/1)
            *-- conforme o driver ODBC - ConverterParaLogico trata os dois.
            THIS.this_lRegBaixada = ConverterParaLogico(THIS.LerCampoCursor(loc_cAlias, "chksubn", .F.))

            *-- empdopnums vem gravada na tabela; so remontamos quando vier em
            *-- branco, para nunca divergir do valor real do banco.
            loc_uChave = THIS.LerCampoCursor(loc_cAlias, "empdopnums", "")
            IF EMPTY(loc_uChave)
                loc_uChave = THIS.MontarChaveEmpDopNums(THIS.this_cRegEmpresa, ;
                                                        THIS.this_cRegOperacao, ;
                                                        THIS.this_nRegNumero)
            ENDIF
            THIS.this_cRegChave = loc_uChave

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - chave do registro corrente para a auditoria de
    * BusinessBase e para o handoff da linha selecionada. A chave de SigMvCab
    * eh a composta EmpDopNums (char(29)).
    *
    * PROTECTED porque o metodo da base tambem eh PROTECTED - subclasse nao
    * alarga escopo de hook herdado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave

        loc_cChave = THIS.this_cRegChave

        IF EMPTY(loc_cChave)
            loc_cChave = THIS.MontarChaveEmpDopNums(THIS.this_cRegEmpresa, ;
                                                    THIS.this_cRegOperacao, ;
                                                    THIS.this_nRegNumero)
        ENDIF

        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * DESTROY - libera o cursor de resultado da consulta
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Movimentacao")
            USE IN cursor_4c_Movimentacao
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

