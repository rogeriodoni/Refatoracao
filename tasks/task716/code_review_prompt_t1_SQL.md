# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS, TIPOCAMPO
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'TABINDEX' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS, TIPOCAMPO

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
  ControlSource = "OPSENHA"
INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
INSERT INTO crSiTef (Tef) VALUES ("001-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("003-000 = "+lsValPago)
INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
INSERT INTO crSiTef (Tef) VALUES ("009-000 = 0")
INSERT INTO crSiTef (Tef) VALUES ("010-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("011-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("012-000 = "+lsNsu)
INSERT INTO crSiTef (Tef) VALUES ("013-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("015-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("017-000 = 0")
INSERT INTO crSiTef (Tef) VALUES ("018-000 = 1")
INSERT INTO crSiTef (Tef) VALUES ("017-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("019-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("020-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("021-000 = 0")
INSERT INTO crSiTef (Tef) VALUES ("022-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("023-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("023-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("027-000 = ")
	INSERT INTO crSiTef (Tef) VALUES ("029-"+TRANSFORM(lnLinha,"@L 999")+" = "+IIF(lsPos<>0,SUBSTR(lsCupom,1,lsPos-1),lsCupom))
INSERT INTO crSiTef (Tef) VALUES ("028-000 = "+ALLTRIM(STR(lnLinha-3)))
INSERT INTO crSiTef (Tef) VALUES ("030-000 = Transacao OK")
INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
SELECT crSitef 
INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
INSERT INTO crSiTef (Tef) VALUES ("001-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
INSERT INTO crSiTef (Tef) VALUES ("001-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("003-000 = "+lsValPago)
INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
INSERT INTO crSiTef (Tef) VALUES ("009-000 = FF")
INSERT INTO crSiTef (Tef) VALUES ("010-000 = 05")
INSERT INTO crSiTef (Tef) VALUES ("028-000 = 0")
INSERT INTO crSiTef (Tef) VALUES ("030-000 = "+lcMensagem)
INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
SELECT crSitef 
INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
INSERT INTO crSiTef (Tef) VALUES ("001-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
		.AddCursor('SigCdEmp','cEmps','crSigCdEmp','cEmps',.f.,[Select * From SigCdEmp Where cEmps = ?_Empr])

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpCtf.prg) - TRECHOS RELEVANTES PARA PASS SQL (2137 linhas total):

*-- Linhas 95 a 113:
95: * generico de pipeline para esta fase pede "BtnIncluirClick/BtnAlterarClick/
96: * BtnVisualizarClick/BtnExcluirClick" (template CRUD) - NAO SE APLICA aqui
97: * pelo MESMO motivo ja registrado na nota da Fase 4 abaixo (zero Grid, zero
98: * INSERT/UPDATE/DELETE, zero "modo LISTA"). O que a Fase 7 realmente
99: * entrega, porque e o que falta no roadmap desde a Fase 6 ("NAO ENTRAM NESTA
100: * FASE" abaixo), e o laco de SIGOPCTF.SENHA/GetDigitos/GetCartao/GetCodSeg
101: * GotFocus/LostFocus (SENHA/GetDigitos/GetCartao/GetCodSeg - Text2 continua
102: * FORA, vestigial) + SAIDA.CANCELA.Click + RetornoFalha/MontaRetorno (do
103: * FORM, nao do BO - mesmo lugar do sibling Formsigprdft) + os 3 DECLARE-DLL/
104: * ConectarSiTef/IniciarSiTef/ContinuarSiTef novos em SigOpCtfBO.prg. Ver o
105: * bloco "LACO INTERATIVO COM O TERMINAL SITEF" mais abaixo, antes de
106: * TornarControlesVisiveis, para a documentacao metodo a metodo.
107: *
108: * O handshake (ConfiguraIntSiTefInterativo/IniciaFuncaoSiTefInterativo, no
109: * Init legado) foi deslocado para SenhaGotFocus (POS-Show) em vez de
110: * InicializarForm (PRE-Show) - ver cabecalho de SenhaGotFocus para a
111: * justificativa (regra CLAUDE.md #29). A leitura de SigCdEmp/SIGFIMPF e a
112: * montagem de lsIdTerminal/lcIdTerminal (CarregarDadosEmpresaSiTef, que
113: * substitui as linhas do Init legado ANTES do handshake) continuam em

*-- Linhas 124 a 153:
124: *
125: * NAO existem aqui PageFrame, pagina Lista/Dados nem botoes CRUD
126: * canonicos: o dump nao tem grade (analise.json: "temGrid": false) nem
127: * INSERT/UPDATE/DELETE algum (comportamento.json: zero queries SQL fora
128: * do CREATE CURSOR local de MontaRetorno/RetornoFalha) - inventar essas
129: * estruturas violaria o PILAR 1 e a regra de nunca inventar
130: * funcionalidade ausente do original.
131: *
132: *------------------------------------------------------------------------------
133: * FASE 4/8 - "Grid e botoes CRUD (Page1)" no template generico. NAO SE
134: * APLICA a este legado e NAO ACRESCENTA NADA a este arquivo.
135: *
136: * Medido contra o dump (layout.json/analise.json/comportamento.json, task716):
137: * zero "BaseClass: grid|pageframe|listbox", zero AddCursor/pColuna/Grade/grd,
138: * e os unicos ControlSource do form sao os escalares this_* lidos via
139: * Init/PARAMETERS - nao ha superficie de LISTA (nem Page1) para desenhar
140: * Grid, e por isso tambem nao ha "modo LISTA" que justifique os 5 botoes
141: * CRUD canonicos (Incluir/Visualizar/Alterar/Excluir/Buscar). O form eh um
142: * dialogo CAPTURA de dados (Valor, 4 Ultimos Digitos, Senha, Cartao, Codigo
143: * de Seguranca) que dialoga com o terminal via DLL - perfil igual ao
144: * DESPACHANTE/CAPTURA ja documentado em
145: * docs/FORMCOR_LICOES_APRENDIDAS.md e nas licoes de gate das Fases 4-8
146: * (SIGOPCHP/task699, SIGOPCTD/task715 e SIGOPCRP/task714, todos sem Grid
147: * nem CRUD). A unica acao de saida do dialogo (botao CANCELA/obj_4c_SAIDA)
148: * ja foi entregue na Fase 3 (ConfigurarSaida) porque e' estrutural, nao
149: * depende de nenhum campo ainda nao criado, e equivale ao bloco de saida
150: * dos forms CRUD - nao ha "Incluir/Alterar/Excluir" a inventar para um
151: * dialogo de confirmacao de cancelamento TEF.
152: *
153: * Os campos de dados (Fases 5-6) e o laco interativo com o terminal mais o

*-- Linhas 187 a 207:
187: *       zero lookups e grid.temGrid = false - nao ha grade nem filtro para
188: *       buscar.
189: *   BtnSalvarClick - comportamento.json: metodosComSQL = 3, mas as 14
190: *       queries listadas sao TODAS "INSERT INTO crSiTef" (cursor VFP LOCAL,
191: *       criado e destruido dentro de RetornoFalha/MontaRetorno para gerar os
192: *       arquivos C:\client\Resp\IntPos.001/.STS) - zero INSERT/UPDATE/DELETE
193: *       contra o SQL Server. Nao ha o que "salvar": o resultado do
194: *       cancelamento vai para arquivo local, nao para tabela.
195: *   FormParaBO/BOParaForm - APLICAM-SE e estao implementados. A leitura
196: *       anterior ("os valores digitados sao lidos e descartados, nunca
197: *       armazenados numa property do BO") estava ERRADA: os quatro
198: *       LostFocus do legado gravam o valor digitado em this_cBuffer, que E
199: *       uma property do BO - o transporte campo -> BO sempre existiu, so
200: *       estava INLINE e repetido QUATRO vezes, uma por campo, cada copia
201: *       repetindo "Alltrim(This.Value) + Replicate(Chr(0), ...)".
202: *       FormParaBO() passa a ser esse transporte num lugar so (Senha/4
203: *       Digitos/Cartao/Cod. Seguranca -> properties do BO) e
204: *       MontarBufferSiTef() no BO monta o buffer; BOParaForm() e o caminho
205: *       inverso, com as duas atribuicoes que o Init legado faz depois de
206: *       resolver a empresa (GetValor.Value e o Caption do Label5). Nao ha
207: *       2a via de transporte: o caminho continua UNICO (campo -> BO ->

*-- Linhas 255 a 275:
255: *                           licao "closable inventado tira a unica saida").
256: *                           Fica no default .T. - o usuario pode fechar por
257: *                           Alt+F4 alem do botao CANCELA.
258: *   SAIDA.ControlSource = "OPSENHA" - vestigio da classe Grupo_Saida do
259: *                           Framework legado (CommandGroup normalmente nao
260: *                           tem ControlSource com efeito util); sem
261: *                           equivalente na nova arquitetura, nao transcrito.
262: *   Command1.Name = "CANCELA" - renomear o membro do CommandGroup nao e
263: *                           necessario: acesso via .Buttons(1), como no
264: *                           padrao do projeto (FormSIGPRTFH).
265: *==============================================================================
266: 
267: DEFINE CLASS FormSigOpCtf AS FormBase
268: 
269:     *-- Propriedades visuais (PILAR 1: identico ao legado SIGOPCTF.SCX)
270:     Width       = 463
271:     Height      = 295
272:     BorderStyle = 2
273:     AutoCenter  = .T.
274:     Caption     = "Cancelamento de SiTef"
275:     ControlBox  = .F.

*-- Linhas 1372 a 1410:
1372:             IF USED("crSiTef")
1373:                 USE IN crSiTef
1374:             ENDIF
1375:             CREATE CURSOR crSiTef (tef c(100))
1376: 
1377:             INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
1378:             INSERT INTO crSiTef (Tef) VALUES ("001-000 = ")
1379:             INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
1380:             INSERT INTO crSiTef (Tef) VALUES ("003-000 = " + loc_cValPago)
1381:             INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
1382:             INSERT INTO crSiTef (Tef) VALUES ("009-000 = FF")
1383:             INSERT INTO crSiTef (Tef) VALUES ("010-000 = 05")
1384:             INSERT INTO crSiTef (Tef) VALUES ("028-000 = 0")
1385:             INSERT INTO crSiTef (Tef) VALUES ("030-000 = " + loc_cMensagem)
1386:             INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
1387:             INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
1388: 
1389:             SELECT crSiTef
1390:             COPY TO C:\client\Resp\IntPos.001 SDF
1391:             ZAP
1392: 
1393:             INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
1394:             INSERT INTO crSiTef (Tef) VALUES ("001-000 = ")
1395:             INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
1396: 
1397:             COPY TO C:\client\Resp\IntPos.STS SDF
1398: 
1399:             USE IN crSiTef
1400:         CATCH TO loc_oErro
1401:             MsgErro(loc_oErro.Message, "Erro ao gravar retorno SiTef")
1402:         ENDTRY
1403:     ENDPROC
1404: 
1405:     *--------------------------------------------------------------------------
1406:     * MontaRetorno - migrado de SIGOPCTF.montaretorno. Grava os mesmos
1407:     * arquivos SDF de RetornoFalha, com o NSU e o cupom (texto multi-linha,
1408:     * dividido por CHR(10) - igual ao legado) da transacao CANCELADA com
1409:     * sucesso. par_cValPago existe so para casar com a assinatura do UNICO
1410:     * call site do dump (ThisForm.MontaRetorno(lcTef, lcNsu, lcValPago)) -

*-- Linhas 1424 a 1487:
1424:             IF USED("crSiTef")
1425:                 USE IN crSiTef
1426:             ENDIF
1427:             CREATE CURSOR crSiTef (tef c(100))
1428: 
1429:             INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
1430:             INSERT INTO crSiTef (Tef) VALUES ("001-000 = ")
1431:             INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
1432:             INSERT INTO crSiTef (Tef) VALUES ("003-000 = " + loc_cValPago)
1433:             INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
1434:             INSERT INTO crSiTef (Tef) VALUES ("009-000 = 0")
1435:             INSERT INTO crSiTef (Tef) VALUES ("010-000 = ")
1436:             INSERT INTO crSiTef (Tef) VALUES ("011-000 = ")
1437:             INSERT INTO crSiTef (Tef) VALUES ("012-000 = " + IIF(VARTYPE(par_cNsu) = "C", par_cNsu, ""))
1438:             INSERT INTO crSiTef (Tef) VALUES ("013-000 = ")
1439:             INSERT INTO crSiTef (Tef) VALUES ("015-000 = ")
1440:             INSERT INTO crSiTef (Tef) VALUES ("017-000 = 0")
1441:             INSERT INTO crSiTef (Tef) VALUES ("018-000 = 1")
1442:             INSERT INTO crSiTef (Tef) VALUES ("017-000 = ")
1443:             INSERT INTO crSiTef (Tef) VALUES ("019-000 = ")
1444:             INSERT INTO crSiTef (Tef) VALUES ("020-000 = ")
1445:             INSERT INTO crSiTef (Tef) VALUES ("021-000 = 0")
1446:             INSERT INTO crSiTef (Tef) VALUES ("022-000 = ")
1447:             INSERT INTO crSiTef (Tef) VALUES ("023-000 = ")
1448:             INSERT INTO crSiTef (Tef) VALUES ("023-000 = ")
1449:             INSERT INTO crSiTef (Tef) VALUES ("027-000 = ")
1450: 
1451:             loc_cCupomRestante = IIF(VARTYPE(par_cCupom) = "C", par_cCupom, "")
1452:             loc_nPos   = 1
1453:             loc_nLinha = 1
1454:             DO WHILE loc_nPos != 0
1455:                 loc_nPos = AT(CHR(10), loc_cCupomRestante)
1456:                 INSERT INTO crSiTef (Tef) VALUES ("029-" + TRANSFORM(loc_nLinha, "@L 999") + " = " + ;
1457:                     IIF(loc_nPos != 0, SUBSTR(loc_cCupomRestante, 1, loc_nPos - 1), loc_cCupomRestante))
1458:                 loc_cCupomRestante = SUBSTR(loc_cCupomRestante, loc_nPos + 1)
1459:                 loc_nLinha = loc_nLinha + 1
1460:             ENDDO
1461:             INSERT INTO crSiTef (Tef) VALUES ("028-000 = " + ALLTRIM(STR(loc_nLinha - 3)))
1462:             INSERT INTO crSiTef (Tef) VALUES ("030-000 = Transacao OK")
1463:             INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
1464:             INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
1465: 
1466:             SELECT crSiTef
1467:             COPY TO C:\client\Resp\IntPos.001 SDF
1468:             ZAP
1469: 
1470:             INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
1471:             INSERT INTO crSiTef (Tef) VALUES ("001-000 = ")
1472:             INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
1473: 
1474:             COPY TO C:\client\Resp\IntPos.STS SDF
1475: 
1476:             USE IN crSiTef
1477:         CATCH TO loc_oErro
1478:             MsgErro(loc_oErro.Message, "Erro ao gravar retorno SiTef")
1479:         ENDTRY
1480:     ENDPROC
1481: 
1482:     *--------------------------------------------------------------------------
1483:     * BtnCancelaClick - migrado de SIGOPCTF.SAIDA.CANCELA.Click. Unica acao
1484:     * de saida do dialogo - cancela a transacao (Continua...(-1)) e grava a
1485:     * falha. PUBLIC: exigido por BINDEVENT.
1486:     *--------------------------------------------------------------------------
1487:     PROCEDURE BtnCancelaClick()


### BO (C:\4c\projeto\app\classes\SigOpCtfBO.prg):
*============================================================================
* SigOpCtfBO.prg - Business Object para Cancelamento de SiTef
*
* Tabela de referencia : SigCdEmp (PK: cemps char(3))
* Form OPERACIONAL     : FormSigOpCtf - cancelamento de transacao TEF
*                        (comunicacao com CliSiTef32I.DLL via protocolo
*                        interativo SiTef; formatos IntPos.001/IntPos.STS)
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SigOpCtfBO AS BusinessBase

    *==========================================================================
    * Propriedades da entidade SigCdEmp (dados da empresa usados na integracao
    * com o SiTef - endereco do terminal e identificacao da empresa)
    *==========================================================================
    this_cCodEmpresa      = ""    && char(3)  - SigCdEmp.cemps (PK)
    this_nCodEmpresaNum   = 0     && numeric(3,0) - SigCdEmp.nemps
    this_cRazaoSocial     = ""    && char(40) - SigCdEmp.razas
    this_cCodEmpresaSiTef = ""    && char(3)  - SigCdEmp.cempsitefs

    *==========================================================================
    * Propriedades da transacao de cancelamento (parametros recebidos pelo
    * form na abertura - par_cEndSiTef/par_cIdTerminal/... do Init legado)
    *==========================================================================
    this_cEndSiTef   = ""    && Endereco do servidor SiTef
    this_cIdTerminal = ""    && Codigo do estabelecimento/terminal
    this_nValorPago  = 0     && Valor da transacao a cancelar
    this_cTipoPgto   = ""    && "D"=Debito, "C"=Credito
    this_dDataTrans  = {}    && Data da transacao original
    this_cNsu        = ""    && NSU da transacao original
    this_cCartao     = ""    && "S" = exige digitacao da validade do cartao
    this_lImpressora = .F.   && .T. quando o caixa possui impressora fiscal
    this_cCodEstabs  = ""    && Codigo alternativo do estabelecimento (PDV)
    this_lCancelado  = .T.   && Espelha llCancel do legado (.T. = nao cancelado)

    *==========================================================================
    * Mensagem de retorno do protocolo SiTef (ultima falha reportada)
    *==========================================================================
    this_cMensagemSiTef = ""

    *==========================================================================
    * Estado do protocolo interativo (migrado das variaveis PUBLIC do legado:
    * ProximoComando, TipoCampo, TamanhoMinimo, TamanhoMaximo, Buffer,
    * lnContinua). Centralizado aqui porque ContinuarSiTef() precisa passar
    * os quatro primeiros POR REFERENCIA para a DLL, e VFP9 nao garante
    * passagem por referencia de property de objeto direto para DLL externa
    * (mesmo criterio de sigprdftBO.ContinuarSiTef).
    *==========================================================================
    this_nProximoComando = 0
    this_nTipoCampo      = 0
    this_nTamanhoMinimo  = 0
    this_nTamanhoMaximo  = 0
    this_cBuffer          = SPACE(2000)
    this_nContinua        = 0

    *==========================================================================
    * Identificacao do terminal SiTef (migrado do bloco de Init legado que
    * monta lsIdTerminal/lcIdTerminal a partir de SigCdEmp/SigFiMpF).
    *   this_cLojaSiTef          <- lsIdTerminal (2o arg de
    *                               ConfiguraIntSiTefInterativo - "lsLoja")
    *   this_cIdTerminalCompleto <- lcIdTerminal (3o arg - "lsTerminal")
    *   this_cCaixaSiTef         <- crSigFiMpF.Cncaixas (ver CarregarCaixaSiTef)
    *==========================================================================
    this_cLojaSiTef          = ""
    this_cIdTerminalCompleto = ""
    this_cCaixaSiTef         = ""

    *==========================================================================
    * Campos DIGITAVEIS do dialogo, transportados por
    * FormSigOpCtf.FormParaBO() / devolvidos por BOParaForm().
    *
    * O legado le This.Value DENTRO de cada LostFocus e monta o buffer ali
    * mesmo, repetindo a expressao quatro vezes:
    *     SENHA.LostFocus      Buffer = Alltrim(this.Value) + Replicate(Chr(0), 2000 - Len(Alltrim(this.Value)))
    *     GetDigitos.LostFocus Buffer = ALLTRIM(This.Value) + REPLICATE(CHR(0), 1996)
    *     GetCartao.LostFocus  Buffer = ALLTRIM(This.Value) + REPLICATE(CHR(0), 2000-LEN(ALLTRIM(This.Value)))
    *     GetCodSeg.LostFocus  Buffer = Alltrim(This.Value) + REPLICATE(CHR(0), 2000-LEN(Alltrim(This.Value)))
    *
    * Guardar o valor digitado aqui NAO acrescenta uma 2a via de transporte:
    * ele continua tendo UM caminho (campo -> BO -> this_cBuffer -> DLL), com
    * a diferenca de que a montagem do buffer passa a existir num lugar so
    * (MontarBufferSiTef) em vez de quatro copias da mesma expressao.
    *==========================================================================
    this_cSenhaSupervisor = ""   && SENHA.Value      - senha do supervisor
    this_cUltimosDigitos  = ""   && GetDigitos.Value - 4 ultimos digitos / validade
    this_cNumeroCartao    = ""   && GetCartao.Value  - numero do cartao
    this_cCodSeguranca    = ""   && GetCodSeg.Value  - codigo de seguranca

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdEmp"
            THIS.this_cCampoChave = "cemps"
            THIS.DeclararFuncoesSiTef()
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * DeclararFuncoesSiTef - DECLARE-DLL das 3 funcoes do protocolo interativo
    * (migrado de SIGOPCTF.Load - este form NAO declara
    * FinalizaTransacaoSiTefInterativo, ao contrario de SIGPRDFT/SIGPRTFH:
    * cancelamento nunca finaliza uma venda, so desfaz). Redeclarar a mesma
    * assinatura eh inofensivo em VFP9; a falha real (DLL ausente) so
    * aparece quando a funcao eh CHAMADA, nao na declaracao - por isso o TRY
    * aqui eh so para nao derrubar InicializarForm em maquina sem o
    * CliSiTef32I.DLL (mesmo criterio de sigprdftBO.DeclararFuncoesSiTef).
    *==========================================================================
    PROTECTED PROCEDURE DeclararFuncoesSiTef()
        LOCAL loc_oErro

        TRY
            DECLARE INTEGER ConfiguraIntSiTefInterativo IN "CliSiTef32I.DLL" ;
                STRING lsEndereco, STRING lsLoja, STRING lsTerminal, INTEGER lnReservado

            DECLARE INTEGER IniciaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                INTEGER lnModalidade, STRING lsValor, STRING lsCupom, STRING lsData, ;
                STRING lsHorario, STRING lsOperador, STRING lsRestricao

            DECLARE INTEGER ContinuaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                INTEGER @lnComando, INTEGER @lnTipo, INTEGER @lnMinimo, INTEGER @lnMaximo, ;
                STRING @lsBuffer, INTEGER lnTamanho, INTEGER lnResultado
        CATCH TO loc_oErro
            *-- DLL nao presente nesta maquina (dev/pipeline sem PIN-pad
            *-- SiTef) - a chamada real avisa o usuario via ConectarSiTef.
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarCaixaSiTef - Migrado do trecho do Init legado que le
    * crSigFiMpF.Cncaixas (cursor global do Framework, nunca populado em
    * nenhum ponto do dump deste form - mesma categoria de dependencia
    * ausente tratada em sigprdftBO.CarregarParametrosOperacao). Em vez de
    * depender de cursor global nao documentado, consulta SIGFIMPF pela
    * empresa corrente com o MESMO fallback "melhor esforco" do sibling:
    * sem registro, this_cCaixaSiTef fica "000000" (igual ao TRANSFORM(VAL(
    * ""),"@L 999999") que o legado produziria com o cursor vazio).
    *==========================================================================
    FUNCTION CarregarCaixaSiTef()
        LOCAL loc_oErro

        THIS.this_cCaixaSiTef = "000000"

        TRY
            IF USED("cursor_4c_SigFiMpF")
                USE IN cursor_4c_SigFiMpF
            ENDIF

            SQLEXEC(gnConnHandle, ;
                "SELECT cncaixas FROM SIGFIMPF WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa), ;
                "cursor_4c_SigFiMpF")

            IF USED("cursor_4c_SigFiMpF") AND !EOF("cursor_4c_SigFiMpF")
                THIS.this_cCaixaSiTef = TRANSFORM(VAL(TratarNulo(cursor_4c_SigFiMpF.cncaixas, "0")), "@L 999999")
            ENDIF

            IF USED("cursor_4c_SigFiMpF")
                USE IN cursor_4c_SigFiMpF
            ENDIF
        CATCH TO loc_oErro
            *-- Sem a tabela/registro, segue com o fallback "000000" acima -
            *-- mesmo desfecho pratico do legado quando crSigFiMpF esta vazio.
        ENDTRY

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * MontarIdentificacaoTerminal - Migrado de SIGOPCTF.Init:
    *     If Empty(pcCodEstabs)
    *         lsIdTerminal="00000"+_Empr
    *     Else
    *         lsIdTerminal=pcCodEstabs
    *     EndIf
    *     lcIdTerminal=fConverteStr(CrSigCdEmp.nEmps)+TRANSFORM(VAL(
    *         crSigFiMpF.Cncaixas),"@L 999999")
    *
    * _Empr e o global LEGACY -> go_4c_Sistema.cCodEmpresa (CLAUDE.md:
    * "_EMPR: NEVER use"). nEmps vem de CarregarPorCodigo (this_nCodEmpresaNum);
    * Cncaixas ja foi resolvido e formatado em CarregarCaixaSiTef
    * (this_cCaixaSiTef), entao aqui so concatena - sem repetir o TRANSFORM.
    *==========================================================================
    PROCEDURE MontarIdentificacaoTerminal(par_cCodEstabs)
        IF VARTYPE(par_cCodEstabs) = "C" AND !EMPTY(par_cCodEstabs)
            THIS.this_cLojaSiTef = par_cCodEstabs
        ELSE
            THIS.this_cLojaSiTef = "00000" + ALLTRIM(go_4c_Sistema.cCodEmpresa)
        ENDIF

        THIS.this_cIdTerminalCompleto = fConvertestr(THIS.this_nCodEmpresaNum) + THIS.this_cCaixaSiTef
    ENDPROC

    *==========================================================================
    * ConectarSiTef - Migrado de SIGOPCTF.Init:
    *     IF ConfiguraIntSiTefInterativo(lsEndSitef,lsIdTerminal,lcIdTerminal,0) <> 0
    * Retorna .T. se a comunicacao com o servidor SiTef foi estabelecida.
    *==========================================================================
    FUNCTION ConectarSiTef()
        LOCAL loc_nRetorno

        loc_nRetorno = ConfiguraIntSiTefInterativo(ALLTRIM(THIS.this_cEndSiTef), ;
            THIS.this_cLojaSiTef, THIS.this_cIdTerminalCompleto, 0)

        RETURN (loc_nRetorno = 0)
    ENDFUNC

    *==========================================================================
    * IniciarSiTef - Migrado de SIGOPCTF.Init:
    *     IF IniciaFuncaoSiTefInterativo(200, lcValPago, "1", lcData, lcHora,
    *         TRANSFORM(VAL(IdTerminal),"@L 999"), "") <> 10000
    *
    * Modalidade (200) e Cupom ("1") sao LITERAIS no legado - nao existe
    * property de cupom em SIGOPCTF (diferente de SIGPRDFT/SIGPRTFH), por
    * isso ficam fixos aqui, nao parametrizados. IdTerminal (6o argumento,
    * "lsOperador") e o PARAMETRO CRU recebido no Init do form (par_cIdTerminal
    * -> this_cIdTerminal), NAO o lsIdTerminal/lcIdTerminal computados acima -
    * dois campos homonimos no legado com fontes diferentes, transcritos tal
    * como estao.
    *==========================================================================
    FUNCTION IniciarSiTef(par_cValor, par_cData, par_cHora)
        LOCAL loc_nRetorno

        loc_nRetorno = IniciaFuncaoSiTefInterativo(200, par_cValor, "1", par_cData, ;
            par_cHora, TRANSFORM(VAL(THIS.this_cIdTerminal), "@L 999"), "")

        RETURN (loc_nRetorno = 10000)
    ENDFUNC

    *==========================================================================
    * ContinuarSiTef - Migrado das chamadas ContinuaFuncaoSiTefInterativo
    * espalhadas pelo legado (SENHA/GetDigitos/GetCartao/GetCodSeg GotFocus/
    * LostFocus, SAIDA.CANCELA.Click). Centraliza a chamada por referencia
    * (LOCAL -> DLL -> THIS.this_n*/this_cBuffer) - mesmo criterio de
    * sigprdftBO.ContinuarSiTef.
    *==========================================================================
    FUNCTION ContinuarSiTef(par_nContinua)
        LOCAL loc_nProximoComando, loc_nTipoCampo, loc_nTamanhoMinimo, ;
              loc_nTamanhoMaximo, loc_cBuffer, loc_nRetorno

        loc_nProximoComando = THIS.this_nProximoComando
        loc_nTipoCampo      = THIS.this_nTipoCampo
        loc_nTamanhoMinimo  = THIS.this_nTamanhoMinimo
        loc_nTamanhoMaximo  = THIS.this_nTamanhoMaximo
        loc_cBuffer         = IIF(EMPTY(THIS.this_cBuffer), SPACE(2000), THIS.this_cBuffer)

        loc_nRetorno = ContinuaFuncaoSiTefInterativo(@loc_nProximoComando, @loc_nTipoCampo, ;
            @loc_nTamanhoMinimo, @loc_nTamanhoMaximo, @loc_cBuffer, LEN(loc_cBuffer), par_nContinua)

        THIS.this_nProximoComando = loc_nProximoComando
        THIS.this_nTipoCampo      = loc_nTipoCampo
        THIS.this_nTamanhoMinimo  = loc_nTamanhoMinimo
        THIS.this_nTamanhoMaximo  = loc_nTamanhoMaximo
        THIS.this_cBuffer         = loc_cBuffer

        RETURN loc_nRetorno
    ENDFUNC

    *==========================================================================
    * MontarBufferSiTef - carrega this_cBuffer com o valor digitado pelo
    * usuario, completado com CHR(0) ate o tamanho que
    * ContinuaFuncaoSiTefInterativo espera.
    *
    * Transcrito do legado, que repete a MESMA expressao em cada LostFocus
    * (ver o bloco de properties this_cSenhaSupervisor..this_cCodSeguranca).
    * par_nComplemento existe para preservar a segunda forma, LITERAL, do
    * GetDigitos.LostFocus - "REPLICATE(CHR(0), 1996)" - em vez de recalcular
    * 2000 - LEN(): 1996 = 2000 - 4 porque GetDigitos.Valid so aceita 4
    * caracteres, entao as duas formas coincidem no caminho normal, mas
    * transcrever a do legado evita divergir se o campo chegar com outro
    * tamanho (regra CLAUDE.md #17 - transcrever, nunca reescrever).
    * Omitido, usa 2000 - LEN(ALLTRIM(valor)), como nos outros tres campos.
    *==========================================================================
    FUNCTION MontarBufferSiTef(par_cValor, par_nComplemento)
        LOCAL loc_cValor, loc_nComplemento

        loc_cValor = IIF(VARTYPE(par_cValor) = "C", ALLTRIM(par_cValor), ;
            ALLTRIM(TRANSFORM(par_cValor)))

        IF VARTYPE(par_nComplemento) = "N" AND par_nComplemento > 0
            loc_nComplemento = par_nComplemento
        ELSE
            loc_nComplemento = 2000 - LEN(loc_cValor)
        ENDIF

        IF loc_nComplemento < 0
            loc_nComplemento = 0
        ENDIF

        THIS.this_cBuffer = loc_cValor + REPLICATE(CHR(0), loc_nComplemento)

        RETURN THIS.this_cBuffer
    ENDFUNC

    *==========================================================================
    * NOTA DE ARQUITETURA - SOMENTE LEITURA (SigCdEmp)
    *
    * O dump do legado (tasks\task716\SigOpCtf_form_codigo_fonte.txt) faz UMA
    * UNICA operacao de banco, dentro do Init:
    *
    *     .poDatamgr = CreateObject('fSqlConector', ThisForm.Name)
    *     .AddCursor('SigCdEmp','cEmps','crSigCdEmp','cEmps',.f.,
    *         [Select * From SigCdEmp Where cEmps = ?_Empr])
    *     .Requery('crSigCdEmp')
    *     lsEmp = fConverteStr(CrSigCdEmp.nEmps)
    *
    * Um SELECT, usado so para obter o numero da empresa (nEmps) e montar o
    * IdTerminal exigido pelo protocolo SiTef (ConfiguraIntSiTefInterativo).
    * Em NENHUM metodo do dump - Init, Load, Unload, MontaRetorno,
    * RetornoFalha, nem nos handlers de GetValor/Text2/GetDigitos/SENHA/
    * GetCartao/GetCodSeg - ha INSERT, UPDATE, DELETE ou TABLEUPDATE sobre
    * SigCdEmp. A tela cancela uma transacao de cartao via DLL
    * (CliSiTef32I.DLL) e grava arquivos LOCAIS (C:\client\Resp\IntPos.001 e
    * IntPos.STS), nunca grava no banco de dados.
    *
    * Por isso:
    *   - Inserir(), Atualizar() e ExecutarExclusao() NAO sao sobrescritos
    *     aqui - o comportamento herdado de BusinessBase (recusar a operacao
    *     e deixar o motivo em this_cMensagemErro, reportado pelo
    *     ExibirFalha de Salvar()/Excluir()) ja eh o correto. Sobrescrever
    *     exigiria inventar uma lista de colunas de gravacao que o legado
    *     nunca grava, o que a regra #22 do CLAUDE.md proibe;
    *   - RegistrarAuditoria() tambem fica herdado e nunca eh chamado por
    *     este BO: sem Inserir()/Atualizar() proprios nao ha operacao de
    *     escrita para auditar, e forcar uma linha em LogAuditoria aqui
    *     registraria uma gravacao que nunca aconteceu;
    *   - CarregarPorCodigo() e CarregarDoCursor() SAO implementados abaixo,
    *     porque reproduzem fielmente a UNICA leitura que o legado faz.
    *==========================================================================

    *==========================================================================
    * CarregarPorCodigo - Carrega os dados da empresa (SigCdEmp) usados na
    * montagem do protocolo SiTef, pelo codigo informado (cemps).
    *
    * Legado (Init): AddCursor('SigCdEmp','cEmps','crSigCdEmp','cEmps',.f.,
    * [Select * From SigCdEmp Where cEmps = ?_Empr]) + Requery('crSigCdEmp').
    *
    * par_cCodEmpresa: codigo da empresa (SigCdEmp.cemps). Quando omitido ou
    * vazio, usa go_4c_Sistema.cCodEmpresa - equivalente ao _Empr do legado
    * (CLAUDE.md: "_EMPR: LEGACY - NEVER use -> go_4c_Sistema.cCodEmpresa").
    *
    * Retorno: .T. se encontrou e carregou o registro, .F. caso contrario
    * (this_cMensagemErro fica preenchido com o motivo).
    *==========================================================================
    FUNCTION CarregarPorCodigo(par_cCodEmpresa)
        LOCAL loc_cCodigo, loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF VARTYPE(par_cCodEmpresa) = "C" AND !EMPTY(ALLTRIM(par_cCodEmpresa))
                loc_cCodigo = ALLTRIM(par_cCodEmpresa)
            ELSE
                loc_cCodigo = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            ENDIF

            IF EMPTY(loc_cCodigo)
                THIS.this_cMensagemErro = "C" + CHR(243) + "digo de empresa n" + CHR(227) + "o informado."
            ELSE
                loc_cSQL = "SELECT cemps, nemps, razas, cempsitefs" + ;
                           " FROM SigCdEmp" + ;
                           " WHERE cemps = " + EscaparSQL(loc_cCodigo)

                IF USED("cursor_4c_Empresa")
                    IF CURSORGETPROP("Buffering", "cursor_4c_Empresa") > 1
                        TABLEREVERT(.T., "cursor_4c_Empresa")
                    ENDIF
                    USE IN cursor_4c_Empresa
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Empresa")

                IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Empresa") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Empresa")
                ELSE
                    THIS.this_cMensagemErro = "Empresa " + loc_cCodigo + " n" + CHR(227) + ;
                        "o encontrada em SigCdEmp." + CHR(13) + CapturarErroSQL()
                ENDIF

                IF USED("cursor_4c_Empresa")
                    USE IN cursor_4c_Empresa
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro em SigOpCtfBO.CarregarPorCodigo: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Popula this_cCodEmpresa/this_nCodEmpresaNum/
    * this_cRazaoSocial/this_cCodEmpresaSiTef a partir do cursor aberto por
    * CarregarPorCodigo.
    *
    * SELECT (par_cAliasCursor) antes de acessar os campos - NUNCA
    * "campo" (FORMCOR_LICOES_APRENDIDAS.md, Problema 9: essa
    * sintaxe nao existe em VFP9 e estoura "Function name is missing )").
    *
    * PROTECTED: so eh usado internamente por CarregarPorCodigo. O ponto de
    * entrada PUBLIC para o Form eh CarregarPorCodigo (regra #51 do
    * CLAUDE.md - metodo chamado de fora nunca pode ser PROTECTED).
    *==========================================================================
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodEmpresa      = TratarNulo(cemps, "")
            THIS.this_nCodEmpresaNum   = TratarNulo(nemps, 0)
            THIS.this_cRazaoSocial     = TratarNulo(razas, "")
            THIS.this_cCodEmpresaSiTef = TratarNulo(cempsitefs, "")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ObterChavePrimaria - Chave da entidade de referencia (SigCdEmp.cemps),
    * usada so se algum dia RegistrarAuditoria() for acionado por uma
    * subclasse futura. PROTECTED: nunca chamado de fora (regra #51).
    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodEmpresa
    ENDFUNC

ENDDEFINE

